Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA24C26A72E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgIOOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgIOO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:27:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E46C061788;
        Tue, 15 Sep 2020 07:25:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a22so2976974ljp.13;
        Tue, 15 Sep 2020 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14anG50Aa3WOKCmtLyBz8A0CHugiplkST/cPboXKO20=;
        b=ppO4PXPU2DK3J8X3ntQTbX2pO+BRWkBQ0sY9sUuSo4UknnFzoc9Iuhf1QvxmWFwPIm
         bL+uU6qEaM9TPGpnSL/GY1u1NkQMzmwtkmQJTOvEtACvkrs8uxexm8YKUZj8iXoD3yd+
         PRFVeoNiiSEPP7B0csc2yYmrRohSGUkoVs8bB1zry3HhZvY8ic6znknNGZHlx1tOmL1j
         SqVLqC/v2LtmCS8CNACBlS8hzGe3ltJC3tS+wpna73nJh6a9gZb4s2EZT60luYemPsGB
         agXR7zVBY8LlNbBFuCKcXqa+3uX6OrgimFzg0tflxFbMWitX65PGetcLf0+H0rGwYmJe
         r6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14anG50Aa3WOKCmtLyBz8A0CHugiplkST/cPboXKO20=;
        b=Sva+x8u+ceKV7lizqg/82oK7InkwlvOSb5wapu00GBnE1HPS6VbRMaYKX7Ou3/3Gu5
         G3UTsAE2H1oyUDFyBNEX59NjdPOyQC/ZoYdzLFvnFmokxJOwg9WrQ0g5/kmTaiMA++O5
         pjI2Y9TiVV8uEC29Pcz/Mf39o7VMJGynyybFQ4/DoXPUn7unzAVkcWUZ17vP5mnb3Dlv
         Lbjpk/CEW8XWkeLVYdon+IVDVs6rWeUYKqAjSWIfY6ekVN3Hcu5tjt9kzaSgseM6qRmE
         m5Pa/fYsv2BSzbLXQDRISkV4o0GO2cYvEzlWn1LPzYqgZ5bMpXJj/ik9tKWM7e6OzRwJ
         uQqA==
X-Gm-Message-State: AOAM530K3ndp/4wiyTYglq/IDInotBLC6rRlNnwpvP1WKvzfDiKKbhB0
        OpR8E8Mwc2lt7G9ucOcssbFQYKE6+mkwb5rUHHM=
X-Google-Smtp-Source: ABdhPJwxKUdCS3KhkVYxorMdgJHuiGff3gEzF7vwbDWHM02+OPgDqkCFaTmRmbSE3ebg8qhoKb6tYsx0c/GnhW16k0Y=
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr7660302ljh.44.1600179956643;
 Tue, 15 Sep 2020 07:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200915140159.23184-1-yuehaibing@huawei.com>
In-Reply-To: <20200915140159.23184-1-yuehaibing@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Sep 2020 11:25:45 -0300
Message-ID: <CAOMZO5AjsKZi7Z9KpY-53rj=DxAQkuWiRcUnVhTVP7dtRFSYew@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: imx31: Make mx31_clocks_init static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:02 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/clk/imx/clk-imx31.c:135:12: warning:
>  symbol 'mx31_clocks_init' was not declared. Should it be static?

Same as the other comment for mx35, This function should be removed.

I will send a patch removing it.
