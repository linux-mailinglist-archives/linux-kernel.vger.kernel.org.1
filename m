Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF02A868D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgKES5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgKES5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:57:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B1C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:57:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c18so2640174wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEp39YCFYSzpDYTci77m/VH4/AkefFnvKb9Z6p/+x8Q=;
        b=Eujb+4tS5C/4v4Czo1sZ8b1uEv3L8AxWPcHJ+Zlrz/eEJz2Fu2CLrtVrK1Y8lfDtcx
         qlG43YhHD7+/YrLFsRbmYPKAU6BvVCdRz162cEvdGXIrHCerjuFmFoDFe65AGIy2713M
         UUSSMmq4+aprNkn+OkwRa9n3gjSXWy8J1ickY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEp39YCFYSzpDYTci77m/VH4/AkefFnvKb9Z6p/+x8Q=;
        b=qf2Od5Hot6KwlkV9mhW3VCiNSO/0u0sj5jyfKrySPl0GxbaPUXnXJmbAgZIsWYAFmY
         s/8pk4LhWgIo4rIRcp+PJA3dGI9+DuPxUk7dV8FhKM0X8dRLtHtqke9NRBNJ2V6122wo
         8+7lQgxRnPHFr9649qETRIQTrYVZ/LDm1D7ymmRhhxmJx4dDZkYfpoX3gB6N7t69Aupw
         6xD48WK1yQR0c36UFZlUKRk9KYF6vnh8GZPeWfgWxUZJSzwnfm5jp2+PBZlzN3NYQPqz
         iE4UeMmAt1HJzLYdgzvgp69/8IVwsRpgWFEcM9LeU7niFB5WsuS3HdhBf+dM/bz2NSkC
         3qag==
X-Gm-Message-State: AOAM530A69zlxiKjNpo65JbmdAnO6E27A3CnEEBOpoHshmLsPg5fcpS7
        yHM5c7Fq6QwmwtF00pRS3zPhmEhoGkbufjF7O/E7CA==
X-Google-Smtp-Source: ABdhPJylWIVSg3tW8Gd2sq2nMgeYGE5ziLCZE93f4GtUSP0BalOkwAqcDAfqFHEhAyl6z81fAWsWZKYF5eX4zLFqyq8=
X-Received: by 2002:a7b:c255:: with SMTP id b21mr4395276wmj.72.1604602638699;
 Thu, 05 Nov 2020 10:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
 <20201029195913.5927-2-james.quinlan@broadcom.com> <20201104215050.GA4180546@bogus>
 <CA+-6iNw1Z1dj8oFn8DdyVPuMUP-3+n9sKXuWYWo2rfPo5j4dkA@mail.gmail.com>
 <CAL_JsqJQA_VLhez8y6HVCdFB2DZ85KoDZ1=RtbU4Mw98aQRSxA@mail.gmail.com>
 <CA+-6iNznMY78tJBeNrtyOy58DTKKPGxfgA0Pu2Rxx42YDJWV1w@mail.gmail.com> <20201105182707.l4xx3wu2ch22qysi@bogus>
In-Reply-To: <20201105182707.l4xx3wu2ch22qysi@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 5 Nov 2020 13:57:07 -0500
Message-ID: <CA+-6iNyeUWprE8rsBWoVigYHMdU1k8W0i3j0PF3gKKvZHCM+mg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add bindings for BrcmSTB SCMI mailbox driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004fa1eb05b360aac1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004fa1eb05b360aac1
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 5, 2020 at 1:27 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Nov 05, 2020 at 10:28:25AM -0500, Jim Quinlan wrote:
> > On Thu, Nov 5, 2020 at 10:13 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Nov 4, 2020 at 4:04 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > > >
> > > > On Wed, Nov 4, 2020 at 4:50 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 29, 2020 at 03:59:06PM -0400, Jim Quinlan wrote:
> > > > > > Bindings are added.  Only one interrupt is needed because
> > > > > > we do not yet employ the SCMI p2a channel.
> > > > >
> > > > > I still don't understand what this is. To repeat from v1: I thought SCMI
> > > > > was a mailbox consumer, not provider?
> > > >
> > > > Hi Rob,
> > > >
> > > > I'm not sure where I am implying that SCMI is a mailbox provider?
> > > > Should I not mention "SCMI" in the subject line?
> > > >
> > > > This is just a mailbox driver, "consumed" by SCMI.    Our SCMI DT node
> > > > looks like this:
> > > >
> > > > brcm_scmi_mailbox: brcm_scmi_mailbox@0 {
> > > >         #mbox-cells = <1>;
> > > >         compatible = "brcm,brcmstb-mbox";
> > > > };
> > > >
> > > > brcm_scmi@0 {
> > > >         compatible = "arm,scmi";
> > > >         mboxes = <&brcm_scmi_mailbox 0>;;
> > > >         mbox-names = "tx";
> > > >         shmem = <&NWMBOX>;
> > > >         /* ... */
> > > > };
> > >
> > > Okay, that makes more sense. Though it seems like this is just adding
> > > a pointless level of indirection to turn an interrupt into a mailbox.
> > > There's nothing more to 'the mailbox' is there?
> >
> > Correct.  Although you can see that it uses both interrupts and SMC
> > calls to get the job done.
> >
>
> I was against having 2 separate solutions and would have raised my concern
> again. As I mentioned earlier, either extend what we have or move the
> existing SMC solution into this mailbox driver. Having 2 different solution
> for this just because you have extra interrupt to deal with is definite
> NACK from me as I had previously mentioned.
>
> > > So why not either
> > > allow SCMI to have an interrupt directly
> > Not sure here -- perhaps the SCMI folks have an answer?
> >
>
> I did ask why can't you extend the existing SCMI/SMC binding to add this
> as optional feature ?
Hi Sudeep,

Looking at the email you said, "In that case any reason why you can't
reuse the existing smc transport for SCMI." ,  and I replied with the
reason.  I did not interpret your statement  above as what you are
clearly saying now: "either extend what we have or move the existing
SMC solution into this mailbox driver. "

Fair enough, I  will look into this.

Regards,
Jim


>
> > > or have a generic irq mailbox driver?
>
> Fine with this too.
>
> > The SCMI implementation doesn't offer a generic irq mailbox driver
> > AFAICT.  The SCMI folks recently provided  an "smc transport" driver
> > in "drivers/firmware/arm_scmi/smc.c" -- it is close to what we need
> > but is missing interrupts.
>
> IIRC, you were using SGIs and it can't be represented and use today as
> is ? Am  I missing something or anything has changed ?
>
> --
> Regards,
> Sudeep

--0000000000004fa1eb05b360aac1
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINzpp2XL1aOk
OvnAqaMxow0wdGVsPwvftcOxjMiq2jFbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEwNTE4NTcxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB2SySpUBtU8T+J15rzZbDpiKHqEvLD
z3SLIz7Go4I6RkA4z/5sJDCDOJWGbIe2wVVgQS8InfCTo/xYo8r0BSsFSzub5O/KXDFrgAYnmY9e
ciRiaDmvCy1VSxmjtxcEjd4re9OZpezPy44232kJB1F2jzS7soDM+2zIOtGO0isSIlFXUfwwWfX1
y1gLLpMH7s38Dxx9zsJTXMBFrd/rGUj1sQB2leL58r42a2VwqGkzEyQNrlKP/eMoJZ8BmjUOlIHc
wUQeyEd5HTEV4n19s5yZq27DgSo7xiRXzebKk+vM+4i+GI3H4iQXJ7zlG3CcCx3nhlGiknBcXFRi
sgkNp4mA
--0000000000004fa1eb05b360aac1--
