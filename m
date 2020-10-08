Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3B287594
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgJHOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJHOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:02:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD7C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:02:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l8so6209085ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+v0FBMBQHdikeISvOs9/H6RdJVjsvgJipGvlxdEATrw=;
        b=OtjKLWoNFnJwBG+iIBsnfGAFJ4zdt7leYN6+IZMnSqbHnvoXh5fOLZV1t5S4zHKUK+
         KlLNhwQDcsdOJ+V6LCgAsTRNBvCb+hz8mhghFlo0yiw4O2KRm4ZtDM9yfQnRV0uSBSer
         C9/7OPQObbekrl9Gh4aVoZUyL5YHShCtmwpHSrZO3WnByHNC2KioGmRAmwwGQnvmB2VT
         zZjChPKRCnH8sXBxdxwX+sVzpfg5961ZI6KZIqRSaKXhs2v0NxRWX9XSl4VdF3M1eOP6
         09lAFvYNw26lHxgYb/xSqunH/NmCfM9e73cUCb7zv4dadb8bBohqNr3EeFusZoM46jjQ
         DEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+v0FBMBQHdikeISvOs9/H6RdJVjsvgJipGvlxdEATrw=;
        b=msAS4aJS+PO8M7JqjiwHfCwsJULfKpp5opDh0rrGISDS1FwGFSjyhxSq4mKW+2z5I4
         Ud1m0mdOgfozTOyQvHWJGb0PUJeXv2ScqX/0SwuJZc2MZQ+tystsxT2u3oS0uf0Z+U4t
         pJSmXkHVUy8QXU7sZkZoCByTlnZpzzqYtFK14cCAUkWziGOPrfJrxbrrARqzl9wgzxCD
         X3wYTtVGEF/wVzFCThwLxrfSRwA5K5NjsQ81WkyciexFFOE1szSNEmkxOoHWtaMvV5lE
         bNTTdfzAVEwAIcxI40JOwjUssAQwWT7iMirGMmRC7dAwAfRN7/wRE1WxhCw4raoDypKY
         b+lg==
X-Gm-Message-State: AOAM530ghNuM+m+uoQW88VtN62sVLja2CjNkWE4oKhVGMBo2B/BXNjiG
        ZCKozRdPEhIZp2vzByXcw05uMrK7HNV0dg==
X-Google-Smtp-Source: ABdhPJy/LL8lIwlhJyCrinad2Oa+KhO+WtX+sKYdSYwFbXtVAptuvPI1GFZpqt98YjTtzz2k0dg+Lg==
X-Received: by 2002:a02:82c8:: with SMTP id u8mr6948237jag.61.1602165727444;
        Thu, 08 Oct 2020 07:02:07 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l4sm2695327ilk.14.2020.10.08.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:02:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] Some improvements for blk throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b54c6741-10dc-2768-bc37-f1965672f039@kernel.dk>
Date:   Thu, 8 Oct 2020 08:02:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 9:52 PM, Baolin Wang wrote:
> Hi,
> 
> This patch set did some improvements for blk throttle, please
> help to review. Thanks.
> 
> Changes from v1:
>  - Add another 4 new patches in this patch set.
> 
> Baolin Wang (8):
>   blk-throttle: Remove a meaningless parameter for
>     throtl_downgrade_state()
>   blk-throttle: Avoid getting the current time if tg->last_finish_time
>     is 0
>   blk-throttle: Avoid tracking latency if low limit is invalid
>   blk-throttle: Fix IO hang for a corner case
>   blk-throttle: Move the list operation after list validation
>   blk-throttle: Move service tree validation out of the
>     throtl_rb_first()
>   blk-throttle: Open code __throtl_de/enqueue_tg()
>   blk-throttle: Re-use the throtl_set_slice_end()
> 
>  block/blk-throttle.c | 69 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 34 deletions(-)

LGTM, applied, thanks.

-- 
Jens Axboe

