Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9872BAB19
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgKTN1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgKTN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:27:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40214C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:27:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so10085685wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++O1CH4BmBhc4Y167b/JXyNg6kQDGdTSlxRK+8PnoEw=;
        b=RCK5q/TV7aJUXfKegt4ynYZ+0wF45NkN/gPxsAyy2g3A4mp9hYViuXfIuWqV7gk38o
         a+Ng9SngD/vmowOWowf3QAazOnqYxOEydbwmrvhiBtEDeTdLFwYVlSK15wsdjj6KXmQ2
         On+e0wA70T8EqGrJMLetM4xgOx6M5KulYgU5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++O1CH4BmBhc4Y167b/JXyNg6kQDGdTSlxRK+8PnoEw=;
        b=n+gvQDAJXBjpiQ90oA0MJ5+DQk7HR1oOuItGNeY0FVR1W5/MSj0F7jCo9+HufLNZqn
         bDovH4QVI1JEebCyXffl2/ilUBY+ng3k2CzH1JaV9BlzC5yy4vSJYQXS8qGBqQGk0Blc
         /TcLbjudv/C49ecw/TPfu19FcSgQzog31FLnXz999733RB9Cx73IScXYvlsZmyAGF94q
         JanAcN7NfLS/wp2wrT8ezsWbNzE7AIqvZ8Ury7artouXzKmbKZllyIhTDkxNK0MLwi6A
         P5NYxKz+TTkSUBVtgu+WH81siwV8nZrkQlTTXKgH+GcCaxXpkUYa+OWJyLnyEwM1eG2f
         06Qg==
X-Gm-Message-State: AOAM530VZ9GAsLD9K0C0pVmNHwMPV66njuGqtpB9aPQ9KcDgriVB/2J+
        SvBHutAYlkFjaLVIKF1HSWii/FQYEayA4R8IqYlpkQ==
X-Google-Smtp-Source: ABdhPJwpwY62R+l6O5Vl4B8tp8csBhwmwhD6Wm4hdmyBiJDwxe4EYOhGbtgar6B98tyah2/LA4EvZM0a4Bpy/3jXwsc=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr15391903wrv.145.1605878869795;
 Fri, 20 Nov 2020 05:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20201112175632.42234-1-james.quinlan@broadcom.com>
 <20201112175632.42234-3-james.quinlan@broadcom.com> <20201113094732.4bcyjs7zz7vwg4of@bogus>
 <CA+-6iNxZ73gYtjP54kBJhcwzL5h4Co6Wh8-Nk4poqLV0s=jA8w@mail.gmail.com>
 <20201113143627.jxxha7uejhjucwbz@bogus> <CA+-6iNz099CQQky7U7vm7w7s=QAECauuosLAf7zC4hWNFZ9yqQ@mail.gmail.com>
 <CA+-6iNw2+uGX3W3boiNokbVwaK2MseJORPq8mDpc+SihoLSOQw@mail.gmail.com> <20201120111427.erqfowx4rosuktao@bogus>
In-Reply-To: <20201120111427.erqfowx4rosuktao@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 20 Nov 2020 08:27:38 -0500
Message-ID: <CA+-6iNwVM6EOXBUk2DY6+xZHn0R-JDP0wsfinqjET6Xs-Ovqww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009bf5ab05b489cfb7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009bf5ab05b489cfb7
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 20, 2020 at 6:14 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Nov 19, 2020 at 01:34:18PM -0500, Jim Quinlan wrote:
> > On Fri, Nov 13, 2020 at 10:12 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > >
> > > On Fri, Nov 13, 2020 at 9:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Fri, Nov 13, 2020 at 09:26:43AM -0500, Jim Quinlan wrote:
> > > > > Hi, these are fast calls.  Regards, Jim
> > > > >
> > > > >
> > > > > On Fri, Nov 13, 2020 at 4:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 12, 2020 at 12:56:27PM -0500, Jim Quinlan wrote:
> > > > > > > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > > > > > > message to be indicated by an interrupt rather than the return of the smc
> > > > > > > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > > > > > > "platform" whose SW is already out in the field and cannot be changed.
> > > > > > >
> > > > > >
> > > > > > Sorry for missing to check with you earlier. Are these not fast smc calls ?
> > > > > > Can we check the SMC Function IDs for the same and expect IRQ to be present
> > > > > > if they are not fast calls ?
> > > > > Hi, if I understand you correctly you want to do something like this:
> > > > >
> > > > >  if (! ARM_SMCCC_IS_FAST_CALL(func_id)) {
> > > > >         /* look for irq and request it */
> > > > > }
> > > > >
> > > >
> > > > Yes.
> > > >
> > > > > But we  do use fast calls.
> > > >
> > > > What was the rationale for retaining fast SMC calls but use IRQ for Tx
> > > > completion ?
> > > >
> > > > Is it because you offload it to some other microprocessor and don't
> > > > continue execution on secure side in whcih case you can afford fast call ?
> > Hi Sudeep,
> >
>
> Thanks for the details. Unfortunately more questions:
>
> > Here is my understanding:  Some SMC calls may take a few longer to
> > complete than others. The longer ones tie up the CPU core that is
> > handling the SMC call, and so nothing can be scheduled on that
> > specific core.
>
> So far good.
>
> > Unfortunately, we have a real-time OS that runs
> > sporadically on one specific core and if that happens to be the same
> > core that is handling the SMC, the RTOS will miss its deadline.  So we
> > need to have the SMC return immediately and use an SGI for task
> > completion.
> >
>
> So it sounds more like it can't be fast call then.
Hi Sudeep,

To be honest,  I'm not sure what the big difference between fast and
slow SMC calls are other than the latter is "yielding" and
interruptible.  We cannot tolerate them being interruptible.

>
> Does that me, it will always return early and send SGI when the request
> is complete ?
Most calls send the SGI and return immediately.  The ones that take
longer return from the SMC and send the SGI when the operation is
completed.
>
> 1. If yes, what happens if there are multiple requests in parallel and
>    second one completes before the first. Can we handle that with this
>    patch set. Of will the second request fails until the first one is
>    complete ? It extends to number of cpus in the system worst case.
With SCMI we only have one message pending  at  a time;  perhaps I do
not understand your question.  Having the SMC return is mostly a no-op
as far as the SCMI  driver is concerned.

Our SCMI messages cannot fail.  When we do have timeouts it indicates
that something is wrong and needs to be fixed.

Regards,
Jim Quinlan
Broadcom STB
>
> 2. If no, will this not cause issues if we unconditional wait for interrupt
>    every single time ?
>
> --
> Regards,
> Sudeep

--0000000000009bf5ab05b489cfb7
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIME7PxaDArns
8249E5R1TZI+lrhHIRzdYjBoSKb33TexMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEyMDEzMjc1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDbmDt5pf4mGuhsWbv4rn72VooK1nb3
xpnZRbWxP0F9qZ3oG7s3T2mn1Rx2zWYqL53Ns9WluTQPaa0EdkyOL/h740KLzrIvy1eHunDUGCwS
KmibHIZ1hrUtPEFNDoM2WGKVpT/VzYbbHzidazIDlhg4FiLChqBnps2RT2Gbr55C/GKJpwcR9odL
a6iiEvPQqOnbR/Ejc+pvr3/30qgK908umQfQMdBPm9glrbErHKUJikoLSccHDqKsD218qqnmFh70
J1WUavM4ZBifVi5zA6kadPhXHN90z9T2SkwZ0clr1FfY1Hrw+47gABc6241hBHDVkDGSw2ccDC5X
gOdXW+cj
--0000000000009bf5ab05b489cfb7--
