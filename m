Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73B21A186
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGIN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGIN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:58:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21EC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:58:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e64so2359529iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1J6vHRKQNut7E/ykKpZDEQEYTSIWHWf2BiyemlGh+0=;
        b=cEsrczv/wMmZdKUu1QVtCZtuKtgrPWO86Etf19dvSEzgyJujKDalDgMnt7XnCfwAfH
         TKLF9QfYqstM1U3BQHxjKHyavzHGdQvsnFaYDfLmcGd0rmWmWscTtrhHJxwBLksLtHq8
         E4n6fZdF7VqGKy3Vz+UncPL0dmZtLUTCmlXxyuzLEcxVkrnKLZ8Izg+wadh4WPvHWaDT
         m5nxfUhqrAnAh+MAxEfiLO6M+vfH4IgENELQ+DPQUw8g2JsPdNv6/wJOMsctqFnnsTX9
         K4uqUzht1jivlSFEhs2Msd92F5vJBburQCgTq2XiWsQferxTvKLbzZzEAKbNbjhV7S1G
         eHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1J6vHRKQNut7E/ykKpZDEQEYTSIWHWf2BiyemlGh+0=;
        b=TYutmsCjx1Zoumakk1fRB5i5ul67HAsVedj2qpdkmFQ6UypqwVWHiobNW1WFNUVIZ1
         1HoBFL3IXwN9cRm1LDFZjWWu7fPbBhiByq3xsLHbfCE5M0WrTeUF5JF7qYSB0RWDtKnX
         qpWywKcb+dXfNsi93i19obUmqB/DziTQrbeQ0Q/ZhJ7zpKZSe9u9QMR1t2phGYx8duGN
         xkPcPx1dL/XyLqL0K77Qv7ZIODk9/kv9+rF6OsIB3LHX8pztABsdwO1WpH8FsjliXbs+
         wP0h1ezExUMHDiDTHOwiRrtvMZmaH1wZ4vyixDh5ww7LjIPxALfGCOz5TZSs74Yd22Kk
         QYKA==
X-Gm-Message-State: AOAM5325qbBNnkoUu1kwAWUe8b+SUKKQqxN5motf9jp3e+nB4oUlbhDv
        LX7OgkzA/+S4kVbUB+9JlhlaOw==
X-Google-Smtp-Source: ABdhPJzxSF/xDWCEbyyN69qZnnq2x64VZr67MJX+V63IE3WqiyXyP3TjTXLwVC6fKu9skJUx9zE/qQ==
X-Received: by 2002:a05:6638:118:: with SMTP id x24mr74022628jao.48.1594303086919;
        Thu, 09 Jul 2020 06:58:06 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z78sm2045041ilk.72.2020.07.09.06.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:58:06 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] io_uring: add support for zone-append
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, Damien.LeMoal@wdc.com, asml.silence@gmail.com,
        linux-fsdevel@vger.kernel.org, mb@lightnvm.io,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <1593974870-18919-1-git-send-email-joshi.k@samsung.com>
 <CGME20200705185227epcas5p16fba3cb92561794b960184c89fdf2bb7@epcas5p1.samsung.com>
 <1593974870-18919-5-git-send-email-joshi.k@samsung.com>
 <fe0066b7-5380-43ee-20b2-c9b17ba18e4f@kernel.dk>
 <20200709085501.GA64935@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <adc14700-8e95-10b2-d914-afa5029ae80c@kernel.dk>
Date:   Thu, 9 Jul 2020 07:58:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709085501.GA64935@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 4:15 AM, Christoph Hellwig wrote:
> On Sun, Jul 05, 2020 at 03:00:47PM -0600, Jens Axboe wrote:
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 155f3d8..cbde4df 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -402,6 +402,8 @@ struct io_rw {
>>>  	struct kiocb			kiocb;
>>>  	u64				addr;
>>>  	u64				len;
>>> +	/* zone-relative offset for append, in sectors */
>>> +	u32			append_offset;
>>>  };
>>
>> I don't like this very much at all. As it stands, the first cacheline
>> of io_kiocb is set aside for request-private data. io_rw is already
>> exactly 64 bytes, which means that you're now growing io_rw beyond
>> a cacheline and increasing the size of io_kiocb as a whole.
>>
>> Maybe you can reuse io_rw->len for this, as that is only used on the
>> submission side of things.
> 
> We don't actually need any new field at all.  By the time the write
> returned ki_pos contains the offset after the write, and the res
> argument to ->ki_complete contains the amount of bytes written, which
> allow us to trivially derive the starting position.

Then let's just do that instead of jumping through hoops either
justifying growing io_rw/io_kiocb or turning kiocb into a global
completion thing.

-- 
Jens Axboe

