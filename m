Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF62E81EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 21:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLaUec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 15:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 15:34:32 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ECEC061573;
        Thu, 31 Dec 2020 12:33:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y19so45870478lfa.13;
        Thu, 31 Dec 2020 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4Z0pWIFGtM6X6R1FwLJcNBd0lwNFuPd++vDIFFZllo=;
        b=uUOIM2OXNIp+oVW4jzxgmhE6xcMYp64DrAqVb3P34YVDcnpB6H20LpMsT5hcaT/wL9
         HHnYbiVvRGFB+UMpRODO3co73qCfTGtasWmNK/2kLEcbuu2b2c9CWi65BvVkvJwgiXmi
         ChEIxFg1LIXUTP6jtFEM1VEuSv6yr/S/vNTBvsk4JYciKJHWMWa719Ezqf7AENShRZyu
         lbIcD8d2pxYF3GpvGkE9+b8rhpXgeVhILlmuBwQTUSjUbLu7aLRGe9IQ0uhgqnEXCJWs
         vlIWUc78iijEoWbHUvQ8gjp3OaJy7v44Bpz2DVluq3SgmJZJubqBOc1EIJusIREr5M/A
         gtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4Z0pWIFGtM6X6R1FwLJcNBd0lwNFuPd++vDIFFZllo=;
        b=jVBiAIrgLvjNNorKbPK4LR4VEkyViPzvyE9Ivw9Mz2yGfnAivrazeYm+kxdeMYVx1c
         91X4czOxUTcyWpJfbmQPtmxjBJBhwOFHnS0AMBU93cI3DKYVEXnmjX+b421qdVkDp4V4
         dv4o9uwKMBKJB64RyqJTIl91YALrIbuPkCgn5rXodnSDVZd0Q8Aml3VD8kBkyqVdstSs
         MgZF6b7FERK+GivIo2UNCVVFOWpP8RslDcgPKSHb28ZyaD8YTr606U8EkzSISm54ADyE
         17lxjlC3UKRmHHLbE0nUpd6S3/2gIsFN//er28GuBnn1ZlElxTqDAxvjUnRSbZTBHZt/
         oa2w==
X-Gm-Message-State: AOAM532ANfYZ4+RdLdKKrfUWwN1IWQKlC0y8iVSCXOftq1WjONMRd7Ig
        gfBSnnLDkJNdA2zcdc5T+DH6wMdEZh3YsFt3jMw=
X-Google-Smtp-Source: ABdhPJxI4tqOHYU3yeIJgOUKAcrZh0k3UM5YbfYFWUgpn8oO6cDqd0BsDvKtdWuIuThm6Pae8syL0gaL42+nZ5GO8YA=
X-Received: by 2002:a2e:8416:: with SMTP id z22mr30306266ljg.347.1609446829839;
 Thu, 31 Dec 2020 12:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20201231142149.26062-1-martin.kepplinger@puri.sm>
In-Reply-To: <20201231142149.26062-1-martin.kepplinger@puri.sm>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 31 Dec 2020 17:33:40 -0300
Message-ID: <CAOMZO5Bq5Qs90iZQTpouv5wW_xf0CQcP-i-+c-Jp-_Ftvhknnw@mail.gmail.com>
Subject: Re: [PATCH] Revert "clk: imx: fix composite peripheral flags"
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Thu, Dec 31, 2020 at 11:22 AM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> This reverts commit 936c383673b9e3007432f17140ac62de53d87db9.
>
> It breaks clock reparenting via devfreq on the imx8mq used in the
> Librem 5 phone. When switching dram frequency (which worked before)
> the system now hangs after this where the dram_apb clock cannot be
> set:
>
> [  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
> set dram_apb parent: -16
> [  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc
> failed freq switch to 25000000 from 800000000: error -16. now at 25000000
> [  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
> update frequency from PM QoS (-16)

I am wondering whether IMX8MQ_CLK_DRAM_ALT should also be marked as
CLK_IS_CRITICAL.

Could you please try the following change without the revert?

--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -458,7 +458,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
         * Mark with GET_RATE_NOCACHE to always read div value from hardware
         */
        hws[IMX8MQ_CLK_DRAM_CORE] =
imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1,
imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels),
CLK_IS_CRITICAL);
-       hws[IMX8MQ_CLK_DRAM_ALT] =
__imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base +
0xa000, CLK_GET_RATE_NOCACHE);
+       hws[IMX8MQ_CLK_DRAM_ALT] =
__imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base +
0xa000, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
        hws[IMX8MQ_CLK_DRAM_APB] =
__imx8m_clk_hw_composite("dram_apb", imx8mq_dram_apb_sels, base +
0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);

Thanks
