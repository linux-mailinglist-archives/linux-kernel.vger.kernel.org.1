Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5A2DF8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 06:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgLUFXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 00:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLUFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 00:23:43 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B1C061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 21:23:02 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id q10so4695398vsr.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 21:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJXbrMtWRBdURyC5I8B7LQNcHTL+iYONIS0ggY++dQQ=;
        b=QrUzix8Fst7ZZDuLtxjMMrLaH2B72HErGInIuInVYVA0GQfIFwcE7K0WMriuFh5FjK
         1ihLhsEd55ovSH88hN/Dt37Nec7f4+WAvtKtDGJCVapniADCjkqXmIzHgQyqJPOX2+Cd
         8JAS/08y99lMnolcGejh4pchDwKb9/ROWTCB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJXbrMtWRBdURyC5I8B7LQNcHTL+iYONIS0ggY++dQQ=;
        b=cKjxZvrzy+RD/32BEa8x0nPghBJWO/9CneLktN8GBrJmsLYpbR4q2R42mOCD2YGjQ1
         uXdlQfQoNpLphKo3atEXeLUmO8cZkl4OFt9P7It79OTCFZsjupp2jBuXCsAFcNSoIIZd
         Z8YF+M4Wd/TEaJ6GEujCSyjh76N0V9Xgr0TdCrCifgaESarJzeneNjTbbzVkCX4zF6xg
         Lsa4HCu8vi7rIyqVWutRlVFS3PBomCHQF8YDyggT6j0wUkLWR++3JwJ0kwL6cDKOHmfB
         EqTBxGNzooM5R7iooHHwksvgq/aNJ44xm4PUTlQ2ECi5ks8aE8lwf4nclRH0hxWaGFfI
         LCfQ==
X-Gm-Message-State: AOAM532dBZ3axcNss83qZRAAB+RMM52tx6+p/sxyKztfztSm5S72UoqP
        sJUXuO+/nUW3yxxTDDTyBvBC64YGgknfUl/qDGqPYCwRmdc=
X-Google-Smtp-Source: ABdhPJzscgPKR5t2JXjnNhwUgbK2V4PaGeerZvWez5wkalVhpklNTNAEkqmjlclzi4+3Mva086/apn/FbXVSXBz+d6E=
X-Received: by 2002:a1f:e385:: with SMTP id a127mr11231257vkh.18.1608517478697;
 Sun, 20 Dec 2020 18:24:38 -0800 (PST)
MIME-Version: 1.0
References: <1605700894-32699-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1605700894-32699-2-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1605700894-32699-2-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 21 Dec 2020 10:24:27 +0800
Message-ID: <CANMq1KCcso6sCMEeUSkft+UtDO=OjZ=yyY51n5m+2GMBYomzqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] soc: mediatek: pwrap: use BIT() macro
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fei Shao <fshao@chromium.org>,
        Argus Lin <argus.lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 8:08 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> Use a better BIT() marco for the bit definition.
> No functional changes, cleanup only.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 5d34e8b..c897205 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -27,8 +27,8 @@
>  #define PWRAP_GET_WACS_RDATA(x)                (((x) >> 0) & 0x0000ffff)
>  #define PWRAP_GET_WACS_FSM(x)          (((x) >> 16) & 0x00000007)
>  #define PWRAP_GET_WACS_REQ(x)          (((x) >> 19) & 0x00000001)
> -#define PWRAP_STATE_SYNC_IDLE0         (1 << 20)
> -#define PWRAP_STATE_INIT_DONE0         (1 << 21)
> +#define PWRAP_STATE_SYNC_IDLE0         BIT(20)
> +#define PWRAP_STATE_INIT_DONE0         BIT(21)
>
>  /* macro for WACS FSM */
>  #define PWRAP_WACS_FSM_IDLE            0x00
> --
> 2.6.4
>
