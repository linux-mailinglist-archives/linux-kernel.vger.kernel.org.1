Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426C2B9AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgKSSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgKSSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:34:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0131C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:34:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so7439138wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1lAho5O4/a+VG/i1a4UgQee+Ys5Gfbq0Ztg7wTZh8c=;
        b=X8iw1wDcARqdj8RyVHswvGtWQO+S79KWUqBU6e9EHyyUlO6FMBmZidZzjkbwUaZYiA
         4y0AP/xsgv99LJ6/dCTZvfpta//u/++rLvLY8q2wUOFwgDoO/XS0/NdNWZ/19IsiM+mH
         CoMkorEdyd3t3FXiwLcKosNMB/FGIjondP4wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1lAho5O4/a+VG/i1a4UgQee+Ys5Gfbq0Ztg7wTZh8c=;
        b=gLqkeSdmfh3FL/1w/oAjTifZO3uIPXp7ScTuHHKeCEePgnStSmxkhkHfb8WV2PbhKk
         aLxNmD7xm1lTh0IdLdBSGMBeFBp4as7Z7KJ/QHb5FgrkfYzZR3YdFP0ZxKRf3hbylECJ
         MCt5kQgHTsz3w4Tj2rz8kOgjYNK8a7ogSWHnTRq9qCUPzWefBQWezodAIjyY/U/DNfS8
         pLVSGRUQK4nBUBqaXMdK19aBcxZrr3UUkH8MdTE6FGzJlObEPaD7W7qt0Ou4XyChalKD
         6zET3Pk6uoYq1yap3ISXUUiE37zV6gT5xaWVjiWvYTOLm7EX2Yjlr4j0HfWWLAnKSv93
         62Mw==
X-Gm-Message-State: AOAM5339jydkthXBsJFitR9jv8pu194qbN8fy+6/WtLVW148rLvIb/Qp
        +/vncX7RjEJQeYR7+CSrdRFXAiXe92IugElws7mAv/IuSjzzCg==
X-Google-Smtp-Source: ABdhPJyExK6/IxDUC1sXRP3fN0r10cNhqUHKjttq1fM3XFso04IxnKdg1/oijiNm4GGrQAHturTk155hNEAG24vt2GE=
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr11895779wrm.275.1605810869475;
 Thu, 19 Nov 2020 10:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20201112175632.42234-1-james.quinlan@broadcom.com>
 <20201112175632.42234-3-james.quinlan@broadcom.com> <20201113094732.4bcyjs7zz7vwg4of@bogus>
 <CA+-6iNxZ73gYtjP54kBJhcwzL5h4Co6Wh8-Nk4poqLV0s=jA8w@mail.gmail.com>
 <20201113143627.jxxha7uejhjucwbz@bogus> <CA+-6iNz099CQQky7U7vm7w7s=QAECauuosLAf7zC4hWNFZ9yqQ@mail.gmail.com>
In-Reply-To: <CA+-6iNz099CQQky7U7vm7w7s=QAECauuosLAf7zC4hWNFZ9yqQ@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 19 Nov 2020 13:34:18 -0500
Message-ID: <CA+-6iNw2+uGX3W3boiNokbVwaK2MseJORPq8mDpc+SihoLSOQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007930f205b479faf8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007930f205b479faf8
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2020 at 10:12 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Fri, Nov 13, 2020 at 9:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Nov 13, 2020 at 09:26:43AM -0500, Jim Quinlan wrote:
> > > Hi, these are fast calls.  Regards, Jim
> > >
> > >
> > > On Fri, Nov 13, 2020 at 4:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Thu, Nov 12, 2020 at 12:56:27PM -0500, Jim Quinlan wrote:
> > > > > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > > > > message to be indicated by an interrupt rather than the return of the smc
> > > > > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > > > > "platform" whose SW is already out in the field and cannot be changed.
> > > > >
> > > >
> > > > Sorry for missing to check with you earlier. Are these not fast smc calls ?
> > > > Can we check the SMC Function IDs for the same and expect IRQ to be present
> > > > if they are not fast calls ?
> > > Hi, if I understand you correctly you want to do something like this:
> > >
> > >  if (! ARM_SMCCC_IS_FAST_CALL(func_id)) {
> > >         /* look for irq and request it */
> > > }
> > >
> >
> > Yes.
> >
> > > But we  do use fast calls.
> >
> > What was the rationale for retaining fast SMC calls but use IRQ for Tx
> > completion ?
> >
> > Is it because you offload it to some other microprocessor and don't
> > continue execution on secure side in whcih case you can afford fast call ?
Hi Sudeep,
Here is my understanding:  Some SMC calls may take a few longer to
complete than others.  The longer ones tie up the CPU core that is
handling the SMC call, and so nothing can be scheduled on that
specific core.  Unfortunately, we have a real-time OS that runs
sporadically on one specific core and if that happens to be the same
core that is handling the SMC, the RTOS will miss its deadline.  So we
need to have the SMC return immediately and use an SGI for task
completion.

Regards,
Jim Quinlan
Broadcom STB


>
> Hi Sudeep,
> I have an answer for this but allow me time to contact the platform FW
> engineer to make sure I have the full picture -- this may take a day
> or two.  Regardless, our implementation has already "shipped" to
> customers for some time so we may not be able to change it.
> Regards, Jim
> >
> >
> > --
> > Regards,
> > Sudeep

--0000000000007930f205b479faf8
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOdTks6NtS1a
CIUGobgjLByPTFx/dNku4jjYL7IcvWy3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTExOTE4MzQyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAkAipr30IQJE4YFYAaRbxMK8t6s7Jt
zuzzbQLFxpkw40FTdvTKw9aiyrtLWns9oVe91orP98jevNXPbZgGV2tBAnQmKsKY7FbEghK87pgm
dn29ngOTfIlLLUA1k5Naqs9l8KmKFHGxq0otD/7rI2VYLoki1p49y+P+QKbiw9oo92vDWPryYr+T
sAUb/rYdRaHePZz9mAtI5PTaij9Sl/huzXG64RAnfk/f+9ym9bwReScwHk3x4fS8EO/r+pa3y/XO
ff3fnUDq9n8/3OeLarjH5TYGjTKPq4sczqT5UmtamltSIx+brPVElQDnTJ4TB5HYYswKWjY4JHfL
Ov9Wk4cd
--0000000000007930f205b479faf8--
