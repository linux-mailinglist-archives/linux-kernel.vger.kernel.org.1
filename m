Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660FA2EBC59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbhAFK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAFK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:26:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D2C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:25:47 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 15so1927925pgx.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXZIAZqh+xBfL6TUuJ2CLNmbqo4XogXEQ6f21aMa31Y=;
        b=PvQYGRaylR7ZLMt781fGYH7PAdHnlOlFo5S+lEYXioh2rHtPWzCfHRyIVB+KUg4Uun
         llL7GxDSh2AbRHH6DbNpOA9f7A+/V9L92awzQOhE+TKdAR3MMgLHjaPIjQ6xUL6X3MVN
         2d7Wtvi6gGdp3FR36z7QbJlEGe62xFygXYpO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXZIAZqh+xBfL6TUuJ2CLNmbqo4XogXEQ6f21aMa31Y=;
        b=tE+tFVglaV4UM0kmFX60gf0PZr8+kVGA9XYu9gR/44aqUh1XOSGyVcXS59mcFJA4mx
         3r9HtsjQ6O0o51/coWQe/xom2vz+rNP9fY2XdEgm1BWm98q/qy9TVOGimjBla6y7d4w8
         pMt7npcI5bEMhavFfVLq6iqV3ucmZmnhdRBpFjZycm/nN4wZ60Gzxu6U0ptZ5/15ZYRH
         XglFqmbzLENo5tYSO/GEnPHF9qCf+yC+vC0cd2o5BVGqYriWgvRDWcj/gO5ftqbXEsLx
         BKBvH7v+ExzK/VLI4EtWuNln56FbydvEjDQCtgKk69tH7tK6T4CMhbWlKVvbZ5pE6+i7
         /CNA==
X-Gm-Message-State: AOAM532iW0dncjJowVHHgOBKllV2hrYRb7Gw1poUi/S7/oGe2qgflgR/
        ExHQ9Vk2E3xOuNQWIG17azWQkzhYcT6yVENLm/I2Fw==
X-Google-Smtp-Source: ABdhPJxY96erNkAHFypfbHgSjjHgHmIdlQRpp9DupO/lBseGLPIpK4TW4GgJIKZxB8lnC4qd4HT1DmjRhCQope01kAI=
X-Received: by 2002:a63:1a10:: with SMTP id a16mr3708292pga.317.1609928747355;
 Wed, 06 Jan 2021 02:25:47 -0800 (PST)
MIME-Version: 1.0
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com> <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 6 Jan 2021 18:25:36 +0800
Message-ID: <CAATdQgC_BnZywDxaZgmF72VRoAZ-1vFGrPD9GL4uEBhsKQTxnQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/22] clk: mediatek: Add MT8192 basic clocks support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 9:14 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add MT8192 basic clock providers, include topckgen, apmixedsys,
> infracfg and pericfg.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig      |    8 +
>  drivers/clk/mediatek/Makefile     |    1 +
>  drivers/clk/mediatek/clk-mt8192.c | 1326 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mux.h    |   15 +
>  4 files changed, 1350 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8192.c
>

<snip>

> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> index f5625f4..afbc7df 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -77,6 +77,21 @@ struct mtk_mux {
>                         _width, _gate, _upd_ofs, _upd,                  \
>                         CLK_SET_RATE_PARENT)
>
> +#define MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,          \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _upd_ofs, _upd, _flags)                         \
> +               GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,  \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       0, _upd_ofs, _upd, _flags,                      \
> +                       mtk_mux_clr_set_upd_ops)
> +
> +#define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,                        \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _upd_ofs, _upd)                                 \
> +               MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents,             \
> +                       _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,   \
> +                       _width, _upd_ofs, _upd, CLK_SET_RATE_PARENT)
> +

conflicts, these macros are already existed in upstream.

>  struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
>                                  struct regmap *regmap,
>                                  spinlock_t *lock);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
