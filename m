Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B32B2724
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKMVgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKMVgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:36:52 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66666C08C5F2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:26:53 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h16so4055148pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7J5Rp08GL5X3H15jor7CE7t4jnfk1M9RUzFFtD2jiKs=;
        b=Xce78mtOzxG3MZwuIJ6qhBt9FLVIM6ylEG2N7m9qPfAKeCBzNXnKXpIoT7S1oqAebk
         DPc5vJTliZWgA1EnHQA+6VAoEKQN/NITCCn0yOx30u7w1/xl99+Clk/8pZnXBLBcqP4E
         47uqMIb1Av42Km/ps04jAlp1BSHPz8mOl++EklM0DZKonYVsT0Eay+eRAM5QE5u5ll2W
         5HlsDWzXXdsN88Z59eLHWxkHZrNT4urZnIXC/4BoRNFDKA/30Sh+xw5FgzPIuD3lULJK
         piJ/IsnPtsMeFjBPoggYPMc9bkvL7GyZroxnzvz61jvC198xGTGQ+u5s1Fexm6dmRbGZ
         GjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7J5Rp08GL5X3H15jor7CE7t4jnfk1M9RUzFFtD2jiKs=;
        b=USZi8EbWdy0iF9/dhjKXvi+1V4Pl8jaWqjIMTB5nQt1MRVGLGEgc+FBeZfLsU2bdn1
         G04Lyxw2IESzlJq7wLtB4vrkiGw2CmI2Tpsml1tCAE3bnoYgzWc5Y0e0v/2YPwAngeNa
         dcRHvvuDkhxgCyIS0Tgr2RIiPaAgbO4vCjUa5zCv4TfQbuTg8BVXw1K3TS6v2g2JRdin
         VGMJeyKZMxEHb0PJYtDUu5UdQSbtDo6ouComt0aWSwgTkqdrF9AOMDZpl89jPVE9sibG
         ocg7ueiHs9ERC6pvAsHFL4+sEegfyUkRrcg6jiPpIRjxBmh+qYlhG3c7qF1j+bAuVaxS
         Y7NA==
X-Gm-Message-State: AOAM533+nc6EqY8ripxJHQ6WO2qWhl0Jd77nukCEh61JLcYQEU2v1In2
        oKa5FDSg4DdbHSHAzh2JO7U93w==
X-Google-Smtp-Source: ABdhPJwYKJWZ1egWWe92pGhU7NVyiLO88PgU+olcTBqFCmhwVwr0VM5zW/hb5u94Ganu/x4rHmyO5A==
X-Received: by 2002:a17:90b:4683:: with SMTP id ir3mr5040531pjb.212.1605302812924;
        Fri, 13 Nov 2020 13:26:52 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e22sm11517673pjh.45.2020.11.13.13.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:26:52 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Sagi Grimberg <sagi@grimberg.me>,
        Rachit Agarwal <rach4x0r@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
Date:   Fri, 13 Nov 2020 14:26:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 2:23 PM, Sagi Grimberg wrote:
> 
>>>> I haven't taken a close look at the code yet so far, but one quick note
>>>> that patches like this should be against the branches for 5.11. In fact,
>>>> this one doesn't even compile against current -git, as
>>>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
>>>
>>> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
>>> before submitting.. Sorry about that.
>>>
>>>> In any case, I did run this through some quick peak testing as I was
>>>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>>>> this. Perf diff:
>>>>
>>>>       10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>>>        2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
>>>
>>> You ran this with nvme? or null_blk? I guess neither would benefit
>>> from this because if the underlying device will not benefit from
>>> batching (at least enough for the extra cost of accounting for it) it
>>> will be counter productive to use this scheduler.
>>
>> This is nvme, actual device. The initial posting could be a bit more
>> explicit on the use case, it says:
>>
>> "For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
>> terms of IOPS per core over "noop" I/O scheduler."
>>
>> which made me very skeptical, as it sounds like it's raw device claims.
> 
> You are absolutely right, that needs to be fixed.
> 
>> Does beg the question of why this is a new scheduler then. It's pretty
>> basic stuff, something that could trivially just be added a side effect
>> of the core (and in fact we have much of it already). Doesn't really seem
>> to warrant a new scheduler at all. There isn't really much in there.
> 
> Not saying it absolutely warrants a new one, and it could I guess sit in
> the core, but this attempts to optimize for a specific metric while
> trading-off others, which is exactly what I/O schedulers are for,
> optimizing for a specific metric.
> 
> Not sure we want to build something biases towards throughput on the
> expense of latency into the block core. And, as mentioned this is not
> well suited to all device types...
> 
> But if you think this has a better home, I'm assuming that the guys
> will be open to that.

Also see the reply from Ming. It's a balancing act - don't want to add
extra overhead to the core, but also don't want to carry an extra
scheduler if the main change is really just variable dispatch batching.
And since we already have a notion of that, seems worthwhile to explore
that venue.

-- 
Jens Axboe

