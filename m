Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88852A383E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgKCBOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:14:40 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2936C0617A6;
        Mon,  2 Nov 2020 17:14:39 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id k25so17173236lji.9;
        Mon, 02 Nov 2020 17:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mRWNwCg0iYBVSfGEXtZl/nySwLia/TOiOphJChcGFlY=;
        b=ZpfXfJIjQor/0N8Qx3cPj8jV+ROrkzIK4ksPwTAKf9fpgm0Z8QXARLpYZQor6NPPJ0
         tND9+72IPwcyOjJ0ycY852+DwVdwHpkKNMcsm1KZuqFSq0cykw9i9abgTNcHSiUUZl40
         yjHLm9XFrJE4XG0WwhQH7NRkk3/No81vO7MgJDpI/UkzvkvSrkoWbkG0J8ncrZkOc1XB
         +qWLYqm13UclO7BowuZB1e4+SxA0Vqw5TMh9CYHFrsJf5ryFyzFjnwY7t+alxZMEN6Gh
         XnXJDngDS9rS4dt5GtKxkUQ7RpDXpGm6NZOFkLczhsO4sIPPjQPXhZ9dEiB958iE+kz9
         7H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRWNwCg0iYBVSfGEXtZl/nySwLia/TOiOphJChcGFlY=;
        b=r3JB1LCVld1cK+m2w+1Xh7OHdDgRsBmBX7APJsbg7McKTDmvt0C7irhj5dMCBsQ541
         zgxZBeWPgLD0E7tj6FUjTSh7x+jVgoKzW9ABkK4ObfmC6BOyaoLQpBBQJcHmLY/bFS9C
         pwdhkXcoXzk8XOlfsySJinqygfdbTuGgVylzxozTnrTDVXQ7DJigPmBnSp+jl7phv7cK
         Yjn7CWqkoHHJukHuiaJVfDffANwIoTbJ8wjxJYX8aW3MrjygAt0Y2YKIgobht6uuvntz
         S7RdA5hkKnRFfIukW0Dh2oPyalIN/KrCVQeDEsKJighRb3WQMjUmaAhW0TDNP2BexqSg
         J9SA==
X-Gm-Message-State: AOAM530T+2et+0TWZbbSNtsoh/PKgY7vaDZRUPM6DQhwRWkeUN4oewnb
        9l5YxLOHWu5CYh9yfgjTMAClXwAvw3DsEnsPpC8=
X-Google-Smtp-Source: ABdhPJwxs6n3Ixr/TS5din8KEAJLc0CMpMy6cberOtW/Vd2r3ny94E70illrEiYD18d/U0XRL6qBZUdEEohHI5MnLsc=
X-Received: by 2002:a2e:904e:: with SMTP id n14mr7243461ljg.356.1604366078106;
 Mon, 02 Nov 2020 17:14:38 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
 <1604286803-20698-2-git-send-email-u0084500@gmail.com> <20201102172117.GA4071346@bogus>
In-Reply-To: <20201102172117.GA4071346@bogus>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 3 Nov 2020 09:14:26 +0800
Message-ID: <CADiBU39rS+_s+YdWxB6DKQYHF_+ddiE65u9KzeK-CCkHhZq_YQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: rt4505: Adds DT binding document for Richtek
 RT4831 MFD core
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 02 Nov 2020 11:13:23 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds DT binding document for Richtek RT4831 MFD core.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 89 ++++++++++++++=
++++++++
> >  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
> >  2 files changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt483=
1.yaml
> >  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local=
/lib/python3.8/dist-packages/dtschema/schemas/regulator/richtek,rt4831-regu=
lator.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentatio=
n/devicetree/bindings/processed-schema-examples.json] Error 124
> make: *** [Makefile:1364: dt_binding_check] Error 2
>
>
> See https://patchwork.ozlabs.org/patch/1391911
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
Sorry, I have one question.
If the richtek,rt4831.yaml is depend upon the other yaml, do I need to
merge it all into one patch?
Currently, my submitting order is mfd, backlight, and regulator.
Each part divided into two patches (one for source code, another for
dt_binding_document)
I have tried dt_binding_check. It cause the error like your bot said.
If dt_binding_check want to be pass, it means I should merge all dt
binding document into one patch due to the dependency.

If yes, I'll do it in next series patch.
