Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC21C28F0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgJOLWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgJOLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:22:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04BC061755;
        Thu, 15 Oct 2020 04:22:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v6so3101852lfa.13;
        Thu, 15 Oct 2020 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGCMKDJHnX/3RSDW25xtGUrV5WU8mJK2ylfsXOfPuY4=;
        b=fSMVRoIu6uMlsDmazzPtyhdDV5uLOVnyuPHWR/QhrJD71dffmz3w/UfM7tVIWimBOx
         t7QU8KUJPH3qTryVUc7FpMb8SPj0Ht92HdjgsAbdt3Pr+E4nVvj8yoXnkbmcOk38HoqZ
         yPDgbi1WEk8ffc6vSaXlRXWjp4wbg91/XU0Omqsy1RA929h9GSueKsejN3IbGDQ10zxF
         RMDlajqb50w4oZue7SI2Yvv+SBu3xUcwlRQAxAIowXNub0gUv0w0fYVX9vnBtIy0NFmJ
         cfJzJgZqLrxoremFFMNctAO6IwMEN00VPre79ODTHY6Cryl14hoQ24/oxmuya0hAPWmg
         2nEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGCMKDJHnX/3RSDW25xtGUrV5WU8mJK2ylfsXOfPuY4=;
        b=DNEzJGwFhc7c3H3qVBTGGh4nYXZJsBf3Z4KfF7+rY+cY+JRRRBjUfRwxQtgoHVmBbj
         xyzbbXXuhZsrIGx9PGOlGyJ61SCSzw0uufZXtfBHIwZ4PAzrdhcRGNnUcS7jqAXCijR+
         C8PkOeoyHDLDrpcWSlXkYI6P8LLNOVf3gvgHzJxrKQSDxjpY6y+fgU0aqnBqH8e0FRHf
         WYOPHuL9mTRpSTHDrLFfELURtPmcKwnCKDR5yMuLFdmQKCeoe2f0lrKVi5rldXCB2xGP
         rW4CES3+6GaI2d69vBXnsGidNN/uXkMudXb9aRvylqlp0xHvqVcWk15nRY5Q+BlAz0Z+
         yLxw==
X-Gm-Message-State: AOAM531Hji4PI+mltwmIjfzx944FuOV3v6Vk/YeGR2yMYrLeALlWsZkd
        u/PJ72nIv4rryEwHgDw1ckxvWAl5WhddI1eIvOw=
X-Google-Smtp-Source: ABdhPJwVrB+EgepMNS7j0APaZAjKdJsSlZYYH3z1GpGioMlGRGwxuKhvBlkMGzCudzMbx9H6AAoutxd9iL1k9ya+7Js=
X-Received: by 2002:ac2:4e90:: with SMTP id o16mr975830lfr.251.1602760957682;
 Thu, 15 Oct 2020 04:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1602753944-30757-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1602753944-30757-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 15 Oct 2020 08:22:28 -0300
Message-ID: <CAOMZO5DxZN_cniuy2xhYGWAr3rjNBZNJAJvYcH+KNBa+S7S2mg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Fix usdhc parents order
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Thu, Oct 15, 2020 at 6:26 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> According to the latest RM (see Table 5-1. Clock Root Table),
> both usdhc root clocks have the parent order as follows:
>
> 000 - 25M_REF_CLK
> 001 - SYSTEM_PLL1_DIV2
> 010 - SYSTEM_PLL1_CLK
> 011 - SYSTEM_PLL2_DIV2
> 100 - SYSTEM_PLL3_CLK
> 101 - SYSTEM_PLL1_DIV3
> 110 - AUDIO_PLL2_CLK
> 111 - SYSTEM_PLL1_DIV8
>
> So the audio_pll2_out and sys3_pll_out have to be swapped.
>
> Fixes: b80522040cd3 ("clk: imx: Add clock driver for i.MX8MQ CCM")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reported-by: Cosmin Stefan Stoica <cosmin.stoica@nxp.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
