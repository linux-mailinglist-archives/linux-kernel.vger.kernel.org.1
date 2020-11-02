Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49602A25AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKBHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgKBHxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:53:41 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3219E2223C;
        Mon,  2 Nov 2020 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604303620;
        bh=iXFXlIxzo6mEuRbhfEI2cZTIEJwsOtvvLLIzi+xj3k4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l2iXFvJ5TKiHGm2H2qhJ8UZhLfu+xl8wgP1683sivUlrippNMVG1tuFu3l+DOyNhk
         wACruFfQljRDZ2RQC2pgMo1x3MC4+4AaG9/rEPqSEBT5WqwH0X13fS3h9b3XrwBdpH
         QB8PXdcWoJ7NZXPCV3Fqs/T+UMfcgO2Qf5gXJt7s=
Received: by mail-ej1-f43.google.com with SMTP id cw8so4011130ejb.8;
        Sun, 01 Nov 2020 23:53:40 -0800 (PST)
X-Gm-Message-State: AOAM533Dep81wS9Tkf+55HlTPiv3U+KyrZl0tlXv8zXlyS9a+w9xSxrt
        b4NSfMWDlylH5ju0AK99y9Hcg9HGnicJ4xqKhz0=
X-Google-Smtp-Source: ABdhPJwrevmNFDi1+ho8xYZZMC8Zs02UNBVWMPiQlQWPrCoMlPylk2aWDQx4j1s/36cKVA0piAyvfZef46tp+4IihZ4=
X-Received: by 2002:a17:907:d1e:: with SMTP id gn30mr1374045ejc.148.1604303618691;
 Sun, 01 Nov 2020 23:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20201030091254.26382-1-yong.wu@mediatek.com> <20201030091254.26382-2-yong.wu@mediatek.com>
 <20201031113623.GA4019@kozik-lap> <1604295074.26323.107.camel@mhfsdcap03>
In-Reply-To: <1604295074.26323.107.camel@mhfsdcap03>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 2 Nov 2020 08:53:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfTmXuBOWgrmgCfQcqhXxoVjE=9T=m1weRS=H4hV0bYog@mail.gmail.com>
Message-ID: <CAJKOXPfTmXuBOWgrmgCfQcqhXxoVjE=9T=m1weRS=H4hV0bYog@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 at 06:31, Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Sat, 2020-10-31 at 12:36 +0100, Krzysztof Kozlowski wrote:
> > On Fri, Oct 30, 2020 at 05:12:52PM +0800, Yong Wu wrote:
> > > Convert MediaTek SMI to DT schema.
> > >
> > > CC: Fabien Parent <fparent@baylibre.com>
> > > CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  .../mediatek,smi-common.txt                   |  50 -------
> > >  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
> > >  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
> > >  .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
> > >  4 files changed, 269 insertions(+), 100 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> >
> > +Cc Honghui Zhang,
>
> As comment [1], Honghui's address is not valid now. I will act for him.
>
> >
> > Your Ack is needed as you contributed descriptions to the bindings and
> > work is being relicensed to GPL-2.0-only OR BSD-2-Clause.
>
> "GPL-2.0-only OR BSD-2-Clause" is required when we run check-patch.
>
> If I still use "GPL-2.0-only", then the contributors' Ack/SoB is not
> needed, right?

That would be one solution but I was thinking to proceed with only
your agreement. You were the main contributor to these files. Honghui
added a few descriptions. Other developers added only compatibles.
Since we cannot reach Honghui, I would assume that your agreement
(Sign-off) is enough.

Best regards,
Krzysztof
