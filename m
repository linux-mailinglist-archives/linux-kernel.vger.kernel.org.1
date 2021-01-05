Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6192EAA8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbhAEMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:18:24 -0500
Received: from mail.v3.sk ([167.172.186.51]:60940 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbhAEMSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:18:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 52AEFE0987;
        Tue,  5 Jan 2021 12:14:03 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D5dhQFC0vdUF; Tue,  5 Jan 2021 12:14:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 67D2BE0968;
        Tue,  5 Jan 2021 12:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B-_uerC0PAmZ; Tue,  5 Jan 2021 12:14:01 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7946AE0957;
        Tue,  5 Jan 2021 12:14:01 +0000 (UTC)
Date:   Tue, 5 Jan 2021 13:17:32 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: mmp2: fix build without CONFIG_PM
Message-ID: <20210105121732.GA811711@demiurge.local>
References: <20210103135503.3668784-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103135503.3668784-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 02:54:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> pm_clk_suspend()/pm_clk_resume() are defined as NULL pointers rather than
> empty inline stubs without CONFIG_PM:
> 
> drivers/clk/mmp/clk-audio.c:402:16: error: called object type 'void *' is not a function or function pointer
>         pm_clk_suspend(dev);
> drivers/clk/mmp/clk-audio.c:411:15: error: called object type 'void *' is not a function or function pointer
>         pm_clk_resume(dev);
> 
> I tried redefining the helper functions, but that caused additional
> problems. This is the simple solution of replacing the __maybe_unused
> trick with an #ifdef.
> 
> Fixes: 725262d29139 ("clk: mmp2: Add audio clock controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you.

Acked-By: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  drivers/clk/mmp/clk-audio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mmp/clk-audio.c b/drivers/clk/mmp/clk-audio.c
> index eea69d498bd2..7aa7f4a9564f 100644
> --- a/drivers/clk/mmp/clk-audio.c
> +++ b/drivers/clk/mmp/clk-audio.c
> @@ -392,7 +392,8 @@ static int mmp2_audio_clk_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused mmp2_audio_clk_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int mmp2_audio_clk_suspend(struct device *dev)
>  {
>  	struct mmp2_audio_clk *priv = dev_get_drvdata(dev);
>  
> @@ -404,7 +405,7 @@ static int __maybe_unused mmp2_audio_clk_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused mmp2_audio_clk_resume(struct device *dev)
> +static int mmp2_audio_clk_resume(struct device *dev)
>  {
>  	struct mmp2_audio_clk *priv = dev_get_drvdata(dev);
>  
> @@ -415,6 +416,7 @@ static int __maybe_unused mmp2_audio_clk_resume(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
>  static const struct dev_pm_ops mmp2_audio_clk_pm_ops = {
>  	SET_RUNTIME_PM_OPS(mmp2_audio_clk_suspend, mmp2_audio_clk_resume, NULL)
> -- 
> 2.29.2
> 
