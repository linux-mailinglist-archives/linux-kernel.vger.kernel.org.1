Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076FF2DDA42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgLQUmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgLQUmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:42:52 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FCCC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:42:12 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x15so174410ilq.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LvhMc5ZjtLwbA9X7poTR4ZwUeBf8/KaB1u2Nd9aCJNU=;
        b=0q3RLct3Y9xBJWrxIVx8Iw80mSKSvetFJ2YiBfQC6Q2Y26VvWz2wCJSrjGFpUk8Zjk
         s/tOwjFnT4eizJM/0RcYXw4yF0J1+DOZbCfc1VDqyQ+5Hvrs1aJMWZXcw6sAMDBPo1QA
         iMuK5QQmjhcOENKCU3SVUTfWvR/gznYQ4XsxfU64zcJJsO8iL2iFmIEQ5drosm3bPeI+
         n6m5xjTKGiaoVAZo94qBlyOSxTEWyZ80oD9V+/VYZse/pTUL1d8N69y/nCNrTRkZYacK
         8fgUugcqiA893qlmmVM40GmYAo5MXb6GtE9ZkKuA36PVX+L0DFF7m+8AUf0b7o2bvEuD
         IhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LvhMc5ZjtLwbA9X7poTR4ZwUeBf8/KaB1u2Nd9aCJNU=;
        b=W5vQGSmiuUvlTfuRGIhOYsKl6LwxJwXPWJ3gAbmxxlYfhjvuLX2I7NPeQOnn6c4NXo
         3F8BxSf11vIJ3PT1kF8wGRhrMdR3/qNcShm83xu96u//YWYWzOwRRMA3tFq1dZhRHV4l
         rMzxgqCXp2nIl9VtCGiOozStXLJXIjCzL+3uxptZpQpEv7MEfTW6au/6c4+0L8O4xB0j
         g+sUieXcQu/r8t/WByqgznfGT4AC/hmoj/rtQw4b8RLdTzMYIVRQPoRAINdyn9SdNSmB
         8UioKp2cnhzMi2hEKx3Wqts6SoHCzYK7rnHUj62oOz9rEIQqkcR/x2E2Ou0XM+dHhmMI
         1yGg==
X-Gm-Message-State: AOAM533CuiQl37y/tYdzaM5VefuCSfdarAUPBnfJ+13dqWZ2W3km1lUf
        8ZMBdDo+oz137HrwNyahQ210xT906tIiRQ==
X-Google-Smtp-Source: ABdhPJyfJApG9ACrgd0cFsBaVAdD2Zeg+uZmgMA2e5Bft9xlFUzzyxe7Cp9CUGayPdzJqzMVZFLETA==
X-Received: by 2002:a05:6e02:1525:: with SMTP id i5mr745091ilu.14.1608237731874;
        Thu, 17 Dec 2020 12:42:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k23sm4293713ilg.57.2020.12.17.12.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:42:11 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>
References: <20201218073806.06395319@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23286bf8-6eaf-8601-7d2a-5c7a8c11460f@kernel.dk>
Date:   Thu, 17 Dec 2020 13:42:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218073806.06395319@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 1:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   358e7cbf87b4 ("s390/dasd: fix hanging device offline processing")
> 
> Fixes tag
> 
>   Fixes: 47825e05d93e ("s390/dasd: fix endless loop after read unit address configuration")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 41995342b40c ("s390/dasd: fix endless loop after read unit address configuration")

Thanks, I fixed it up.

-- 
Jens Axboe

