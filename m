Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA462B262A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgKMVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:03:11 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFCAC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:03:09 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id h6so8088220pgk.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zoui9BUZXUZOqrTWaBrZykGcY0FRSZnrRzqMJQ8RwA=;
        b=SIqtSJpDMUZf6A0Bp680OWghtTzBxCyFEittkvDw3lqzYn2Ps6IVbUdF4Bf3m1dHhb
         /AsZrlSawXqvZfYZLk1N+1S43FCJPaOfMoqY9qoujbZiA6QWbaEsBAV+otmmbcKGB8uI
         s3C2sYFRUEPz+dC1Kq9kik/qnrNy+NNJPscbllkTJ7YtOLUIz5k0eVizc3mfmSP+sLta
         xJd2RATiOoXhTf+2TvePEngYQ7CNZ7PsTd4FUrL8YoF6TkAMthadpjk6+HVaLmvhsqEJ
         FaPHfuDCO6cHzEUungyCmh3arO6bio30A9vmD/A9kTmX0KS/1Up9Zc2wqdsHsoFMlPk3
         NeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zoui9BUZXUZOqrTWaBrZykGcY0FRSZnrRzqMJQ8RwA=;
        b=YQmG2/1OK26MufGXVH3u8fhTFb+RAFVoXr/His9JUcMZcdkjPZ+pFIhnHDXvWpwyb6
         cg+UzMjEVt7aALAXadqQTuh2u/RvyBORSLEylTsjQo6JXSseFfUiWHCzp02F9bChFPne
         JKcUTNRx3ewqULxQ0wFtqmr1I+39z3/nIYjiZgwq8gm5x97W923Fyqfv3HbB8FLVe3ZS
         yKa0A0Vi5BVOxNNUSItgitlykZaoq8P/jtoZAnX3FewCMG8dnJHRO63A9AVcWtTE05Uu
         zI6+ai1nVK/8/byXRycH4GVaClvQRHWz54WZeuvHEyCHHlyj03lC1mLBzdEp57eikDwe
         3rzA==
X-Gm-Message-State: AOAM530tR0QdF6Yr2IdVsM3x5W+GhLu543R0icMU4pr9qKRQVRlP6LYw
        hxSDlautFzYA/OTRl0dh0E+kmw==
X-Google-Smtp-Source: ABdhPJy9RxMN3SjWuODbONNveEfQJhguQEGd2j8B+Qx6ue32McdtKQK4nHihEq6cvGxKB+/5V9axzg==
X-Received: by 2002:a63:161a:: with SMTP id w26mr3316313pgl.17.1605301388725;
        Fri, 13 Nov 2020 13:03:08 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d2sm11265021pjj.37.2020.11.13.13.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:03:08 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
Date:   Fri, 13 Nov 2020 14:03:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 1:34 PM, Sagi Grimberg wrote:
> 
>> I haven't taken a close look at the code yet so far, but one quick note
>> that patches like this should be against the branches for 5.11. In fact,
>> this one doesn't even compile against current -git, as
>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
> 
> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
> before submitting.. Sorry about that.
> 
>> In any case, I did run this through some quick peak testing as I was
>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>> this. Perf diff:
>>
>>      10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>       2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
> 
> You ran this with nvme? or null_blk? I guess neither would benefit
> from this because if the underlying device will not benefit from
> batching (at least enough for the extra cost of accounting for it) it
> will be counter productive to use this scheduler.

This is nvme, actual device. The initial posting could be a bit more
explicit on the use case, it says:

"For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
terms of IOPS per core over "noop" I/O scheduler."

which made me very skeptical, as it sounds like it's raw device claims.

Does beg the question of why this is a new scheduler then. It's pretty
basic stuff, something that could trivially just be added a side effect
of the core (and in fact we have much of it already). Doesn't really seem
to warrant a new scheduler at all. There isn't really much in there.

>>> [5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
>>
>> Was curious and wanted to look it up, but it doesn't exist.
> 
> I think this is the right one:
> https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf
> 
> We had some back and forth around the naming, hence this was probably
> omitted.

That works, my local results were a bit worse than listed in there though.
And what does this mean:

"We note that Linux I/O scheduler introduces an additional kernel worker
thread at the I/O dispatching stage"

It most certainly does not for the common/hot case.

-- 
Jens Axboe

