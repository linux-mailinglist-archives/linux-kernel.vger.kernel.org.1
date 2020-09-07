Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065025FFEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgIGQlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbgIGQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:41:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A7C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:41:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so2722245plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QI9owJq1qeNIbL5MGRj7H9ZbeWy3uMtOambIfQ05240=;
        b=t0md+sgRR59HAfNxNXQLb4d8jUGYK95h+b8RqrM3hkSN7fTSAyBDOpGa1vmbd0iKfM
         T4gFOAu/DuXESBPEiXk4p1IslX8AN2ySHrVut9XG7e359FtcveW84NdBYkOv8cBnhqWX
         n6Fh/5lJE65g9dwmUzzdWUbU+59YufFdlSEUVS7Tew1s0zHxsfCsBiI9MSMPC7/IJ3E8
         GDjEuqXJkX7zf3XqnaEhB/yZTMOl9b7L1RFN8r5H+dNs+Fz2Vx5pEKEvt8e/8Ll1vEeX
         lRsgbhP9G8BlrrHwMRX2UzjBty/etaulP1dKLCDBZwbKWKR0qtD4UsduAdYW7+YKW60M
         eVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QI9owJq1qeNIbL5MGRj7H9ZbeWy3uMtOambIfQ05240=;
        b=HuWAPGdduCQXF7aanGvdqN0XMY+UMMyC2bMR8jDVTt7UUDGltPO6muf/NEKTkqcjpx
         OHIWX3X/fzbgClWksGNy15wyClwCvHBxmpu9w/gJG+/QI0CjfcJI9/d+JBWxtZfY2B0y
         Vnv2LDYHEDOtCJ7PRSTY/jfGZBw9ZMqC48vbjzZRBngQK6pU98//BtLbZkXdNY16Lf3C
         iWXdxtfFM2/VcDyTAoWBpJMu+yCA5i4Xqr2k26Uz5ij5j2s1xh/gYmsqb3k+v7CAHscD
         vFtwlSPV7qoMLEx5KUuAa/kBFLKXC6hzpvVdiheGKfQJFwvopoIWvEj/Bkazq74DdsNa
         XAtA==
X-Gm-Message-State: AOAM532ehlp7Q49dQwMBqLq9oZ6gYq65xG1YhQl9+rAHTrGfxoQye9mz
        Ev4LLG2zfbfSiliA6HejvI8vyQ==
X-Google-Smtp-Source: ABdhPJxjMIPuK22ccwbpfS5Lc4urY7i8nlaAUy+/DPrUiHo0eKcYTMJtQ9YP2xudp317L+vQNfW2pA==
X-Received: by 2002:a17:90b:117:: with SMTP id p23mr149298pjz.67.1599496877962;
        Mon, 07 Sep 2020 09:41:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 142sm12521645pgf.68.2020.09.07.09.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:41:17 -0700 (PDT)
Subject: Re: [PATCH] kyber: Fix crash in kyber_finish_request()
To:     Yang Yang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com, Omar Sandoval <osandov@osandov.com>
References: <20200907074346.5383-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
Date:   Mon, 7 Sep 2020 10:41:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907074346.5383-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Omar

On 9/7/20 1:43 AM, Yang Yang wrote:
> Kernel crash when requeue flush request.
> It can be reproduced as below:
> 
> [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
> ...
> [    2.517468] pc : clear_bit+0x18/0x2c
> [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
> [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
> ...
> [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
> [    2.517602] Call trace:
> [    2.517606]  clear_bit+0x18/0x2c
> [    2.517619]  kyber_finish_request+0x74/0x80
> [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
> [    2.517637]  __scsi_queue_insert+0x11c/0x148
> [    2.517640]  scsi_softirq_done+0x114/0x130
> [    2.517643]  blk_done_softirq+0x7c/0xb0
> [    2.517651]  __do_softirq+0x208/0x3bc
> [    2.517657]  run_ksoftirqd+0x34/0x60
> [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
> [    2.517667]  kthread+0x110/0x120
> [    2.517669]  ret_from_fork+0x10/0x18
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  block/kyber-iosched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index a38c5ab103d1..af73afe7a05c 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -611,6 +611,9 @@ static void kyber_finish_request(struct request *rq)
>  {
>  	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
>  
> +	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
> +		return;
> +
>  	rq_clear_domain_token(kqd, rq);
>  }
>  
> 


-- 
Jens Axboe

