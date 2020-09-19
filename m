Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB67E27107D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgISVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgISVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 17:05:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D4C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 14:05:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so8947776wrn.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxkMNFMe2QET3HT0ythlro3LYlICUFzoc8M045H0FV0=;
        b=XluWmoep/1Ic1aMDEEw9yiPACBzWq4UwOahWkP96PBNVsyj/mxoRrzi85liNrGsPtT
         eaCP74kb/C4JFrdsjfDWFkE4/6rJh9cP0YgPi9PcM3QCLQTGFkWzAF53C+q0N9S5ypxQ
         S2ie3kj/GNJ2oEtQw0TVlFLWdBK9+bIsT8Y8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxkMNFMe2QET3HT0ythlro3LYlICUFzoc8M045H0FV0=;
        b=nRxOJ5a7RidUDCrV23JtZU7B+BRGLBi3zj3N9ros7P/pjP6oGNYnjD2hSCBGJHuqZv
         t2dAEu25eKeQ4NVtIpAiB0jOj6oZ6FmgpKr98vcR/hRy+p5E4b1TYatS7FpSXaqKtnQZ
         P0g9xi5CoouHOf2o41PwsdtxERSjdwvv13ihhkI2IUbYJkfBkpQLrTNPJ1pIAfLLe5Qq
         U6luRbZ8Qudnbo3g4NPytt+XWQcb1bArmGRQ4Yz3sNawid30sFFDO2VpznRXPfpwWai1
         kOKORC/jO+a4TXSAZYSNmS2hSe1Hr4M+WhtqUyJV2wJpw1th1ojvznURnRjSPh8wzkYj
         A0gA==
X-Gm-Message-State: AOAM531ffG5qTdOLLvrPb6lUcBDgAw1921BDeVky8bWFRp+DyXWlNqDX
        PI/wZd9gNhyVmB1/17NmXCT29EfAbZ9Cn5T7QMUQJGX8q6U=
X-Google-Smtp-Source: ABdhPJxw/fNndMwCCA1p8hnc/56jAOg32YQtoeySMHsTv07EGvJEUde2wh54Lh8Vbd4qLjN/1Kz/bkmY8DhHBH95r8E=
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr44762081wrq.297.1600549509011;
 Sat, 19 Sep 2020 14:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200919192235.43872-1-james.quinlan@broadcom.com>
 <20200919192235.43872-3-james.quinlan@broadcom.com> <1cd9ed99-3392-f602-f351-b78edcfd1fc4@infradead.org>
In-Reply-To: <1cd9ed99-3392-f602-f351-b78edcfd1fc4@infradead.org>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Sat, 19 Sep 2020 17:04:57 -0400
Message-ID: <CA+-6iNyKy+XdMRBJ9HD3u0DVvpfzcbmjXyR0j6oCY=36DVEaog@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mailbox: Add Broadcom STB mailbox driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f3270405afb0f8c7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f3270405afb0f8c7
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 19, 2020 at 3:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Jim,
>
> On 9/19/20 12:22 PM, Jim Quinlan wrote:
> > ---
> >  drivers/mailbox/Kconfig           |  12 +++
> >  drivers/mailbox/Makefile          |   2 +
> >  drivers/mailbox/brcmstb-mailbox.c | 173 ++++++++++++++++++++++++++++++
> >  3 files changed, 187 insertions(+)
> >  create mode 100644 drivers/mailbox/brcmstb-mailbox.c
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 05b1009e2820..96faf1139cb9 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -254,4 +254,16 @@ config QCOM_IPCC
> >         acts as an interrupt controller for receiving interrupts from clients.
> >         Say Y here if you want to build this driver.
> >
> > +config BRCMSTB_MBOX
> > +     tristate "Broadcom STB Mailbox"
> > +     depends on ARM64 || ARM
> > +     depends on ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> > +     default ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> > +        help
>
> "help" is still indented with spaces instead of one tab.
> You probably should wait a bit to see if there are other comments on this patch
> before doing a v4.
Hi Randy,

Will fix, then wait...
>
> > +       Mailbox implementation of the Broadcom STB for the sole purposes
> > +       of SCMI communication.  This is used by the SCMI drivers to
> > +       communicate with FW that runs in EL3.  This mailbox only implements
> > +       the agent-to-platform channgel of SCMI but may be augmented in
> > +       the future to add the platform-to-agent channel.
> > +
> >  endif
> > diff --git a/drivers/mailbox/brcmstb-mailbox.c b/drivers/mailbox/brcmstb-mailbox.c
> > new file mode 100644
> > index 000000000000..27d87938b08c
> > --- /dev/null
> > +++ b/drivers/mailbox/brcmstb-mailbox.c
> > @@ -0,0 +1,173 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2017, Broadcom */
>
> 2017 is a little surprising.
Will fix.

>
>
> > +#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
> > +static int announce_msg(unsigned int mbox_num, unsigned int ch)
> > +{
> > +     struct arm_smccc_res res;
> > +
> > +     if (ch >= NUM_CHAN)
> > +             return -EIO;
> > +     arm_smccc_smc(BRCM_FID(ch), mbox_num, 0, 0, 0, 0, 0, 0, &res);
> > +     if (res.a0)
> > +             return -EIO;
> > +     return 0;
> > +}
> > +#else
> > +#error Func announce_msg() not defined for the current ARCH
> > +#endif
>
> This is handled by the Kconfig depends on clause.
> Why is it repeated here?
Will fix.

Thanks,
Jim
>
>
>
> thanks.
> --
> ~Randy
>

--000000000000f3270405afb0f8c7
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGGYTiPplkhM
TEyrcNKPaCqxz7MTvUIvq00VIF6MHkuRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxOTIxMDUwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA0Z5jo0gCAeUiVpfprZ+s1eHLcgbov
yhl9kvTEPN6k/aK0XQeAtPiRb/MeK9dpwQegZi7dsh+++r05mNLCKzA+25myEoTYnHITLt9kavnP
bOhreTmruFXjfsDSlFngzgbw5oifPcYALC9oLg/zQGOUDsdKYZ5W1rjS9oqZ/yglsj6e6Ppx10Xr
18Htqm0oRMPZoPzUgr2Mp28d6un4RZB8gejdIHUo/AEg2PUPqtbgczem/9cEv6/c5PKQld4CLXKe
k68rCwNlUzpRGTlmHYq1QlXVmzSya/QUSDloErmkZRwQkxYFj5V6cxv6d6TrGopagj5wypJYkly+
wz0Mle/5
--000000000000f3270405afb0f8c7--
