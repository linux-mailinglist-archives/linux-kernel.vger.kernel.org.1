Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E64282EAF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 03:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJEBtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 21:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEBtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:49:08 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79919C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 18:49:06 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id b4so1402469vkh.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lmMV2Y8mISG/tvEWlp6fnU0SdlI2sIGYtkotIAtRLw=;
        b=nnl422yTOPm6IkjE14WBio3h2Icx2/pcDWxb45tgMnk31zxzH7+tuWqYKj5XSTm+dr
         zfpvH49lM5TBLAWOaNuyfZpXsyjpPIp3TSJ6Wx9Gn47bRWr7ZSJsVpalVwWRpWVzLiQv
         WFb8GdZkYiLmazRgEepaYR9B0sfsPxR9a4clo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lmMV2Y8mISG/tvEWlp6fnU0SdlI2sIGYtkotIAtRLw=;
        b=bzAbivMsjiLMYdFN9ew6YoEKXTZHHvEsVL8u/53F1ChVPoxo12dDackoX7f2+3eRwN
         k0sktJzAYMkb7N3iMsplevJa5Bj9qofB1vDz6nnDzWt0SkkUudV29pOYfl4I30JnvfTU
         phMOCC7vKivSPiWgUH4CteNk8zajRrwTBxjask2ETQb/U9GDqq2c/bNUbOYViPqYePUz
         WZ/srYwBJhMwu+LbQT/4skZhRYQq3jokKSv23BgXpPWlRRafyYNyyr6auxtCXLNt6by4
         mhIdM7IQEH+760pwB5B6JCGunKvMNJ5+OZTWA7J+GK5rv7MrAlJ5pRq55+C7OCXtYGkl
         JbyQ==
X-Gm-Message-State: AOAM533PdT4fEsfXLLY9CMH/JUCZVA+VKYgFBHj78jL/a0F7u3t7mYs7
        OvUk0epnvFZEBGn2XaX51IDIcSLMTt7wnv0Brf/kcA==
X-Google-Smtp-Source: ABdhPJxVuKZU7HGy8n1aGfozCk+JpbflK7CVf3FkX7vnQkxcs5NLUy3KPbdtKx6uShjXr79sM56BrPINpqDtuPE9sOg=
X-Received: by 2002:a1f:a905:: with SMTP id s5mr1751735vke.10.1601862545471;
 Sun, 04 Oct 2020 18:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-7-enric.balletbo@collabora.com> <ee2b40c3-b565-22ed-34f4-4259d546a623@gmail.com>
In-Reply-To: <ee2b40c3-b565-22ed-34f4-4259d546a623@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 5 Oct 2020 09:48:54 +0800
Message-ID: <CANMq1KDNKsE5oWxsg-zPS1L07dZySjoQc-fRWsXc5ngdi98Kgg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] soc: mediatek: pm-domains: Add SMI block as bus
 protection block
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 4:56 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
> > From: Matthias Brugger <mbrugger@suse.com>
> >
> > Apart from the infracfg block, the SMI block is used to enable the bus
> > protection for some power domains. Add support for this block.
> >
> > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> > Changes in v2: None
> >
> >   drivers/soc/mediatek/mtk-pm-domains.c | 64 ++++++++++++++++++++-------
> >   include/linux/soc/mediatek/infracfg.h |  6 +++
> >   2 files changed, 53 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index b5e7c9846c34..38f2630bdd0a 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -56,8 +56,25 @@
> >
> >   #define SPM_MAX_BUS_PROT_DATA               3
> >
> > +#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {        \
> > +             .bus_prot_mask = (_mask),               \
> > +             .bus_prot_set = _set,                   \
> > +             .bus_prot_clr = _clr,                   \
> > +             .bus_prot_sta = _sta,                   \
> > +             .bus_prot_reg_update = _update,         \
> > +     }
> > +
> > +#define BUS_PROT_WR(_mask, _set, _clr, _sta)         \
> > +             _BUS_PROT(_mask, _set, _clr, _sta, false)
> > +
> > +#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)             \
> > +             _BUS_PROT(_mask, _set, _clr, _sta, true)
> > +
> >   struct scpsys_bus_prot_data {
> >       u32 bus_prot_mask;
> > +     u32 bus_prot_set;
> > +     u32 bus_prot_clr;
> > +     u32 bus_prot_sta;
> >       bool bus_prot_reg_update;
> >   };
> >
> > @@ -69,6 +86,7 @@ struct scpsys_bus_prot_data {
> >    * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> >    * @caps: The flag for active wake-up action.
> >    * @bp_infracfg: bus protection for infracfg subsystem
> > + * @bp_smi: bus protection for smi subsystem
> >    */
> >   struct scpsys_domain_data {
> >       u32 sta_mask;
> > @@ -77,6 +95,7 @@ struct scpsys_domain_data {
> >       u32 sram_pdn_ack_bits;
> >       u8 caps;
> >       const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
> > +     const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
> >   };
> >
> >   struct scpsys_domain {
> > @@ -86,6 +105,7 @@ struct scpsys_domain {
> >       int num_clks;
> >       struct clk_bulk_data *clks;
> >       struct regmap *infracfg;
> > +     struct regmap *smi;
> >   };
> >
> >   struct scpsys_soc_data {
> > @@ -175,9 +195,9 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
> >               if (bpd[i].bus_prot_reg_update)
> >                       regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
> >               else
> > -                     regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
> > +                     regmap_write(regmap, bpd[i].bus_prot_set, mask);
> >
> > -             ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
> > +             ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> >                                              val, (val & mask) == mask,
> >                                              MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >               if (ret)
> > @@ -193,7 +213,11 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> >       int ret;
> >
> >       ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
> > -     return ret;
> > +     if (ret)
> > +             return ret;
> > +
> > +     bpd = pd->data->bp_smi;
> > +     return _scpsys_bus_protect_enable(bpd, pd->smi);

Not a huge fan or reusing bpd for 2 different things.

I think this is easier to follow:

_scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
...
_scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);


> >   }
> >  [snip]
