const skills = [
  { name: "AWS", icon: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/amazonwebservices/amazonwebservices-plain-wordmark.svg" },
  { name: "Docker", icon: "https://cdn.simpleicons.org/docker/2496ED" },
  { name: "Terraform", icon: "https://cdn.simpleicons.org/terraform/844FBA" },
  { name: "GitHub Actions", icon: "https://cdn.simpleicons.org/githubactions/2088FF" },
  { name: "Linux", icon: "https://cdn.simpleicons.org/linux/FCC624" },
  { name: "Kubernetes", icon: "https://cdn.simpleicons.org/kubernetes/326CE5" },
];

const projects = [
  { number: "01", label: "CONTAINERISED RETAIL DELIVERY", title: "Retail Platform Delivery", description: "A containerised retail website delivered to AWS through an automated pipeline.", points: ["Docker", "GitHub Actions", "AWS EC2"], flow: ["Code", "Build", "Deploy"] },
  { number: "02", label: "INFRASTRUCTURE AS CODE", title: "Infrastructure as Code Lab", description: "Reusable Terraform code that creates a secure AWS web environment from one command.", points: ["Terraform", "VPC", "Remote State"], flow: ["Plan", "Apply", "AWS"] },
  { number: "03", label: "OBSERVABILITY", title: "Service Health Monitor", description: "A monitoring service that checks application health and reports failures quickly.", points: ["Python", "CloudWatch", "Docker"], flow: ["Check", "Alert", "Respond"] },
  { number: "04", label: "KUBERNETES PLATFORM", title: "Kubernetes Application Platform", description: "A resilient application platform with rolling updates, health checks and autoscaling.", points: ["Kubernetes", "Docker", "YAML"], flow: ["Image", "Pods", "Service"] },
  { number: "05", label: "SECURE CLOUD NETWORK", title: "Secure AWS Network", description: "A multi-tier AWS network separating public services from private resources.", points: ["AWS VPC", "Terraform", "IAM"], flow: ["Public", "NAT", "Private"] },
  { number: "06", label: "CONFIGURATION AUTOMATION", title: "Automated Server Configuration", description: "Repeatable Linux server configuration that keeps environments consistent.", points: ["Ansible", "Linux", "AWS"], flow: ["Inventory", "Playbook", "Server"] },
  { number: "07", label: "STATIC WEB DELIVERY", title: "Static Website Delivery", description: "A fast, secure and low-cost website delivered globally through AWS.", points: ["S3", "CloudFront", "Route 53"], flow: ["S3", "CDN", "Users"] },
  { number: "08", label: "DELIVERY PIPELINE", title: "Jenkins Delivery Pipeline", description: "A complete build, test and deployment pipeline for a containerised application.", points: ["Jenkins", "Docker", "EC2"], flow: ["Test", "Package", "Release"] },
  { number: "09", label: "CLOUD FINOPS", title: "Cloud Cost Dashboard", description: "A reporting dashboard that highlights AWS usage and avoidable cloud costs.", points: ["Cost Explorer", "Python", "Lambda"], flow: ["Collect", "Analyse", "Alert"] },
];

function SectionTitle({ number, label, title }: { number: string; label: string; title: string }) {
  return <div className="section-title"><p>{number}. {label}</p><h2>{title}</h2><span /></div>;
}

export default function Home() {
  return <main>
    <nav className="topbar">
      <a className="brand" href="#top">MO</a>
      <div className="nav-links"><a href="#about">About</a><a href="#education-certifications">Education</a><a href="#skills">Skills</a><a href="#projects">Projects</a><a href="#contact">Contact</a></div>
      <a className="menu-button" href="#projects">MENU <span>☰</span></a>
    </nav>
    <section className="hero" id="top">
      <p className="code-label">CLOUD &amp; DEVOPS ENGINEER</p>
      <h1>Michael Osarobo</h1>
      <div className="hero-line" />
      <div className="hero-tags"><span>Junior Cloud Engineer</span><span>United Kingdom</span><span>AWS &amp; Automation</span></div>
      <p className="hero-copy">I build reliable cloud infrastructure and practical delivery pipelines using <strong>AWS, containers, Infrastructure as Code and CI/CD.</strong></p>
      <div className="hero-actions"><a className="primary-button" href="#projects">View my work ↓</a><a className="secondary-button" href="mailto:michaelosarobo222@gmail.com">Contact me ↗</a></div>
    </section>
    <section className="section" id="about">
      <SectionTitle number="01" label="ABOUT ME" title="About" />
      <div className="about-card"><p>I am a junior Cloud and DevOps engineer based in the United Kingdom. I enjoy turning manual, repeated tasks into clear and dependable automated processes.</p><p>I work with AWS, Linux, containers, Infrastructure as Code and CI/CD. I build practical projects that improve reliability, repeatability and software delivery.</p></div>
    </section>
    <section className="section" id="education-certifications">
      <SectionTitle number="02" label="BACKGROUND & QUALIFICATIONS" title="Education & Certifications" />
      <div className="qualification-links">
        <article className="qualification-block" id="education-details"><span>01</span><h3>Education</h3><div className="qualification-entry"><h4>Master’s in Management with Advanced Practice</h4><strong>Liverpool John Moores University</strong><p>Postgraduate study focused on management, leadership and advanced professional practice.</p></div><div className="education-divider" /><div className="qualification-entry"><h4>Maths and English</h4><strong>GCSE equivalent qualifications</strong><p>Credit achieved in Maths and English.</p></div></article>
        <article className="qualification-block" id="certifications-details"><span>02</span><h3>Certifications</h3><div className="qualification-entry"><h4>Technical Training</h4><ul><li>Google Data Analytics Certificate</li><li>Hands-on AWS cloud labs</li><li>Docker and containerisation training</li><li>Terraform Infrastructure as Code labs</li><li>GitHub Actions CI/CD projects</li></ul></div></article>
      </div>
    </section>
    <section className="section" id="skills">
      <SectionTitle number="03" label="TOOLS I WORK WITH" title="Skills" />
      <div className="skills-grid">{skills.map((skill) => <div className="skill-item" key={skill.name}><div className="skill-circle"><img src={skill.icon} alt="" /></div><h3>{skill.name}</h3></div>)}</div>
    </section>
    <section className="section projects-section" id="projects">
      <SectionTitle number="04" label="SELECTED WORKS" title="Projects" />
      <div className="project-grid">{projects.map((project) => <article className="project-card" key={project.number}>
        <div className="project-visual" aria-hidden="true"><div className="visual-bar"><i /><i /><i /><span>{project.number} / 09</span></div><div className="flow">{project.flow.map((item, index) => <span key={item}>{item}{index < project.flow.length - 1 && <b>→</b>}</span>)}</div></div>
        <p className="project-label">{project.number}. {project.label}</p>
        <h3>{project.title}</h3>
        <p className="project-description">{project.description}</p>
        <div className="chips">{project.points.map((point) => <span key={point}>{point}</span>)}</div>
        <div className="project-actions"><a href="https://github.com/" target="_blank" rel="noreferrer">View project ↗</a><a href="https://github.com/" target="_blank" rel="noreferrer">Documentation ↗</a></div>
      </article>)}</div>
    </section>
    <section className="section" id="contact">
      <SectionTitle number="05" label="CONNECT & WORK TOGETHER" title="Get In Touch" />
      <p className="contact-copy">I am currently looking for new opportunities. If you have a role, project or question, I would be happy to hear from you.</p>
      <div className="contact-links"><a href="https://mail.google.com/mail/?view=cm&amp;fs=1&amp;to=michaelosarobo222@gmail.com" target="_blank" rel="noreferrer"><img src="https://cdn.simpleicons.org/gmail/EA4335" alt="Gmail" /> Gmail</a><a href="https://www.linkedin.com/" target="_blank" rel="noreferrer"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/linkedin/linkedin-original.svg" alt="" /> LinkedIn</a><a href="https://github.com/" target="_blank" rel="noreferrer"><img src="https://cdn.simpleicons.org/github/111B35" alt="" /> GitHub</a></div>
      <a className="resume-button" href="mailto:michaelosarobo222@gmail.com?subject=CV%20request">↓ <span>Request My CV</span></a>
    </section>
    <footer><span>Michael Osarobo</span><span>Cloud &amp; DevOps Engineer</span><a href="#top">Back to top ↑</a></footer>
  </main>;
}
