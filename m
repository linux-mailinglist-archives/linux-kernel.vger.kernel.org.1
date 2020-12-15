Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2505D2DA764
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLOFSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgLOFR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:17:56 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85DC0617A7;
        Mon, 14 Dec 2020 21:17:15 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 23so36109373lfg.10;
        Mon, 14 Dec 2020 21:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QYK3/QIGX/PdeJs4r8UYSQRr0m3A4G8axIc8eAE272c=;
        b=BKDmhZkm4AqGvi4OYCwgVb04oqDpY+IzrMaIZPpOh/uneUD9yvvwwRotQrnlf7glp1
         GUXlFrXkBBbqQbKErgABUqnXAshCb+f+906j+ZKrjetzWlC/vEmYKegVdcrVqlJS1HSM
         A/nVLnCgycOSvDMFgJMjL1ARrufeOKPPNiWH3l6t955gFTF5TkHPoYc9AmpQYJRY00Hy
         muPMgUsYFQScWIYy1xYIPLL2oOHXhdrkSYQBj53sY0dTgQSB392MtcnRnZthjsOqtwUt
         tql7vfFk9wcpVi8h7etoLIU+qjwX42mOlT0vB1gFR2qzNZAo+ydLm1eHWienLKEo8RuK
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QYK3/QIGX/PdeJs4r8UYSQRr0m3A4G8axIc8eAE272c=;
        b=T66ECnXscBdOvBQC1EAwSS6pLvYNMKXujyfiDysDtZ2GWn11ULsTV5N4rC8VuyzLLh
         10SKQYsw1PicP1JVQUB8SAOPssYfDB/UyrUtfkvKaTW4kNRc0Hi1wSK7pvYPocF9Drll
         BBXYQLpJyIXEuyz6C4F0nTwXB2xLC2rcYZy9EoDqmXRKMpC10RNo4U9wZbasXOYFVo9i
         JHfHi5V9xnlBvmKqfh5ADcKQVjCsnfEX0dHH02eJDXp4snvenezHgSeWisajfk6oylzG
         7iQ2BDRawfrXg1ub7FX7zSsUdBpY4pvafyyG4mJm6wpnrbEqJlq6t09pyMerl4nw2399
         +srg==
X-Gm-Message-State: AOAM5333ZONJDVCifmLNe4aYhQKpavmQsHVbb5qHb+M/VXPmc612+wf4
        BfQ7rGYumftN10teaPvyl73bwn5rgOCvuWtcjYw=
X-Google-Smtp-Source: ABdhPJw7FGd3wzHxzyItMvzbE82I1vUgMOy9JepPEmkrZc9v8moDWWdVeFwWcZp66PeWjlZUGC5DAut0NfoUrr9wOUI=
X-Received: by 2002:a2e:7607:: with SMTP id r7mr11391137ljc.168.1608009434372;
 Mon, 14 Dec 2020 21:17:14 -0800 (PST)
MIME-Version: 1.0
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com> <20201214095916.4g47zlueng4wa3hv@holly.lan>
 <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
 <20201214231743.GA2560842@robh.at.kernel.org> <1608008909.2963.7.camel@richtek.com>
In-Reply-To: <1608008909.2963.7.camel@richtek.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 15 Dec 2020 13:17:02 +0800
Message-ID: <CADiBU3-AFfso3EyzoTxhnuLfM=6YJEyesgnkPcj8y-7qKhHHnw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 2020=
=E5=B9=B412=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:08=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Dec 14, 2020 at 10:40:55PM +0800, ChiYuan Huang wrote:
> >
> > Hi,
> >
> > Daniel Thompson <daniel.thompson@linaro.org> =E6=96=BC 2020=E5=B9=B412=
=E6=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=80
> > =E4=B8=8B=E5=8D=885:59=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > >
> > > Hi CY
> > >
> > > On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> > > >
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Adds DT binding document for Richtek RT4831 backlight.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > This patch got keyword filtered and brought to my attention
> > > but the rest of the series did not.
> > >
> > > If it was a backlight patch series you need to send it To: the
> > > all the backlight maintainers.
> > >
> > Yes, I'm waiting for mfd reviewing.
> > Due to mfd patch, I need to add backlight dt-binding patch prior to
> > backlight source code.
> > Or autobuild robot will said mfd dt-binding build fail from Rob.
> > That's why I send the backlight dt-binding prior to the source code.
> >
> > I still have backlight/regulator source code patch after mfd
> > reviewing.
> > Do you want me to send all the patches without waiting for mfd
> > reviewing?
> What happened to the regulator part of the binding? I said you could
> merge it into the mfd schema, not drop it. Bindings should be complete
> so we get a full picture of a device.
>
Sorry I found the gmail account already loop in. Just my gmail problem.
I cannot see the email in it.....
The reply is below.
Yes, I remove the regulator dt-binding and directly merge into mfd
schema. Could you check the v4 3/3 patch?
Or you just want me to remove regulator dt-binding example, not whole
dt-binding file?
>
> Rob
> ************* Email Confidentiality Notice ********************
>
> The information contained in this e-mail message (including any attachmen=
ts) may be confidential, proprietary, privileged, or otherwise exempt from =
disclosure under applicable laws. It is intended to be conveyed only to the=
 designated recipient(s). Any use, dissemination, distribution, printing, r=
etaining or copying of this e-mail (including its attachments) by unintende=
d recipient(s) is strictly prohibited and may be unlawful. If you are not a=
n intended recipient of this e-mail, or believe that you have received this=
 e-mail in error, please notify the sender immediately (by replying to this=
 e-mail), delete any and all copies of this e-mail (including any attachmen=
ts) from your system, and do not disclose the content of this e-mail to any=
 other person. Thank you!
