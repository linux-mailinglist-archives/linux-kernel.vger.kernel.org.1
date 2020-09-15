Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F29269B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIOBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgIOBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:37:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C14C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:37:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so1019885pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veTRf67heiIFBb4KPb8qCnP0OdQI7n5gixhte0BRym0=;
        b=nuIk1sCKUYraP3k57rU4ShNSYsyPO6TSIfbhfJGQr6XoUbfSbodkxRYwXNVW/EEBnx
         S4g4Plpz8OrOv+wOakdj/YTlGdE7xpbSoZTCgFA6cKkcQ999EbkYaI90Y/2dWERkkNZ/
         z3uPvic5mPlvmNiDl4C1QEcmUXvaJdlRCS9gFz+05Q3KennGshV4VpIpviIZsmb/AVOc
         zVzlJ+dFJ+ZST8txLF+bWxw/p4eKBSvfLb5JsmcPncRwA1w43w2seg2dbik9+EhH5cCR
         TQA/WLjUvkqQRATpdsgf4rCmTr8tRoXZEu/XvpfvhuSclBmVwXpwe2nDqKzztpaj2/1u
         Blxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veTRf67heiIFBb4KPb8qCnP0OdQI7n5gixhte0BRym0=;
        b=MW4O+fBLQXpte+RadT1ludCwBK3ybR9vyNYtLCo5HZDzZ8JbfWh6BqEhcuS9lXy4bO
         advThip63qtrLkes/11+LQlxnbKWhqMaj9c+j0fyHIcU0KpV0XAl84Sx9f/t1tMVLSfv
         qB1is8MZw5q3fBKNd1EMVIaDO8Cf4vKT1QM6o8ArpMi9vDfkdFH4t2JKfcdTOW5RkZNF
         VLB/+fR5OKFnt2t/iFGkDNyCbzq7gmyix2I34h1ievDR2TGUtzSaQDVeWv02hP9Oeb4K
         nyJuioQSxX0iqTdR7sHd2fo7EuFMFEY3XDVBRNihjJpb7uq15hHtNn3xq3nc0qmwAvum
         t2GA==
X-Gm-Message-State: AOAM532PImfhHnY9L6ah8wNNoitEd2khElNCvnLTUipiC0ATt3mAOs7L
        7WdvLyR+0deheuOzc/G9Dmwvd1pH4pUV3zHy
X-Google-Smtp-Source: ABdhPJzgHqFLzOqTAgfUjDKvOe1d+ajMiyzwv68TI2k4WqC3aQxq3mx3jZ/CepIWy4+hbH0Ix8oyHw==
X-Received: by 2002:a62:2c8:0:b029:13e:9ee9:5b25 with SMTP id 191-20020a6202c80000b029013e9ee95b25mr16061298pfc.1.1600133875800;
        Mon, 14 Sep 2020 18:37:55 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i16sm13205719pjv.0.2020.09.14.18.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:37:55 -0700 (PDT)
Subject: Re: [PATCH 0/5] Some improvements for blk-throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <822998a7-4cc7-88ee-8b3f-e8e7660a5b0a@kernel.dk>
Date:   Mon, 14 Sep 2020 19:37:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 2:10 AM, Baolin Wang wrote:
> Hi All,
> 
> This patch set did some clean-ups, as well as removing some unnecessary
> bps/iops limitation calculation when checking if can dispatch a bio or
> not for a tg. Please help to review. Thanks.
> 
> Baolin Wang (5):
>   blk-throttle: Fix some comments' typos
>   blk-throttle: Use readable READ/WRITE macros
>   blk-throttle: Define readable macros instead of static variables
>   blk-throttle: Avoid calculating bps/iops limitation repeatedly
>   blk-throttle: Avoid checking bps/iops limitation if bps or iops is    
>     unlimited
> 
>  block/blk-throttle.c | 59 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 23 deletions(-)

Looks reasonable to me, I've applied it.

Out of curiosity, are you using blk-throttle in production, or are these
just fixes/cleanups that you came across?


-- 
Jens Axboe

