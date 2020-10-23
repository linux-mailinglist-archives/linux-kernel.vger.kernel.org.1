Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA88297058
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464590AbgJWNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373633AbgJWNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:23:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785FC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:23:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k6so1753226ior.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iIXXMTAFKEUOXUJ6Hngll7ihraOgdUZlAqeHFDgyY7I=;
        b=e7HMtDUxozZVnJQN4nwx6gLgKj9Jh+YYtcUP0Pwy2VfGhM4YnjwyEnS1PB21YHuawu
         fxCMdVoVaM/YqMIwFCLig2gaY+Pq2qeANvbTD6ywLw+6FPpma09F5IIx3ZU0o6dKHO5L
         5S90l/cQd207SDdENPR1e05TtRYG0CCtx9Pz5aDD8/nVyOcn99UvLbfr/58K7fOPyLOP
         9FnVdvagyDojndRSERh4xujbIa4TAvdYt0Z8dXCqyQ2Ylvk+mJ5anzdGES5/b8r10xX6
         ZFX5kfiaxGLUpdQRNX+pMmyUWE286ClMagOhHW6l3bvanVRvZRS/7yfQSpjaaZhzdxjf
         m3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iIXXMTAFKEUOXUJ6Hngll7ihraOgdUZlAqeHFDgyY7I=;
        b=W+LXTWIBGfykeMPg4oqsfGEgjDsULDi3wObMKMcFECg9NtjmCiiz7Q2ruePi5M7YrR
         LImiRjlPmfvs4Oyq8LflHO7J7xYApiDRfeZO0uQyYDIOZkYN5X27+V3+wgFPYtSGe9lG
         0mZ4PrB+ic5J6r5/G+CsmSQM3vaMMLAdJKrEFYHFkomu/gD6L2ZcgKiWU29zJBb/lGcC
         Ho1zqD2SAoleTnc/6VEViGLQxHY0LFWHX/SDuedlz4L7+4jM+f6nVOkZKTE3LQwChm7H
         +fywS/2MWynH1ve/VNAZKcpx2NtMTrAYaE1kKo7N59pEcwDJHVbAa62RkOTqFFJ8FeBl
         7qMA==
X-Gm-Message-State: AOAM531Lo7Rqs9imctHTPyMnL3PdkPdmzDzn7EOTc/ULEmYhbxU5vTwY
        +A+01lhtS4m+fuqVExoTlSSfQaNEJG1FaA==
X-Google-Smtp-Source: ABdhPJy9ZE3R9jmYdEpwid3c9GavbQ0/arGXkTiSPg8hHX1/yxqhlduNTA/d6K6ddXpkttLEEGEtTw==
X-Received: by 2002:a05:6602:1216:: with SMTP id y22mr1572155iot.53.1603459398359;
        Fri, 23 Oct 2020 06:23:18 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c1sm940393ile.0.2020.10.23.06.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 06:23:17 -0700 (PDT)
Subject: Re: [PATCH] io-wq: fix 'task->pi_lock' spin lock protect
To:     qiang.zhang@windriver.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201023062003.3353-1-qiang.zhang@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80fa2e28-bbb4-dfa7-7215-c8cea052dca0@kernel.dk>
Date:   Fri, 23 Oct 2020 07:23:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023062003.3353-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/20 12:20 AM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> The set CPU affinity func 'do_set_cpus_allowed' may be operate
> 'task_rq', need add rq lock protect, replace 'pi_lock' spinlock
> protect with task_rq_lock func.

Thanks, I'm going to fold this one.

-- 
Jens Axboe

