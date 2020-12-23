Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70772E1BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgLWLXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgLWLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:23:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E312C0613D3;
        Wed, 23 Dec 2020 03:22:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h205so39288612lfd.5;
        Wed, 23 Dec 2020 03:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wtmoM2gTNMAoOmqHB9IXXwDSaYAevxlwFgLMl64mT4M=;
        b=nRiCydouktHzieyRmD1QIuw6Git/kHZm2GtrtPqEIAyqn7sQF7p8/UJDCFjYQLmsZG
         X12dzYATusSI1AjA4A1oMoewuxXy9QCDgqWbSGnv3BtJhbyKsezAeJwr+tNa2EYz/LlV
         0rJfFW/6JYMKcFW2uF11bdWR43ggfjpja5OkGSnszuceoD8a1VMewt94/kZifeBdMXks
         VHYQjYtYQMyAtCX8u454qSWoXIOKp8/ApWIs8HImFzarKtcesy4YNDSqMIDerZMQspOg
         /VE/TwNVfvZSSY9EgzM5CNLA4mAApiNRcwDif6TGxVYsyjGJuIBEIvukykS1E2dqaqQC
         3o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wtmoM2gTNMAoOmqHB9IXXwDSaYAevxlwFgLMl64mT4M=;
        b=ELsesh5dr/W2G/Ovg9yjCnsNgAbFNPSY1rtRnXHG44jF7pSJInJo06+EsuiekuNPf6
         qR1dihf4d32TVMFX4l/idI2j+nUpIWdmfgXp4BGIQg9RjUJylBgRwqNyIRihfRQ3DcZR
         FUswfnxPxvS0TVUHZeYD9HFQZlNa8gXuCXyKjINJ3/rlhPVHiB4x/+Y0hiOm+D4oUfRy
         +6MXeo3ypul2eAbWwX1G/1OXSq2gYeWoG5ZzV8vyWGx8C2msgbiN7Eg93lt+JnDlVDUz
         TZ4UgWMmZFAq7WaeTdK6pQhzDXFiS8F+u41Tl4AkdYBiUr0JbtvpePG8eNj1ZdkF15Zq
         +Kmw==
X-Gm-Message-State: AOAM533gBPyAKlui3T8dgX0IC0QuSgVMFi/WVlyPkLyETVbwIk2irMgz
        lpxRazmm1jXc/dTwXE+pdZkWnP1Wu3Kd50TzQHnQ6Ys=
X-Google-Smtp-Source: ABdhPJzd6dPV9ceE8ThPQ6pOMT3rR5MDgxYUiNhqod80hib/q0FYgi7uMtn6T6UY8DHmKnw4a6KbIBd2iVCWXYpYxzA=
X-Received: by 2002:a19:8c04:: with SMTP id o4mr10443458lfd.333.1608722575571;
 Wed, 23 Dec 2020 03:22:55 -0800 (PST)
MIME-Version: 1.0
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net> <4483r6o2-245o-147-s71r-s64ss3nqr8ps@vanv.qr>
In-Reply-To: <4483r6o2-245o-147-s71r-s64ss3nqr8ps@vanv.qr>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Wed, 23 Dec 2020 12:22:29 +0100
Message-ID: <CAEJqkghfOODze7eKO=+45eevx2KN-u275qU7j1mFYyVVDMy9uw@mail.gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 23. Dez. 2020 um 11:41 Uhr schrieb Jan Engelhardt <jengelh@inai.de>=
:
>
>
> On Tuesday 2020-12-22 04:58, Guenter Roeck wrote:
> >On 12/21/20 5:45 PM, Gabriel C wrote:
> >> Hello Guenter,
> >>
> >> while trying to add ZEN3 support for zenpower out of tree modules, I f=
ind out
> >> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 =
even ).
> >
> >[...] since I do not have time to actively maintain
> >the driver, since each chip variant seems to use different addresses and=
 scales,
> >and since the information about voltages and currents is unpublished by =
AMD,
> >I'll remove support for voltage/current readings from the upstream drive=
r.
>
> I support that decision.
>
> /proc/cpuinfo::AMD Ryzen 7 3700X 8-Core Processor, fam 23 model 113 step =
0
>
> A synthetic load (perl -e '1 while 1') x 16 shows:
> Adapter: PCI adapter
> Vcore:        +1.28 V
> Vsoc:         +1.02 V
> Tctl:         +94.8=C2=B0C
> Tdie:         +94.8=C2=B0C
> Tccd1:        +94.8=C2=B0C
> Icore:       +76.00 A
> Isoc:         +6.75 A
>
> A BOINC workload on average:
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.17 V
> Vsoc:         +1.02 V
> Tctl:         +94.9=C2=B0C
> Tdie:         +94.9=C2=B0C
> Tccd1:        +95.0=C2=B0C
> Icore:       +88.00 A
> Isoc:         +8.00 A
>
> The BOINC workload, when it momentarily spikes:
> Adapter: PCI adapter
> Vcore:        +1.32 V
> Vsoc:         +1.02 V
> Tctl:         +94.1=C2=B0C
> Tdie:         +94.1=C2=B0C
> Tccd1:        +96.0=C2=B0C
> Icore:       +105.00 A
> Isoc:         +7.75 A
>
> For a processor sold as a 65 W part, observing reported sensors as
> 88 A x 1.17 V + 8 A x 1.02 V =3D 111.12 W just can't be. We are off by a
> factor of about 2.

Yes, those are wrong, bc the code is wrong.
ZEN2 desktop is mixed with ZEN2 Server/TR code.

Best Reagrds,

Gabriel C
