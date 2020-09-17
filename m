Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0D26D6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIQIft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgIQIfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:35:45 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6420520770;
        Thu, 17 Sep 2020 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600331744;
        bh=mRSVv+vx8znjGJcarG67oS8oQgK+tcjmcnrKxbwgTb4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sZeGDWo5RzrZbk518kgncPbrpIDewL7XJD/AsZsKE1EpH+6fUORuRfF4SudQgicjt
         vZUmDSAsPTf7Rmz54eOnZRlQs/+bhEfhb2lDpS4xn+1+iYldqM4un/SMN6TsO3OqrN
         ffCVBgCERHpBQZ0tVRyKXbFIPXeYW/buz9T83F10=
Received: by mail-ed1-f43.google.com with SMTP id ay8so1602136edb.8;
        Thu, 17 Sep 2020 01:35:44 -0700 (PDT)
X-Gm-Message-State: AOAM530AfGG0Qbhz9aT7Lbo5Rd/0JaQSvrpMnzXa2S774aAr+c9BTqlH
        2SHvCO2R4FNLCq8IlbgzkfI482sNwRwRdF5xVSc=
X-Google-Smtp-Source: ABdhPJwR4QxzWTBTJu+tZgpe6V1W/uKkOfOafsDCntpeBU/CCaBG1l6xe8J4VkUwGz1JChPKh8NPIQ3cChRLOhHGhrc=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr31147447edb.143.1600331742874;
 Thu, 17 Sep 2020 01:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200917070543.19064-1-krzk@kernel.org> <CAMxfBF5WWQX3ZH0YcRZ_N8q4njTdG-RA4eM+zyQwmK7tYvw6DQ@mail.gmail.com>
In-Reply-To: <CAMxfBF5WWQX3ZH0YcRZ_N8q4njTdG-RA4eM+zyQwmK7tYvw6DQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 17 Sep 2020 10:35:30 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfd9iWHDNo9v=COroD_wuYL0xmOkRt-63WS_7G3As=kXQ@mail.gmail.com>
Message-ID: <CAJKOXPfd9iWHDNo9v=COroD_wuYL0xmOkRt-63WS_7G3As=kXQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: ti: ti,pruss: fix schema ID
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 at 10:32, Grzegorz Jaszczyk
<grzegorz.jaszczyk@linaro.org> wrote:
>
> On Thu, 17 Sep 2020 at 09:05, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Add missing '#' to fix schema errors:
> >
> >   $id: 'http://devicetree.org/schemas/soc/ti/ti,pruss.yaml' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
> >   $schema: 'http://devicetree.org/meta-schemas/core.yaml' is not one of ['http://devicetree.org/meta-schemas/core.yaml#', 'http://devicetree.org/meta-schemas/base.yaml#']
> >   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml: ignoring, error in schema: $id
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > index cf7dc83f724f..037c51b2f972 100644
> > --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > @@ -1,8 +1,8 @@
> >  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  %YAML 1.2
> >  ---
> > -$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml
> > -$schema: http://devicetree.org/meta-schemas/core.yaml
> > +$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> I've double checked and "#" was present in the original patch sent and
> ack for upstream: https://patchwork.kernel.org/patch/11729649/
> It seems like something got wrong on linux-next but this is the only
> diff between original patch and one found in linux-next. Thank you for
> taking care of it.

Indeed that's weird. It must get lost when applying...

Best regards,
Krzysztof
