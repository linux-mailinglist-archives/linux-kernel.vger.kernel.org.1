Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548462781C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgIYHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:38:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:38:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g128so1695905iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSlR7yshzs0vfD4qPWNZEu/SYrxh7Zbl3JNQb6YVoEo=;
        b=atpqJKWoZXGRivEFWDBvGz9MrPw2nALn9XkmQ1aWt6UPrX3SDtd+E97cX8Ctn1fkCX
         Ql/+h8Zc7F7Rh65N4MWlxyD9RAFselx5Ek5XVOG0Vrr9KXAygVLpDX2FO+6orc/CONfx
         Brl/TvfshMxqQBtKSiENR81iGijnMtQrgJEK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSlR7yshzs0vfD4qPWNZEu/SYrxh7Zbl3JNQb6YVoEo=;
        b=N1GDjNQFmYHW/337fTWM19YRQUw6Ru+RagJEdNyv570WXtUra/UWKM/c3oK8v9zPDB
         fk95zmY7doUsLWBN2cQhcK1NB+kXiynWHLtX8pc2U0zmipOM5cDJ5SpxP+SIaj/paxON
         kEGV7lh0zraX4dY/qFrLXedX4RoDcQqTdtdoaUZm1srF5vaf2Wc5x8QkILsI69iLlYdo
         O6z6iZ7M+WGy9qfVoWuM2GeXccKvxtVBxBb2ks79hB85KNTcTNaWgsBAmYvVZ4XWnNSy
         7PnbIQFZLTFzl9WdzFlp4Ov3dqHqk4gHqzyC+p2d7drNKq7Yp8sxnBRxxqeMTXosD7HA
         RxDQ==
X-Gm-Message-State: AOAM533XMJrOPMNPkrYl7p6070F9JV2zHXBueyvVLrUUrljM8w/jSexb
        35jG0T4m4n0G59i0Ov+KlgC8L8hLYpxTG6TKkno2Jg==
X-Google-Smtp-Source: ABdhPJzUHA+P0LdctUDvSxo8BvBlN6E75g98pitS7hCUaG5V1uFkbP3sHz6ED9DkJYz6tkq+TZIbHgnrWSAdYUfHeDo=
X-Received: by 2002:a6b:6c0c:: with SMTP id a12mr2307062ioh.40.1601019480794;
 Fri, 25 Sep 2020 00:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-12-enric.balletbo@collabora.com> <730273b4-914a-8a7a-1583-351e6f20df5b@gmail.com>
 <5e1510f4-b0c4-2cff-b3f8-b6715d228149@gmail.com>
In-Reply-To: <5e1510f4-b0c4-2cff-b3f8-b6715d228149@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 25 Sep 2020 15:37:34 +0800
Message-ID: <CAJMQK-jFwToRxBdVgtHT3wJ970M0NYGu3kLtkGRBDKMMNOHkJw@mail.gmail.com>
Subject: Re: [PATCH 11/12] soc: mediatek: pm-domains: Add support for mt8183
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Nicolas Boichat <drinkcat@chromium.org>, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 8:19 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 16/09/2020 11:46, Matthias Brugger wrote:
> >
> >
> > On 10/09/2020 19:28, Enric Balletbo i Serra wrote:
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Add the needed board data to support mt8183 SoC.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >>   drivers/soc/mediatek/mtk-pm-domains.c | 162 ++++++++++++++++++++++++++
> >>   include/linux/soc/mediatek/infracfg.h |  28 +++++
> >>   2 files changed, 190 insertions(+)
> >>
> >> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
> >> b/drivers/soc/mediatek/mtk-pm-domains.c
> >> index 29e88adc8ea6..aa434f616fee 100644
> >> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> >> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > [...]
> >> +/*
> >> + * MT8183 power domain support
> >> + */
> >> +static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
> >> +    [MT8183_POWER_DOMAIN_AUDIO] = {
> >> +        .sta_mask = PWR_STATUS_AUDIO,
> >> +        .ctl_offs = 0x0314,
> >> +        .sram_pdn_bits = GENMASK(11, 8),
> >> +        .sram_pdn_ack_bits = GENMASK(15, 12),
> >> +    },
> >> +    [MT8183_POWER_DOMAIN_CONN] = {
> >> +        .sta_mask = PWR_STATUS_CONN,
> >> +        .ctl_offs = 0x032c,
> >> +        .sram_pdn_bits = 0,
> >> +        .sram_pdn_ack_bits = 0,
> >> +        .bp_infracfg = {
> >> +            BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CONN, 0x2a0, 0x2a4, 0x228),
> >
> > We have repeating values triplets for set, clear and status register in infracfg
> > and SMI.
> >
> > Weiyi can you help to get names to this registers? I wasn't able to find
> > anything in the datasheet.
>
> I think for the infracfg part I figured it out:
>
> #define INFRA_TOPAXI_PROTECTEN_SET      0x2a0
> #define INFRA_TOPAXI_PROTECTEN_CLR      0x2a4
> #define INFRA_TOPAXI_PROTECTEN_STA1     0x228
>
> #define INFRA_TOPAXI_PROTECTEN_1_SET    0x2a8
> #define INFRA_TOPAXI_PROTECTEN_1_CLR    0x2ac
> #define INFRA_TOPAXI_PROTECTEN_STA1_1   0x258
>
> #define INFRA_TOPAXI_PROTECTEN_MCU_SET  0x2d4
> #define INFRA_TOPAXI_PROTECTEN_MCU_CLR  0x2d8
> #define INFRA_TOPAXI_PROTECTEN_MM_STA1  0x2ec
>
> Weiyi, can you still provide the register names for the SMI?
>
> Thanks in advance!
> Matthias
>
Hi Matthias,

SMI names are
#define SMI_COMMON_CLAMP_EN 0x3c0
#define SMI_COMMON_CLAMP_EN_SET 0x3c4
#define SMI_COMMON_CLAMP_EN_CLR 0x3c8

Thanks
