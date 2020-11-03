Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0719E2A3A24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgKCB6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgKCB6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:58:15 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6365820773;
        Tue,  3 Nov 2020 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604368694;
        bh=3dUvtcf/yUGAhnulRzfV4zS6legYSxZzHBiv+MKFnXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nQBRYYsUOrdM8A7Il9o4aZpsQOkPGQePzU2EO3WrlfPqNL+3PrxmHwdQMmKMme5XZ
         Ol5Cpu6p76gC/lTQEMKfU7bqApXmtga083jYEvKuyBvN5bsenieJbiEcZUm+wRKKjV
         ypnT4x0TjaCqq3f1ScVhP2PZVc9oDT4i39prOIjc=
Received: by mail-oi1-f179.google.com with SMTP id x1so16784849oic.13;
        Mon, 02 Nov 2020 17:58:14 -0800 (PST)
X-Gm-Message-State: AOAM533my6loe2vB+rFqUtVhhjZ/wGI0sITTaqGBURX+SPAMD/rXFm+A
        a4/SRmk/eHKju1PRLvXMH5l51d0DCD13KYEwNA==
X-Google-Smtp-Source: ABdhPJyOl9nr+2k/bCHlpb1t5ZvvKlPSp84A84IQmH6cjbklMr6ZsyGKHAHxSUvZgCbVJvlXgIKodyIFLw3oQipl9Rk=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr653264oib.106.1604368693750;
 Mon, 02 Nov 2020 17:58:13 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
 <1604286803-20698-2-git-send-email-u0084500@gmail.com> <20201102172117.GA4071346@bogus>
 <CADiBU39rS+_s+YdWxB6DKQYHF_+ddiE65u9KzeK-CCkHhZq_YQ@mail.gmail.com>
In-Reply-To: <CADiBU39rS+_s+YdWxB6DKQYHF_+ddiE65u9KzeK-CCkHhZq_YQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Nov 2020 19:58:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_=OU6X2UynEoV24gycs+c3rQ7j6CJ4euMvnSd8bTufA@mail.gmail.com>
Message-ID: <CAL_Jsq+_=OU6X2UynEoV24gycs+c3rQ7j6CJ4euMvnSd8bTufA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: rt4505: Adds DT binding document for Richtek
 RT4831 MFD core
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     devicetree@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 7:14 PM ChiYuan Huang <u0084500@gmail.com> wrote:
>
> Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:21=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, 02 Nov 2020 11:13:23 +0800, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Adds DT binding document for Richtek RT4831 MFD core.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 89 ++++++++++++=
++++++++++
> > >  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
> > >  2 files changed, 112 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4=
831.yaml
> > >  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> > >
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Unknown file referenced: [Errno 2] No such file or directory: '/usr/loc=
al/lib/python3.8/dist-packages/dtschema/schemas/regulator/richtek,rt4831-re=
gulator.yaml'
> > xargs: dt-doc-validate: exited with status 255; aborting
> > make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentat=
ion/devicetree/bindings/processed-schema-examples.json] Error 124
> > make: *** [Makefile:1364: dt_binding_check] Error 2
> >
> >
> > See https://patchwork.ozlabs.org/patch/1391911
> >
> > The base for the patch is generally the last rc1. Any dependencies
> > should be noted.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit.
> >
> Sorry, I have one question.
> If the richtek,rt4831.yaml is depend upon the other yaml, do I need to
> merge it all into one patch?
> Currently, my submitting order is mfd, backlight, and regulator.
> Each part divided into two patches (one for source code, another for
> dt_binding_document)

Doesn't have to be 1 patch, but should be one series with MFD coming
last as it references the others. Example goes in the MFD binding. I
need to see a complete picture for what the device is to effectively
review the binding.

Rob
