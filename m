Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7652DC248
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgLPOdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgLPOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:33:36 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E822DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:32:55 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z11so22630054qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SccFDNBIkslfgiob32PkKVek28skifxxI2wxs+TjvJg=;
        b=sF01LXuNIGaD7nij1Lh4lzd5CDc7S5YQk1iL/Uwn/IMskkD1ZsofgG23b7Fc76baax
         565GYyG3Kt2PEtWAQ9mo+kXAh7MGkxEReYUa+1ETLwqX1CLP2qnI/40+I7MvEicNfiNs
         Eu0UaWzjPeWvk89mMpBjuvTikdsF6bOW1oRt3S2JM7suEKGgcc7x/RLNmSfvsWIjeWt6
         ew5iJbNuEc6hOY7JD7+efi9y0KJ+qId/BRyEVMZDPqBcacUDLnL2XanmfauzlI5+WEVU
         qnn+mq+BNzScOR4zRiFhd/M0tkuj7VITuxa1aHQCM+WBpqEvaGEpdbuEh/8naHE2js+L
         /rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SccFDNBIkslfgiob32PkKVek28skifxxI2wxs+TjvJg=;
        b=rxQkIsb2Aq8ECjB257nZ+SkTLrwlV5wr+md6ur9+WwHV9Dktgrbm5wDff2buXwzkIy
         FSOsPKMSu7KxRvx2qoYNa2KrLKtg9MGLWeAYOVK6KOOH30s6Nfbd5aUKQBy/bUduJa2x
         5yI+xU4Lh6euNPXcXw1rl0hBkr3JVF78v+j6wa0pW5XIGUjWnhBsv2yjImMnMhSSNZ3k
         rf7VZ7/Vkf0qZzA2OSe3Grj3JBmhggUBOJvqoApeY2XYY/LkvjzAiL2yjvuLKNBIRzIQ
         /S4Tr4NoO3d7p76tNsuxmxlGJ4i9PDEvjJP3Cu/ScZFa7X8C5j1VrdElANVkUdPH0APd
         jLkA==
X-Gm-Message-State: AOAM531/8YBQRRr//ZrA7kH0MyX7Ihq79j2V0HpH3lPwBqiNMfxHuzmp
        RKGj2jxGhIcFu71G/61T2oufvdVMnPWhhg==
X-Google-Smtp-Source: ABdhPJymMyNu6EvzltRUHf7pjiZxIeafFZCas7sdOfWSKhvHeCHAM5hNcomaR+UJ368ILGMJKlI3pA==
X-Received: by 2002:a37:a713:: with SMTP id q19mr42120373qke.23.1608129175091;
        Wed, 16 Dec 2020 06:32:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cbde])
        by smtp.gmail.com with ESMTPSA id a5sm1083363qtn.57.2020.12.16.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:32:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Dec 2020 09:32:21 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 02/10] workqueue: use cpu_possible_mask instead of
 cpu_active_mask to break affinity
Message-ID: <X9oadQJYQH8ss00Z@mtj.duckdns.org>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <20201214155457.3430-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214155457.3430-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 14, 2020 at 11:54:49PM +0800, Lai Jiangshan wrote:
> @@ -4909,8 +4909,9 @@ static void unbind_workers(int cpu)
>  
>  		raw_spin_unlock_irq(&pool->lock);
>  
> +		/* don't rely on the scheduler to force break affinity for us. */

I'm not sure this comment is helpful. The comment may make sense right now
while the scheduler behavior is changing but down the line it's not gonna
make whole lot of sense.

>  		for_each_pool_worker(worker, pool)
> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>  
>  		mutex_unlock(&wq_pool_attach_mutex);

Thanks.

-- 
tejun
