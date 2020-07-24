Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE322CB10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgGXQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGXQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:29:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77FCC0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:29:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so5510421pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5vpCWHYjYJzXRlUWgDCLhZpTQz6UHH/5YbUsvqWdNg=;
        b=AiM7BvGhGZq+8CYp8kZrjTGkqBuGSOVx6gcS2ZoV6niiBFHjxOg990QxEbHLjMtigv
         rkvJauw/Nl3yhgdh3yh3/cQAnPJiwRmEprDaz+FVWchlY0XqPjysldBf7LV7iodBdHsg
         899CD4i/WKRLcxWHL2qBJPQckfv3u7k8PdGNBc5u9vYaxF2nX4a0GJZ0t2UsIEZTpo6J
         LSaij/Yuh1Dejhu73ovuUR07/jtKpWqsPIuesjS1PnD7zc9xpDNs1ajo4VYGKaFSYPEp
         4k9hgoXmZx02QlUnefhSTGyaDFr/jP9Yjztbzg3eY6wwKKTEEk/uuvzIim3EIQCSWKme
         optQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5vpCWHYjYJzXRlUWgDCLhZpTQz6UHH/5YbUsvqWdNg=;
        b=KyyqFejCso5/eWgY3M2fTIpMEG/RitgCXxgmyYz5QKWK0Yiuybc/5YX1SfRuNXBUoh
         eF3rWxCyh+5Jhp/9bkfTPke/s3XwWonfob8Ndb+CM8ifrFMauew5v+xIo2EsJiurJjVa
         JvMj7A+WV723YXeeVfdgKd0qiFbqF5SuWOuv1Yv/R7wLAgKT6mfH0uxQcDo+Tmnk5741
         cZ+cYbvsJfqn0a0+TCYYEkFfNi1546GgO27M2NdB9v+c1pt8MB0a/QFnKfnwUOQV+B7P
         4YnALQisduw71WgvKmD/zpmmj5wuNWIuEEJKEJWDiXqrJmehhIYBXX0EVIkI3pljQc9C
         VZCA==
X-Gm-Message-State: AOAM531BaBhYUOEqTUZmPtZQWDxOh+QeMH4aTsmLJY5jjFqyUGq0Amrd
        yxhwgkf8dNivblKmE8+IoBMocA==
X-Google-Smtp-Source: ABdhPJwiUQeYSR905NX4BkAH3K9ZeZTdo2ytHvuhOnPUvAeq9vMBPv48vFJy3B/CVUpeaPlmxlgHwA==
X-Received: by 2002:a63:338c:: with SMTP id z134mr9031841pgz.245.1595608162016;
        Fri, 24 Jul 2020 09:29:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e15sm6659144pgt.17.2020.07.24.09.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 09:29:21 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] io_uring: add support for zone-append
To:     Kanchan Joshi <joshi.k@samsung.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org
Cc:     willy@infradead.org, hch@infradead.org, Damien.LeMoal@wdc.com,
        asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, SelvaKumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <1595605762-17010-1-git-send-email-joshi.k@samsung.com>
 <CGME20200724155350epcas5p3b8f1d59eda7f8fbb38c828f692d42fd6@epcas5p3.samsung.com>
 <1595605762-17010-7-git-send-email-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5416bd4-93b3-4d14-3266-bdbc4ae1990b@kernel.dk>
Date:   Fri, 24 Jul 2020 10:29:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595605762-17010-7-git-send-email-joshi.k@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 9:49 AM, Kanchan Joshi wrote:
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 7809ab2..6510cf5 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1284,8 +1301,15 @@ static void __io_cqring_fill_event(struct io_kiocb *req, long res, long cflags)
>  	cqe = io_get_cqring(ctx);
>  	if (likely(cqe)) {
>  		WRITE_ONCE(cqe->user_data, req->user_data);
> -		WRITE_ONCE(cqe->res, res);
> -		WRITE_ONCE(cqe->flags, cflags);
> +		if (unlikely(req->flags & REQ_F_ZONE_APPEND)) {
> +			if (likely(res > 0))
> +				WRITE_ONCE(cqe->res64, req->rw.append_offset);
> +			else
> +				WRITE_ONCE(cqe->res64, res);
> +		} else {
> +			WRITE_ONCE(cqe->res, res);
> +			WRITE_ONCE(cqe->flags, cflags);
> +		}

This would be nice to keep out of the fast path, if possible.

> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 92c2269..2580d93 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -156,8 +156,13 @@ enum {
>   */
>  struct io_uring_cqe {
>  	__u64	user_data;	/* sqe->data submission passed back */
> -	__s32	res;		/* result code for this event */
> -	__u32	flags;
> +	union {
> +		struct {
> +			__s32	res;	/* result code for this event */
> +			__u32	flags;
> +		};
> +		__s64	res64;	/* appending offset for zone append */
> +	};
>  };

Is this a compatible change, both for now but also going forward? You
could randomly have IORING_CQE_F_BUFFER set, or any other future flags.
Layout would also be different between big and little endian, so not
even that easy to set aside a flag for this. But even if that was done,
we'd still have this weird API where liburing or the app would need to
distinguish this cqe from all others based on... the user_data? Hence
liburing can't do it, only the app would be able to.

Just seems like a hack to me.

-- 
Jens Axboe

