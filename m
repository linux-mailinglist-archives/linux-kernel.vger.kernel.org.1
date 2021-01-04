Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C866F2E9416
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhADL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbhADL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:29:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:28:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m5so31769337wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bN+XHseAxF1cN3KkjF6tONZBRdBxyfyc8MAluXKpr2A=;
        b=kMCYusRGiaVPPK5hhaPhsvq/1+5kV/nrKFKPh1CGMatXqvHvKbWGAyveSxWWvlaRzu
         UhxLQHpntZwdFHDNYu2GoJbAwSO4RiQjK2f57XCuJEo3PXhtz4Bv6rwQ4pzppJOCzbZh
         iOYLlyOcr7ust1RqvFdOHMyLm8apEJ06yPsJvChFUtk56qSj8f8L2gzHYZzum6Glp/sm
         74QpZSZ1wRtUMHYvW9wGZSWKRTda17Xameohp5Pm3V5x6VE+kZearQy/ELfWc77nLQm5
         +uhnIYyz2zJkZwaQHFNHaXrfgBDJUvI+2MBHyNPNSQ5PvARHZMti2DtCO25f7ViF/fZL
         laBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bN+XHseAxF1cN3KkjF6tONZBRdBxyfyc8MAluXKpr2A=;
        b=cljRb77wdXskuQuZV1X/Tz+hJvY5434MJf5riUFP5Ghj59GY2Ir/qraSU3mt81KA7w
         sQmb9ZbCOGbIELlGmF1dX+RMXm6zjpvoX27LhUsvsGYHtS8u6/22LbXvQK/luplhQPtO
         BqVhzWQcIfnN7fAn+ZzHAy+U3LqGAVvdWy9bciE79H1hRPjB3Q+KmOMZsAgBqmkNfTeE
         wYD1q3Qm16cxnxIKMVNqwGORqRnJqCNAvVWG9hcKYmM9jQNuLn1ldRlG4WxSy+JypQYT
         /X2HVlp8vliXtHqnCqAoE8VX1Pl0YTxsDsCXUk9Gw/BqU9Opa8wV5BnixKawm/fuzmiQ
         8/Dg==
X-Gm-Message-State: AOAM532KnDlh46tY55tdPTYS1bSFgDhGMOhuSSjnShVi+Z1js3LAq2MJ
        PmQtrC8Fqk3XkQt5LTpkXkwFAg==
X-Google-Smtp-Source: ABdhPJyQQ/nK41ENhRlImgd9bXEsfp2DjH5iBSAezHMDV+4M1ZWzHjJ2PziuEA4zMDlz/oq5rRAsXg==
X-Received: by 2002:adf:e511:: with SMTP id j17mr78529027wrm.416.1609759736982;
        Mon, 04 Jan 2021 03:28:56 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id a13sm85538256wrt.96.2021.01.04.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 03:28:56 -0800 (PST)
Date:   Mon, 4 Jan 2021 11:28:54 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Defang Bo <bodefang@126.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Message-ID: <20210104112854.fghr32y37mzw6fpb@holly.lan>
References: <1609120738-202321-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609120738-202321-1-git-send-email-bodefang@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:58:58AM +0800, Defang Bo wrote:
> Similar to commit<1bd54d851f50>("kgdboc: Passing ekgdboc to command line causes panic"),
> kgdbts_option_setup does not check input argument before passing it to strlen.
> The argument would be a NULL pointer.

Something seems to be missing here.

The ekgdbts parameter mentioned in the subject line doesn't exist so
how can including it on the kernel command line could provoke a panic.

Please can you share the kernel boot arguments you used when you tested
this patch?


Daniel.


> Signed-off-by: Defang Bo <bodefang@126.com>
> ---
>  drivers/misc/kgdbts.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 945701b..b077547 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -1057,6 +1057,11 @@ static void kgdbts_run_tests(void)
>  
>  static int kgdbts_option_setup(char *opt)
>  {
> +	if (!opt) {
> +		pr_err("kgdbts: config string not provided\n");
> +		return -EINVAL;
> +	}
> +
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
>  		printk(KERN_ERR "kgdbts: config string too long\n");
>  		return -ENOSPC;
> -- 
> 2.7.4
> 
