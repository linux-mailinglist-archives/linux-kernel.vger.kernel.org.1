Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40FE2A701F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgKDWEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgKDWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:04:09 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A7AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 14:04:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g12so94715wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0/1j09rUcAFyPnpvxHz5nZjSRN/dxk0s5U/8QkdgNA=;
        b=HwYgvLrg8mzcVNGCI8z/u/uSvs0mtVZIz0K3gTZ3SFqJhOivMXYOiC98jVWiU8L6JI
         UZoaQ9tCdstyn7/1ElX8Wim0qG4TqJ90wDUppWyNCMSk/PgM8gvSy6LBtdQdCMRWindM
         x2jUJdWeRPs/8DhwZ+kalLp3xymydXLlJTmS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0/1j09rUcAFyPnpvxHz5nZjSRN/dxk0s5U/8QkdgNA=;
        b=UBfFgshPUpIwIsmM96IBm8uH2aCs3fw4QwRyKHFnkC83gzOjDm5uUqnA5FxdL+cEH9
         UCqRXc3wnZmvYTif7QIldy7+4pvmvnwR0e9bMnCNpS4Py6wTWtDfPnXzCeYhr5oA2ag0
         tIwiFz+gi2XoldfnHOpv/F0YpI6/xPEGZjXWHHRO+HDc/8JlBU9AOwa405a2eUOQ86FE
         wdszIDx19tvikLlA6YfkNw9yflZJoHLv2oEQEqKVEsvV63/qGC6eYTA3KdlyBgXYGoLU
         /Pw4bCp06TcjdLdQvkgezHuZZaTi/253DLgwaeNc5PtEBrFLXrfBlDBi+ZCedcz/zetx
         H4mw==
X-Gm-Message-State: AOAM533kzqS14g8Qt2sw7HBKlkCdYQj0EEcsm+qmPBDHIPsrYx0MN27R
        VvYfkl4mR86eS6cOqzInDFhRItsVFSpVfzxJc52+cQ==
X-Google-Smtp-Source: ABdhPJxm+m4YpSpu4GD/3r+WcWeIcqSuq+VYWMrYFJWuysD58l/9WgZ2ymvLo7KpiDWmKD6qT7kt4dV+nxxbQ8aSMqk=
X-Received: by 2002:adf:f80a:: with SMTP id s10mr65257wrp.275.1604527447149;
 Wed, 04 Nov 2020 14:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
 <20201029195913.5927-2-james.quinlan@broadcom.com> <20201104215050.GA4180546@bogus>
In-Reply-To: <20201104215050.GA4180546@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 4 Nov 2020 17:03:55 -0500
Message-ID: <CA+-6iNw1Z1dj8oFn8DdyVPuMUP-3+n9sKXuWYWo2rfPo5j4dkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add bindings for BrcmSTB SCMI mailbox driver
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008a8d2505b34f281b"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008a8d2505b34f281b
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 4, 2020 at 4:50 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 29, 2020 at 03:59:06PM -0400, Jim Quinlan wrote:
> > Bindings are added.  Only one interrupt is needed because
> > we do not yet employ the SCMI p2a channel.
>
> I still don't understand what this is. To repeat from v1: I thought SCMI
> was a mailbox consumer, not provider?

Hi Rob,

I'm not sure where I am implying that SCMI is a mailbox provider?
Should I not mention "SCMI" in the subject line?

This is just a mailbox driver, "consumed" by SCMI.    Our SCMI DT node
looks like this:

brcm_scmi_mailbox: brcm_scmi_mailbox@0 {
        #mbox-cells = <1>;
        compatible = "brcm,brcmstb-mbox";
};

brcm_scmi@0 {
        compatible = "arm,scmi";
        mboxes = <&brcm_scmi_mailbox 0>;;
        mbox-names = "tx";
        shmem = <&NWMBOX>;
        /* ... */
};

Please advise,
Jim Quinlan
Broadcom STB

>
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  .../bindings/mailbox/brcm,brcmstb-mbox.yaml   | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml b/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> > new file mode 100644
> > index 000000000000..797c0cc609a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +$id: http://devicetree.org/schemas/mailbox/brcm,brcmstb-mbox.yaml#
> > +
> > +title: Broadcom STB mailbox driver bindings
> > +
> > +maintainers:
> > +  - Jim Quinlan <james.quinlan@broadcom.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,brcmstb-mbox
> > +
> > +  interrupts:
> > +    items:
> > +      - description: a2p return interrupt, indicates SCMI msg completion.
> > +
> > +  "#mbox-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - "#mbox-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    mailbox {
> > +      compatible = "brcm,brcmstb-mailbox";
> > +      #mbox-cells = <1>;
> > +      interrupts = <GIC_SPI 0xc6 IRQ_TYPE_LEVEL_HIGH>;
> > +    };
> > +...
> > --
> > 2.17.1
> >
>
>

--0000000000008a8d2505b34f281b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPoV6ihOu5+J
8qC942q/j/YsNzRaeSv8ZNCkIlP7tE7eMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEwNDIyMDQwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC6/WFnbCJU1qb0gEBCYa1BrBlIEcZr
HA+kKo4umas/t7JI/BQ1rF539A6IFW1sHs1NCDTduCOk3ldHKpbzoYmcLdRN2ixa705symB8cfPj
rpOXijPlOQ5ISAd+2EwGwuAYBWImpdAmcSvNjwNXv1M/W3SzqXTJRXa7C4eMx6Nate6UsjvqnuAv
8kMgtLan4pCNC2ApzFrtNf0aNwi6rNVTfow8OBZlHKXNQT3zipm4bmI6LeKf1nFzy48besrNQbyp
SQxI9j0Bg3MRrSmhxLPzALj5T2TOVyrmsMGAMNin3zjFLCP0MwVeaPnzgh3c8vM7RDCOr2eUP0wd
9R20VDo+
--0000000000008a8d2505b34f281b--
