Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71642A3C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKCFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 00:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 00:48:54 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3202C0617A6;
        Mon,  2 Nov 2020 21:48:53 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id x16so17736290ljh.2;
        Mon, 02 Nov 2020 21:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5cV1z+zpVqvlvDDvUw4iLtU9MzVASb2b77WGA89sUck=;
        b=oQa2ZufAqEQbYpPi1otUbadC7Sm50fr2p8oglDHUOw579LWeVNW1E6FaJEebv0FxiK
         QRWJzLTeFsx0LiQkKctDS1uR3iVn3F9PgyFA2k8tqWn7flealeUwJitCOlMiB/uV04rq
         nbLP5RKNH+yXBofdSFmgRrxm7GHCtXgmEL77mOJqxg2m6pbPUOuWM7qD8XyAf09dFR4i
         ZxLwk0Sm31Poepo6GVWQBKBa95aYTJHUgKDum/EPCmYh6euTnQlyzmQ4QP00gK1JJ+ef
         WlfZ6AP7VNjIcl4nEBu70wvJrdFsQgkeSvU8Mcp5LasgVlZcOal1ph+nANZYbGHF2F53
         +Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5cV1z+zpVqvlvDDvUw4iLtU9MzVASb2b77WGA89sUck=;
        b=bnsU3qys9dze+gcfJf+On3lNrERxry2HVn4efRt9naR6i2g6PQynlZo2lJzsxS9Of0
         x2ZWR+vIZdpTIc0ievXh037Gh6sizGqiWg0a6sdXtCT8Ea5gHM+c9cF+Dn/04J404uIi
         1RtTAY4Dv3eafFAW7/u8v1d2trB6eGI1UW9qM0sHZZIEDbJKH0x3XXVVn/W72g9ddo7c
         pQJOskkA5N77Wkrfo5GREohPfAEesZe90ry1jitcvhRHkMH5YHIQJJIfnwwjwZ2t2/3t
         H5HOXM+GWU+mEzFrZ5N75CXf76l/u4uq3rnKj9TNBNyWm0d/jFcF7vBUdrH0PwHMe/NR
         55DQ==
X-Gm-Message-State: AOAM533TLQRflOI1KBi5h4feY04f51Px7lvSGfTQeV8Jn9TzA7StfEj3
        Hgd6OXA2jM2ROjVGO9RtFnAKN7EE861YoOmgdcCv0HeSmoAEZw==
X-Google-Smtp-Source: ABdhPJy8IkST5HF4Q8tSnmqulA7xB0H/YESCMdkFGxasny6Uj20VMfBn2ylDqajSFddTnwd4uCXswEOJ8Vz/eD0kkCE=
X-Received: by 2002:a2e:6c16:: with SMTP id h22mr7732160ljc.154.1604382532327;
 Mon, 02 Nov 2020 21:48:52 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
 <1604286803-20698-2-git-send-email-u0084500@gmail.com> <20201102172117.GA4071346@bogus>
 <CADiBU39rS+_s+YdWxB6DKQYHF_+ddiE65u9KzeK-CCkHhZq_YQ@mail.gmail.com> <CAL_Jsq+_=OU6X2UynEoV24gycs+c3rQ7j6CJ4euMvnSd8bTufA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+_=OU6X2UynEoV24gycs+c3rQ7j6CJ4euMvnSd8bTufA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 3 Nov 2020 13:48:40 +0800
Message-ID: <CADiBU3_T8gRoU7S3rTyW259Gk7AArp_b1qcEhuXrK1QLz5ussw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: rt4505: Adds DT binding document for Richtek
 RT4831 MFD core
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=889:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Nov 2, 2020 at 7:14 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> >
> > Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:21=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 02 Nov 2020 11:13:23 +0800, cy_huang wrote:
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Adds DT binding document for Richtek RT4831 MFD core.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > ---
> > > >  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 89 ++++++++++=
++++++++++++
> > > >  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
> > > >  2 files changed, 112 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,r=
t4831.yaml
> > > >  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> > > >
> > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Unknown file referenced: [Errno 2] No such file or directory: '/usr/l=
ocal/lib/python3.8/dist-packages/dtschema/schemas/regulator/richtek,rt4831-=
regulator.yaml'
> > > xargs: dt-doc-validate: exited with status 255; aborting
> > > make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Document=
ation/devicetree/bindings/processed-schema-examples.json] Error 124
> > > make: *** [Makefile:1364: dt_binding_check] Error 2
> > >
> > >
> > > See https://patchwork.ozlabs.org/patch/1391911
> > >
> > > The base for the patch is generally the last rc1. Any dependencies
> > > should be noted.
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up =
to
> > > date:
> > >
> > > pip3 install dtschema --upgrade
> > >
> > > Please check and re-submit.
> > >
> > Sorry, I have one question.
> > If the richtek,rt4831.yaml is depend upon the other yaml, do I need to
> > merge it all into one patch?
> > Currently, my submitting order is mfd, backlight, and regulator.
> > Each part divided into two patches (one for source code, another for
> > dt_binding_document)
>
> Doesn't have to be 1 patch, but should be one series with MFD coming
> last as it references the others. Example goes in the MFD binding. I
> need to see a complete picture for what the device is to effectively
> review the binding.
>
Got it. Next, I'll add the regulator and backlight dt-binding into the
series patch.
And add the description into mfd core dt-binding like as below.

This patch depends on
    "backlight: rt4831: Adds DT binding document for Richtek RT4831
backlight module".
    "regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV mod=
ule".


> Rob
