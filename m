Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5882B0C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKLSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgKLSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:02:24 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2DAC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:02:22 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id p7so6980958ioo.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JB92aBZElM//76rTz+L8GOl8zGbr0pptcYjPzdqVG2s=;
        b=Op80xd+aAWrCoExYMd+zd4/oCv1l5eWWAxL7M1KChpj+qGlV8ATMfmL62+ZK8aGvb1
         8mIbgfjxyy4KuL1wVjqJmemSaGVAaFgGTMHNNt0qXphPi2oCtD4UNyMDOtIocvkO0dec
         xj/fJQ89NfIZ6+2iI1T7rFXu5qLflCuRH/0ja/fUFxK/QNMrkScLHwKRxo6j60Asq56R
         72phd6R3/6WnFaBmL3ub22em7X6ISTXudVSGPIN7Gtxhz2Nf7tiKxY7qQU3uHn7Rcxdf
         ogSL3HoCbQt+cInIYkmqvKf71VNDt27dTPtnyknBmg0WKKyllsc63Vz3dNATyKeyshJ7
         rtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JB92aBZElM//76rTz+L8GOl8zGbr0pptcYjPzdqVG2s=;
        b=id2ILHRPvp4weWreBswMGXRfCSCly+5FDcWnueNimv51JpfKfMqXkuZWyiKV0Kvre7
         JtFtKCF8JHb13lrDMiaw+mqqUADvTubGodxtdVDpflBbIF3aiQ/zN1FWOCB0IYbTD4nv
         HtBriYspNOWBbI94CCtOZniRVJGJ/pqSiHXxaqLMMXRdKvgU3Lotb6Fo3DyYdiiZtlxh
         IH7HD6DepaKO6Tvnk5wVpndJlK2tkk+TuTuEVOlC9hEJCsdN3rdDjl5bHs51IfT6B4DV
         gvg8wSV3EH9pFIVIiOkB1Um/mh3nTVfv1AB/PLe60gLSkhRONKEzzRClQRpdhvHRmaTN
         7Sjg==
X-Gm-Message-State: AOAM53045zkeGmys5XdnpLRUgO3fpKUVj9osOmwytCJ7WpzEwruTY7LU
        brfCOC9Tksbl87w3uww+Hf8mqRDYXoj64Q==
X-Google-Smtp-Source: ABdhPJwEMh1n/6KyIprtuXgj+dBui6wMHNOhf3sf0Kaa7fVQv5w/H3XiG5xp4YqzhfDML0rgfZF4kw==
X-Received: by 2002:a6b:8d58:: with SMTP id p85mr242757iod.74.1605204141949;
        Thu, 12 Nov 2020 10:02:21 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm3292689ilq.48.2020.11.12.10.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 10:02:21 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Rachit Agarwal <rach4x0r@gmail.com>, Christoph Hellwig <hch@lst.de>
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
Date:   Thu, 12 Nov 2020 11:02:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112140752.1554-1-rach4x0r@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 7:07 AM, Rachit Agarwal wrote:
> From: Rachit Agarwal <rach4x0r@gmail.com>>
> 
> Hi All,
> 
> I/O batching is beneficial for optimizing IOPS and throughput for
> various applications. For instance, several kernel block drivers would
> benefit from batching, including mmc [1] and tcp-based storage drivers
> like nvme-tcp [2,3]. While we have support for batching dispatch [4],
> we need an I/O scheduler to efficiently enable batching. Such a
> scheduler is particularly interesting for disaggregated storage, where
> the access latency of remote disaggregated storage may be higher than
> local storage access; thus, batching can significantly help in
> amortizing the remote access latency while increasing the throughput.
> 
> This patch introduces the i10 I/O scheduler, which performs batching
> per hctx in terms of #requests, #bytes, and timeouts (at microseconds
> granularity). i10 starts dispatching only when #requests or #bytes is
> larger than a default threshold or when a timer expires. After that,
> batching dispatch [3] would happen, allowing batching at device
> drivers along with "bd->last" and ".commit_rqs".
> 
> The i10 I/O scheduler builds upon recent work on [6]. We have tested
> the i10 I/O scheduler with nvme-tcp optimizaitons [2,3] and batching
> dispatch [4], varying number of cores, varying read/write ratios, and
> varying request sizes, and with NVMe SSD and RAM block device. For
> NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in terms
> of IOPS per core over "noop" I/O scheduler. These results are
> available at [5], and many additional results are presented in [6].
> 
> While other schedulers may also batch I/O (e.g., mq-deadline), the
> optimization target in the i10 I/O scheduler is throughput
> maximization. Hence there is no latency target nor a need for a global
> tracking context, so a new scheduler is needed rather than to build
> this functionality to an existing scheduler.
> 
> We currently use fixed default values as batching thresholds (e.g., 16
> for #requests, 64KB for #bytes, and 50us for timeout). These default
> values are based on sensitivity tests in [6]. For our future work, we
> plan to support adaptive batching according to system load and to
> extend the scheduler to support isolation in multi-tenant deployments
> (to simultaneously achieve low tail latency for latency-sensitive
> applications and high throughput for throughput-bound applications).

I haven't taken a close look at the code yet so far, but one quick note
that patches like this should be against the branches for 5.11. In fact,
this one doesn't even compile against current -git, as
blk_mq_bio_list_merge is now called blk_bio_list_merge.

In any case, I did run this through some quick peak testing as I was
curious, and I'm seeing about 20% drop in peak IOPS over none running
this. Perf diff:

    10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
     2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock

Also:

> [5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf

Was curious and wanted to look it up, but it doesn't exist.

-- 
Jens Axboe

