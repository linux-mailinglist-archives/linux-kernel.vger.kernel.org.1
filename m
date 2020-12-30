Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF882E7CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgL3VYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 16:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgL3VYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 16:24:39 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 13:23:59 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v5so11774756qtv.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3JIH2KfcSRonErtkZqTRpOudCvLIbGBt7ERBPB2Wmk8=;
        b=gKH9KAv4kTyRe1sQX4bdLJ7yjd61FUJfS3pYh6ATPN93cHdzh1gMAL8KZ6QGgPp/aO
         DY7C+keOpVMkkmBEkejPsOhzrvEShk0WbqoppjFzfcHbKjjsjnnUBFu3KzKBLYK78E3U
         ELRYE1pv/Uzeiw621HlppDSoUj9IKg0A1Z/U/GhkCpsrcBryoOXvnMKKKHZwrycDzK9J
         no6uvbxY5aOgXdUf+6CFQ4hNsUgniTRYhIHlUUnmwtSpNQ5dwG75Odo2jnuL5JSve8q/
         orQogFYTOzFw8WrJpZ9NRKLY2XUptCfNaHYfQ9uN6LE0pub5GvpraCbIcDDMBhVk90p5
         AUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3JIH2KfcSRonErtkZqTRpOudCvLIbGBt7ERBPB2Wmk8=;
        b=RdgcJSx5ZMGtO0jhVCLVzzoiIgluYKFMvlAXvGJY2w9p4jTu7Zk8a5wVYSisyDm/Wd
         8b8u8YTGHn3gVY7Jey1hz8GoP+t6kZkD/BbBY6M13issYoUMs/EqGrcj86sNkWwohQZJ
         VM16KPA0LBpTjqkGnM6vC2RdQpXgehKN02R8CZXlK00bjAfruUXG54hJKdhNKkP1NUv8
         f2013+nyzhfbrEcgksCzAwOJlYWaIu7svMpBgT0YDZGj/H8cQOCw8ZtTkH/AdGzi9w9E
         vapvywRC/Oae4v20/Ld9xbwbxfJdryYBbQ4/Rkhbp/L9Kqp1cDdiZY6VMdHuz7dlvmNG
         6MXQ==
X-Gm-Message-State: AOAM533IKGhDc0NerB81CrVNqg1IYkqsaOfmWP9YPDKe/ADolmVcMo21
        wUrzkjWjO4f+sgAgMN4Q6rT2mg==
X-Google-Smtp-Source: ABdhPJynsmqHlAfiV8grdxXDmiM3GLqmENngmdB/r58gJRmAD6YxfPcRFo6pthzPvBPTcASpnu76Gg==
X-Received: by 2002:aed:2827:: with SMTP id r36mr54058903qtd.337.1609363438447;
        Wed, 30 Dec 2020 13:23:58 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id u4sm27590039qtv.49.2020.12.30.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 13:23:57 -0800 (PST)
Date:   Wed, 30 Dec 2020 16:23:56 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: re-fix __maybe_unused
 attribute
In-Reply-To: <20201230154304.598900-1-arnd@kernel.org>
Message-ID: <orno9ppp-no44-4rp5-s6-58n46rsps045@onlyvoer.pbz>
References: <20201230154304.598900-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns because the added __maybe_unused attribute is in
> the wrong place:
> 
> drivers/i3c/master/mipi-i3c-hci/core.c:780:21: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
> static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
>                     ^
> include/linux/compiler_attributes.h:267:56: note: expanded
> 
> Fixes: 95393f3e07ab ("i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <npitre@baylibre.com>

This might be the 3rd patch from 3 different people fixing the same 
thing. Looks like I3C maintainer is on vacation. Please feel free to 
send this trivial fix upstream some other way.

> ---
>  drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 500abd27fb22..1b73647cc3b1 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -777,7 +777,7 @@ static int i3c_hci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
> +static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
>  	{ .compatible = "mipi-i3c-hci", },
>  	{},
>  };
> -- 
> 2.29.2
> 
> 
