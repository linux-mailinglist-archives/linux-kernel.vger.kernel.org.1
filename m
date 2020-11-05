Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54C62A8231
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgKEP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbgKEP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:28:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE02C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:28:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v5so1994429wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gr+awG+WzldBfx5qEzXVcGRq08+GP45X+8uuqARmflc=;
        b=VCEFOm7mKc23miUVcKJviq5UdjY14oNm/lq2TgD+rZKnY5F33SZpiKctW2JJaKZbbp
         PUDKkkWCftb/dWBy9o20vm4Jlv7RUFhMduS5/mGas+vH6SGcHln/r0Or79BTBYDlBpdE
         H0k8wHUH8HILDK1fEC1ztTCR6+uwyC5gAKFP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gr+awG+WzldBfx5qEzXVcGRq08+GP45X+8uuqARmflc=;
        b=Sy9wnCaxb2mFnEGCIP19hpR2whngHixm/zM524lWKdFureaq4XTJt8JzD/wy7FaBqu
         pd9BCpe6ruKQ8zqGnAZwt/XrNCcjumH4vTzszuJSQg0hz5vKz0y3S12N8ErU0gSASdhw
         pJGsM7PXB4rGEzbupf3kkCQm155mqPONknyGbYMs7uOD4NhuY3+XD3c3ERSzUdwlCWzn
         Cqvl2HnYJTRjHxwBDhfzdXqRiWxvXEBD94P29zU7u1PV/q6kczgNXgd7CZji00dHJ+hi
         HVRY9bxSktzmJzBpIR1uLbI0UwlbvZEmdkLa7lrZ3/SJ49luJhKJ5GWvHGZ8UCb9jDRl
         4DQg==
X-Gm-Message-State: AOAM533mQrsnygg/1ChNgi8qW+h+B7cAp7aSVZAstXS6KdRJEzSjmkYs
        LoLbK4XOh3YlL/ucSA7GmGIe7FqHldvfYUKNt+GGAg==
X-Google-Smtp-Source: ABdhPJy41xJrtKBnrJhbDwqQJeAlStV7VzkLLw70AaJbZoku6Up8puNovQBOvQrR8LDW+wWh2rH0AHUb9BO6B2He7ds=
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3271088wmi.164.1604590117044;
 Thu, 05 Nov 2020 07:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
 <20201029195913.5927-2-james.quinlan@broadcom.com> <20201104215050.GA4180546@bogus>
 <CA+-6iNw1Z1dj8oFn8DdyVPuMUP-3+n9sKXuWYWo2rfPo5j4dkA@mail.gmail.com> <CAL_JsqJQA_VLhez8y6HVCdFB2DZ85KoDZ1=RtbU4Mw98aQRSxA@mail.gmail.com>
In-Reply-To: <CAL_JsqJQA_VLhez8y6HVCdFB2DZ85KoDZ1=RtbU4Mw98aQRSxA@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 5 Nov 2020 10:28:25 -0500
Message-ID: <CA+-6iNznMY78tJBeNrtyOy58DTKKPGxfgA0Pu2Rxx42YDJWV1w@mail.gmail.com>
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
        boundary="000000000000f56aab05b35dbf6a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f56aab05b35dbf6a
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 5, 2020 at 10:13 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 4, 2020 at 4:04 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > On Wed, Nov 4, 2020 at 4:50 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 03:59:06PM -0400, Jim Quinlan wrote:
> > > > Bindings are added.  Only one interrupt is needed because
> > > > we do not yet employ the SCMI p2a channel.
> > >
> > > I still don't understand what this is. To repeat from v1: I thought SCMI
> > > was a mailbox consumer, not provider?
> >
> > Hi Rob,
> >
> > I'm not sure where I am implying that SCMI is a mailbox provider?
> > Should I not mention "SCMI" in the subject line?
> >
> > This is just a mailbox driver, "consumed" by SCMI.    Our SCMI DT node
> > looks like this:
> >
> > brcm_scmi_mailbox: brcm_scmi_mailbox@0 {
> >         #mbox-cells = <1>;
> >         compatible = "brcm,brcmstb-mbox";
> > };
> >
> > brcm_scmi@0 {
> >         compatible = "arm,scmi";
> >         mboxes = <&brcm_scmi_mailbox 0>;;
> >         mbox-names = "tx";
> >         shmem = <&NWMBOX>;
> >         /* ... */
> > };
>
> Okay, that makes more sense. Though it seems like this is just adding
> a pointless level of indirection to turn an interrupt into a mailbox.
> There's nothing more to 'the mailbox' is there?
Correct.  Although you can see that it uses both interrupts and SMC
calls to get the job done.

> So why not either
> allow SCMI to have an interrupt directly
Not sure here -- perhaps the SCMI folks have an answer?

 > or have a generic irq mailbox
> driver?
The SCMI implementation doesn't offer a generic irq mailbox driver
AFAICT.  The SCMI folks recently provided  an "smc transport" driver
in "drivers/firmware/arm_scmi/smc.c" -- it is close to what we need
but is missing interrupts.

Regards,
Jim Quinlan
Broadcom STB

>
> Rob

--000000000000f56aab05b35dbf6a
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIArCiK6SrwWn
bgNMNQ7OiPjDqaQ/pln5sDA277V4qBudMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEwNTE1MjgzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBdB65ZxEfFbn/Z1MBl+8YcSGIanPiz
B/tndtc0ZKJlzug5MTRNBpHcq14dLliYxZhnOywdiIuM79zC1U4/55jZUFU8CZ/0bENyS+VmXAy+
lIKFnzA9EDcV1O19FwfVOXM40tB4WZp5YtuJfCQbwcZZ+fgYUw823hGwgz/6YRZVmXFb9kn0scwU
Bdv4eGUX+2WOsiHN9OorMjSPO/lTBxb3gFdd9ZHVYNFenvC85mIqKB1NMFXHDk8/Ugz0E+5UOCgm
OxUwXzPHzuzItYk1Tf5IvYh5+2fBYiKQnqbrRBbCVrCbnWFmNWJZSXWa1KEnJ7uB6v8FVJRjng7H
yeYHhUiH
--000000000000f56aab05b35dbf6a--
