Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E02AEED4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKKKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgKKKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:36:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E912EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rzugPT8H3LJXJcEuZkk0eUHyb+hyV4BUo/9WAxAKkNo=; b=SlKMqVtf0qntdInM+/dTBxevQ/
        kgIDmEG/IQNpvizTqWrkWIn/LZ0OazAOyOhVn5dqJfu2dp9yUId18sZPZW2sYR5kbZO+Nmta0CdJi
        BXPyLdsDB7Rgj6oscgJ4eNdEPKsxZYkx8aXlwpvmAdGS7ZQKzAApTwtjhKeEaJ5ghZn9s+Yr9GKlg
        6A3IOiQ1oJpAZrFBfHQYHkzW92vI08iEhKLWGLrUi+9PZHIeSNCa3HdU1Jpw3F+7uYE+rbPjHqwSC
        HsdiV3qDL+1E8KJV3xcjLWTrbIpXreZMj+SJaDKqFlCuj/9/oIhJBp5LIKQ1FnXRKI+Suxrq8YDx6
        ZRJhu1Fg==;
Received: from dyn-227.woodhou.se ([90.155.92.227] helo=u3832b3a9db3152.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcnUb-0005kl-1L; Wed, 11 Nov 2020 10:36:45 +0000
Message-ID: <6b44a048de974fb6e2ecb5bf688c122b3107537d.camel@infradead.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup
 trigger/polarity helpers
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Date:   Wed, 11 Nov 2020 10:36:43 +0000
In-Reply-To: <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
References: <20201024213535.443185-20-dwmw2@infradead.org>
         <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
         <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
         <20201110061046.GA7290@nazgul.tnic>
         <87d00lgu13.fsf@nanos.tec.linutronix.de>
         <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
         <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
         <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com>
         <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
         <877dqtgkzb.fsf@nanos.tec.linutronix.de>
         <874klxghwu.fsf@nanos.tec.linutronix.de>
         <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
         <87y2j9exk2.fsf@nanos.tec.linutronix.de>
         <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org>
         <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
         <87tutwg76j.fsf@nanos.tec.linutronix.de>
         <5c86570ce3bedb90514bc1e73b96011660f520b0.camel@infradead.org>
         <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-CdVOrJPcvACKkA9P3+8A"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CdVOrJPcvACKkA9P3+8A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-11 at 10:46 +0100, Thomas Gleixner wrote:
> Looking at it now with brain awake, the XTSUP stuff is pretty much
> the same as DMAR, which I didn't realize yesterday. The affinity
> notifier muck is not needed when we have a write_msg() function which
> twiddles the bits into those other locations.

I kind of hate the fact that it's swizzling those bits through invalid
MSI messages, so I did it as its own irqdomain using
irq_domain_create_hierarchy() directly instead of
msi_create_irq_domain().

Looks something like this, although I believe I'm missing a call to
irq_domain_set_info() somewhere which means that the irq_chip
'intcapxt_controller' isn't being used at all...


diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 90a8add186e0..b68fe10aa67d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -16,6 +16,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
+#include <linux/irq.h>
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
@@ -1563,8 +1564,7 @@ static int __init init_iommu_one(struct amd_iommu *io=
mmu, struct ivhd_header *h)
 		 * for MSI address lo/hi/data, we need to check both
 		 * EFR[XtSup] and EFR[MsiCapMmioSup] for x2APIC support.
 		 */
-		if ((h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT)) &&
-		    (h->efr_reg & BIT(IOMMU_EFR_MSICAPMMIOSUP_SHIFT)))
+		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode =3D IRQ_REMAP_X2APIC_MODE;
 		break;
 	default:
@@ -1978,28 +1978,27 @@ union intcapxt {
 		destid_24_31		:  8;
 } __attribute__ ((packed));
=20
-/*
- * Setup the IntCapXT registers with interrupt routing information
- * based on the PCI MSI capability block registers, accessed via
- * MMIO MSI address low/hi and MSI data registers.
- */
-static void iommu_update_intcapxt(struct amd_iommu *iommu)
+/* We weren't actually doing anything before. Should we? */
+static void intcapxt_unmask_irq(struct irq_data *data)
 {
-	struct msi_msg msg;
-	union intcapxt xt;
-	u32 destid;
+}
+static void intcapxt_mask_irq(struct irq_data *data)
+{
+}
=20
-	msg.address_lo =3D readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
-	msg.address_hi =3D readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
-	msg.data =3D readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
=20
-	destid =3D x86_msi_msg_get_destid(&msg, x2apic_enabled());
+static int intcapxt_irqdomain_activate(struct irq_domain *domain,
+				       struct irq_data *irqd, bool reserve)
+{
+	struct amd_iommu *iommu =3D domain->host_data;
+	struct irq_cfg *cfg =3D irqd_cfg(irqd);
+	union intcapxt xt;
=20
 	xt.capxt =3D 0ULL;
-	xt.dest_mode_logical =3D msg.arch_data.dest_mode_logical;
-	xt.vector =3D msg.arch_data.vector;
-	xt.destid_0_23 =3D destid & GENMASK(23, 0);
-	xt.destid_24_31 =3D destid >> 24;
+	xt.dest_mode_logical =3D apic->dest_mode_logical;
+	xt.vector =3D cfg->vector;
+	xt.destid_0_23 =3D cfg->dest_apicid & GENMASK(23, 0);
+	xt.destid_24_31 =3D cfg->dest_apicid >> 24;
=20
 	/**
 	 * Current IOMMU implemtation uses the same IRQ for all
@@ -2008,64 +2007,117 @@ static void iommu_update_intcapxt(struct amd_iommu=
 *iommu)
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+
+	return 0;
 }
=20
-static void _irq_notifier_notify(struct irq_affinity_notify *notify,
-				 const cpumask_t *mask)
+static void intcapxt_irqdomain_deactivate(struct irq_domain *domain,
+					  struct irq_data *irqd)
 {
-	struct amd_iommu *iommu;
+	intcapxt_mask_irq(irqd);
+}
=20
-	for_each_iommu(iommu) {
-		if (iommu->dev->irq =3D=3D notify->irq) {
-			iommu_update_intcapxt(iommu);
-			break;
-		}
-	}
+
+static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned in=
t virq,
+				    unsigned int nr_irqs, void *arg)
+{
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 }
=20
-static void _irq_notifier_release(struct kref *ref)
+static void intcapxt_irqdomain_free(struct irq_domain *domain, unsigned in=
t virq,
+				    unsigned int nr_irqs)
 {
+	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
=20
-static int iommu_init_intcapxt(struct amd_iommu *iommu)
+static int intcapxt_set_affinity(struct irq_data *irqd,
+				 const struct cpumask *mask, bool force)
 {
+	struct irq_data *parent =3D irqd->parent_data;
 	int ret;
-	struct irq_affinity_notify *notify =3D &iommu->intcapxt_notify;
=20
-	/**
-	 * IntCapXT requires XTSup=3D1 and MsiCapMmioSup=3D1,
-	 * which can be inferred from amd_iommu_xt_mode.
-	 */
-	if (amd_iommu_xt_mode !=3D IRQ_REMAP_X2APIC_MODE)
-		return 0;
+	ret =3D parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret =3D=3D IRQ_SET_MASK_OK_DONE)
+		return ret;
=20
-	/**
-	 * Also, we need to setup notifier to update the IntCapXT registers
-	 * whenever the irq affinity is changed from user-space.
-	 */
-	notify->irq =3D iommu->dev->irq;
-	notify->notify =3D _irq_notifier_notify,
-	notify->release =3D _irq_notifier_release,
-	ret =3D irq_set_affinity_notifier(iommu->dev->irq, notify);
+	return intcapxt_irqdomain_activate(irqd->domain, irqd, false);
+}
+
+static struct irq_chip intcapxt_controller =3D {
+	.name                   =3D "IOMMU-MSI",
+	.irq_unmask             =3D intcapxt_unmask_irq,
+	.irq_mask               =3D intcapxt_mask_irq,
+	.irq_ack                =3D irq_chip_ack_parent,
+	.irq_retrigger          =3D irq_chip_retrigger_hierarchy,
+	.irq_set_affinity       =3D intcapxt_set_affinity,
+	.flags                  =3D IRQCHIP_SKIP_SET_WAKE,
+};
+
+static const struct irq_domain_ops intcapxt_domain_ops =3D {
+	.alloc			=3D intcapxt_irqdomain_alloc,
+	.free			=3D intcapxt_irqdomain_free,
+	.activate		=3D intcapxt_irqdomain_activate,
+	.deactivate		=3D intcapxt_irqdomain_deactivate,
+};
+
+static struct irq_domain *iommu_get_irqdomain(struct amd_iommu *iommu)
+{
+	struct irq_domain *domain =3D NULL;
+	struct fwnode_handle *fn;
+
+	fn =3D irq_domain_alloc_named_id_fwnode("AMD-Vi-MSI", iommu->index);
+	if (!fn)
+		return NULL;
+
+	domain =3D irq_domain_create_hierarchy(x86_vector_domain, 0, 0,
+					     fn, &intcapxt_domain_ops,
+					     iommu);
+	if (!domain)
+		irq_domain_free_fwnode(fn);
+
+	return domain;
+}
+
+static int iommu_setup_intcapxt(struct amd_iommu *iommu)
+{
+	struct irq_domain *domain;
+	int irq, ret;
+
+	domain =3D iommu_get_irqdomain(iommu);
+	if (!domain)
+		return -ENXIO;
+
+	irq =3D irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, NULL);
+	if (irq < 0) {
+		irq_domain_remove(domain);
+		return irq;
+	}
+
+	ret =3D request_threaded_irq(irq,
+				   amd_iommu_int_handler,
+				   amd_iommu_int_thread,
+				   0, "AMD-Vi",
+				   iommu);
 	if (ret) {
-		pr_err("Failed to register irq affinity notifier (devid=3D%#x, irq %d)\n=
",
-		       iommu->devid, iommu->dev->irq);
+		irq_domain_free_irqs(irq, 1);
+		irq_domain_remove(domain);
 		return ret;
 	}
=20
-	iommu_update_intcapxt(iommu);
 	iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
-	return ret;
+	return 0;
 }
=20
-static int iommu_init_msi(struct amd_iommu *iommu)
+static int iommu_init_irq(struct amd_iommu *iommu)
 {
 	int ret;
=20
 	if (iommu->int_enabled)
 		goto enable_faults;
=20
-	if (iommu->dev->msi_cap)
+	if (amd_iommu_xt_mode =3D=3D IRQ_REMAP_X2APIC_MODE)
+		ret =3D iommu_setup_intcapxt(iommu);
+	else if (iommu->dev->msi_cap)
 		ret =3D iommu_setup_msi(iommu);
 	else
 		ret =3D -ENODEV;
@@ -2074,10 +2126,6 @@ static int iommu_init_msi(struct amd_iommu *iommu)
 		return ret;
=20
 enable_faults:
-	ret =3D iommu_init_intcapxt(iommu);
-	if (ret)
-		return ret;
-
 	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
=20
 	if (iommu->ppr_log !=3D NULL)
@@ -2700,7 +2748,7 @@ static int amd_iommu_enable_interrupts(void)
 	int ret =3D 0;
=20
 	for_each_iommu(iommu) {
-		ret =3D iommu_init_msi(iommu);
+		ret =3D iommu_init_irq(iommu);
 		if (ret)
 			goto out;
 	}

--=-CdVOrJPcvACKkA9P3+8A
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAx
MTExMTAzNjQzWjAvBgkqhkiG9w0BCQQxIgQg4MPqgG6JSnD9MPE24vR6A+fWcwyn+YwuyTS4+Dmq
Rbswgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAC50SKBgg11ArcbMxSIciB4lXMy/PhOEVYauGSOCO+Wf2bXO5dm8ebP7GnGsH/8E
6p3mJiSUHgJo+/h9b6rfaTyfMnwi6zytz/Yg1utzkXnXx3TtuaRn3stpFeuLEQXLZnDd1vm7tIzB
SpmM8bhhTkWNrmmlbZR7r0VIm0u5eOBIFKxhmWwXjWynxXXuunH4oJnEru34VGZeQ8DHz1Mfa9m+
9ORY07l/3P3Q2a5FEwmDsk1CeUQnKGTqPS26obR5EFlZwLWtFNp4tYF67C9O0RfuPZzv4YOqNA35
CmlM0rCe1RPQZaEH2gh8a9zNIhE3twHOwlVatXKT7QGqEUjVKy0AAAAAAAA=


--=-CdVOrJPcvACKkA9P3+8A--

