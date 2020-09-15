Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E327269B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIOBe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIOBeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:34:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EFCC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:34:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so971343pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cRkQqsd5/nMJvkAtEIwXedLifA/J5I9RA/QsRwT0Po=;
        b=j8RWSxHVCSsQ5pqbMPqEVtC7X7eF2Q1w5+mbUuzLiRgEr75GCf+uQsRl5dI7Xhxci3
         vxyXnRMyp36UXCTA2xl5nvwyJDrXlJCd1q1bK+YOSP1RfWbqkJg45GtJMT0NIcUcji0m
         9lPsXoOMx1r3PXCVwproLMabG54qKCpAxSxOD+R86DXRAnPWKOqNYIxDzpzcRszdCIti
         1dQa3CKIi8yCk+2sqNBHIcU2Tk41FgkYTWSP1wX7q5eHJfzmswHjMFABq0cCGCEK6Kbb
         j+2uwygE9QXefQ32j9VvU1X3TouI1yxkwcA43/mqJsFb/A8Vc3Cy5HEbmJPriiihM1ZA
         ZB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cRkQqsd5/nMJvkAtEIwXedLifA/J5I9RA/QsRwT0Po=;
        b=Ah8rfd6ttbMvlkoHSNyn/io8X5zCbt4wCtHiimaGmJJqZqgwXYoXDyHym2pEN6VzJt
         eAifkARjklnzNExUYKg1d7ePZUJxrzqXJhGtt2eWl3cXFQzP8BXKSGO1yV06psZtjFyE
         orxZ/kbfIN8cjZBxdyt9ytyTTtiShnzNjB2KlX9h47612CQm9B6uIVlYwdSCLejsIY4t
         kGeJOEc+8gXLWt28T3lxVB7YHdBpOVpMnctJLWjDZv5qjqbwd4jE2JA+eo89lHsO3yMJ
         qNsm0moGLSjqJdKXCGQT7fsGDQekRZwNKM6sxAltT+iS1FN64Fi2pxdj/x7HYuHLyW1k
         nL3w==
X-Gm-Message-State: AOAM5311M+QPPaL1BquG0xz0MlEUeWdUH3glt8W/rnWM/z7LP1zeVADU
        YorkUyOrPQyi1POHOZQROC5IVeCuuQ14cAk/
X-Google-Smtp-Source: ABdhPJxe6as0KiEIkzbsDttTiaOolP7z3p4kBXo77bQNMz5IrueN1c0m2cjTLDv1Oas4El51uieGgA==
X-Received: by 2002:aa7:8051:0:b029:13e:d13d:a0f7 with SMTP id y17-20020aa780510000b029013ed13da0f7mr14960610pfm.19.1600133657429;
        Mon, 14 Sep 2020 18:34:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w195sm11500229pff.74.2020.09.14.18.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:34:16 -0700 (PDT)
Subject: Re: [PATCH] tools/io_uring: fix compile breakage
To:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20200914213609.141577-1-dgilbert@interlog.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa89c176-df34-8e96-f273-4dd52882a070@kernel.dk>
Date:   Mon, 14 Sep 2020 19:34:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914213609.141577-1-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 3:36 PM, Douglas Gilbert wrote:
> It would seem none of the kernel continuous integration does this:
>     $ cd tools/io_uring
>     $ make
> 
> Otherwise it may have noticed:
>    cc -Wall -Wextra -g -D_GNU_SOURCE   -c -o io_uring-bench.o
> 	 io_uring-bench.c
> io_uring-bench.c:133:12: error: static declaration of ‘gettid’
> 	 follows non-static declaration
>   133 | static int gettid(void)
>       |            ^~~~~~
> In file included from /usr/include/unistd.h:1170,
>                  from io_uring-bench.c:27:
> /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note:
> 	 previous declaration of ‘gettid’ was here
>    34 | extern __pid_t gettid (void) __THROW;
>       |                ^~~~~~
> make: *** [<builtin>: io_uring-bench.o] Error 1
> 
> The problem on Ubuntu 20.04 (with lk 5.9.0-rc5) is that unistd.h
> already defines gettid(). So prefix the local definition with
> "lk_".

Thanks Doug - I haven't really been maintaining the examples in
the kernel, only in liburing. I'll apply this one, and hopefully
sync them up for 5.10 in general.


-- 
Jens Axboe

