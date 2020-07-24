Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3341E22CB23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:34:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164EC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:34:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so5458648pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KxUVJu2tVsXuL6ozXtsDLOIo+4JxBbyht8pFne+rsMU=;
        b=K7XpyhQvrenGn2Xu15vi76JcRUT9sC1liRgYcCIGd9iGI1u0NGrLkxgPuwufFBfvx0
         I/C3wBLb9TCtHH5QjgJVmj4daBGbHavWk+DVx/3IjdtnfdkCBBhocCDJT5Rxnu8BvzeN
         mCqzqbB59MjQsoiZzBtZ15Q/yIgmPozIOIx1SlN02Pg/DvEWOqWCyl5hsjbzqBE6K5Db
         Fa6O+23rfJS3D1mMkhzPo+FLntzB0TbISxoiWU2HQcOpkERblpEAgh2EsVdLGDpvvtLV
         JkZBYmpwFdV+YU9UiXZtLLkqDrlg4J1mnyx8QF6UgHCGszO1D6Kjxn3qln+FBsCEJ+pl
         LyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxUVJu2tVsXuL6ozXtsDLOIo+4JxBbyht8pFne+rsMU=;
        b=FA5Wrg3wEcMM23wpJAUaY2DW2IRtcPSkuvlJJ0XbbmJzEwIIhsfZZdmAqApfHI2uUh
         dw8ahFIDADHSv7BVtLTSJguHMmuu4Y9XGAcZpu8bKvxYU0q6gY3Tt1gQmBzYuLc3cLFi
         obUZH5zGvL2btFX0LHwmu8AqbZ2aZwlf5Zqk8fxQrS4Fj9PsI0fKvWQo4sJKJNsn+HRh
         +UHTLjpbGNLLbiThirQc8fHZAfAWbxDKLz+/+ULkPnib/3wI6uaNsbziAWGlkJgwOHgK
         B6NR8ICuse8rptCjEzLwQzVEAaa10M5DUT54Je8/em7HiIleRUeMuwks461v8ps4kxz8
         jPhg==
X-Gm-Message-State: AOAM533sUGiL5f9lnTyHFC31eYvQqJJxRcorEol7rTHMtfUZgDy2qngJ
        1SORPV+kk/NUj3T/uAG+w1Rjhg==
X-Google-Smtp-Source: ABdhPJy4sWKBDhVsVVTB4Rz+Di1yRjyZBmXNP884n02aTr/meZ8zL6S9UB8hgZlBhiOPmt1234c8iw==
X-Received: by 2002:aa7:970a:: with SMTP id a10mr10129338pfg.319.1595608473248;
        Fri, 24 Jul 2020 09:34:33 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y6sm6486959pji.2.2020.07.24.09.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 09:34:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] fs: introduce FMODE_ZONE_APPEND and
 IOCB_ZONE_APPEND
To:     Kanchan Joshi <joshi.k@samsung.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org
Cc:     willy@infradead.org, hch@infradead.org, Damien.LeMoal@wdc.com,
        asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <1595605762-17010-1-git-send-email-joshi.k@samsung.com>
 <CGME20200724155258epcas5p1a75b926950a18cd1e6c8e7a047e6c589@epcas5p1.samsung.com>
 <1595605762-17010-2-git-send-email-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <733bb8bb-cd4f-bee7-516d-359c565d11d3@kernel.dk>
Date:   Fri, 24 Jul 2020 10:34:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595605762-17010-2-git-send-email-joshi.k@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 9:49 AM, Kanchan Joshi wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6c4ab4d..ef13df4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File does not contribute to nr_files count */
>  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
>  
> +/* File can support zone-append */
> +#define FMODE_ZONE_APPEND	((__force fmode_t)0x40000000)

This conflicts with the async buffered read support in linux-next that
has been queued up for a long time.

> @@ -315,6 +318,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_ZONE_APPEND	(1 << 8)

Ditto this one, and that also clashes with mainline. The next available
bit would be 10, IOCB_WAITQ and IOCB_NOIO are 8 and 9.


-- 
Jens Axboe

