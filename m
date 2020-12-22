Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978522E04A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgLVDNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgLVDNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:13:45 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C5C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:13:05 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 186so10849492qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=m05zgiVp7vEyQC1XJrHfLcHgUliHm1rlFtZRMu57ZTY=;
        b=DrCYH2SJ9+T/fq+owxPY5/xY7kbiAWDSFkNPzFhLDl9xtPVRGE2JqP9thJKJ1L0V1r
         Jd+HZ7Oaq8KegpckZov+nPsI2Bqrf+pfrZ+9yjBOLHt+Y5qwHRYTinkQdVd8OSAqZRUF
         zpZTZLa+/mlR9xrRSxPbn09yOLixGRMHwNVIfYjIzKmu7uF8UehWjMTs1MgQbLbpAmR9
         3t15F6SzGy6EBcKI/PBgeo4jEUuRit/FImgzQVx5Ah3QzbQ/yX3faHVxA+J+R14sTLcn
         8GEMqTSnGxjqH60VjFhQhmgU5XJI6shJKCuQMn+fgJME16av5n60ixH5wpo9/v7u5ktD
         9WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=m05zgiVp7vEyQC1XJrHfLcHgUliHm1rlFtZRMu57ZTY=;
        b=mydgc5V9c2MkwEY1K4GKAnPAgJBrDlDwTvvf0WWIimzu1mysLbu7pOStESw4qRG6kj
         t+JSf3YlG+DFwjK8XZb4aHYTDCMKVKu8/OoC+J1FRt4FvTjNumpjpn6jLWJszPoI+2oy
         OEFoL6yKPq5j8iec8vc30QsU+6tm22JOh/kdEkTkLlZfNO48L1Hm0wzApXFfvYahpxaG
         zIZExgsf8KqYa43HniTss0cNmG6UyHxuzivFxfScxxH48K1hK3l6odACAQcLbkO5axrl
         K0VFTgjTKtpX+I5IzZNiExKkF8lrmm/Hix4gVgUQHzlzAAtHYptRmcEHO8XHXvNF6ohB
         XfxA==
X-Gm-Message-State: AOAM533Gtu4R/0g9ynz+S5Os4Ll6kbvr4xBehBV+Mx9ULWNJTxITT065
        kl0uaU4j3+JlZWnvJNb5Gd3KAQ==
X-Google-Smtp-Source: ABdhPJxWptLxMFAJyPVKQHaofZKNgOqncOvoZhhaGhBgI+xsVtgSCXpubml5l6bSl97/zbU5tTt6Ig==
X-Received: by 2002:a37:a950:: with SMTP id s77mr20614114qke.122.1608606784306;
        Mon, 21 Dec 2020 19:13:04 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id d84sm3976584qke.47.2020.12.21.19.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 19:13:03 -0800 (PST)
Date:   Mon, 21 Dec 2020 22:13:02 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Fix position of __maybe_unused
 in i3c_hci_of_match
In-Reply-To: <20201222025931.3043480-1-natechancellor@gmail.com>
Message-ID: <4q7rono-ssrr-r53-2796-o6924496p0qo@onlyvoer.pbz>
References: <20201222025931.3043480-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020, Nathan Chancellor wrote:

> Clang warns:
> 
>  ../drivers/i3c/master/mipi-i3c-hci/core.c:780:21: warning: attribute
>  declaration must precede definition [-Wignored-attributes]
>  static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
>                      ^
>  ../include/linux/compiler_attributes.h:267:56: note: expanded from macro
>  '__maybe_unused'
>  #define __maybe_unused                  __attribute__((__unused__))
>                                                         ^
>  ../include/linux/mod_devicetable.h:262:8: note: previous definition is
>  here
>  struct of_device_id {
>         ^
> 1 warning generated.
> 
> 'struct of_device_id' should not be split, as it is a type. Move the
> __maybe_unused attribute after the static and const qualifiers so that
> there are no warnings about this variable, period.
> 
> Fixes: 95393f3e07ab ("i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1221
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Nicolas Pitre <npitre@baylibre.com>

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
> 
> base-commit: 95393f3e07ab53855b91881692a4a5b52dcdc03c
> -- 
> 2.30.0.rc1
> 
> 
