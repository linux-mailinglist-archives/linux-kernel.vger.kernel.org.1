Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557122F0F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbhAKKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbhAKKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610359154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jycj1y2jo8xQIoybhpepcY8teXkRK2s1VZyqJsElOSc=;
        b=OppnU9Yaef+qdAb+U0kF6IHC82WwiNbplZtmPn7uQEnNzyW+DEKxYSq72LvWrRvZBD0Yiu
        nyxxA7vtjypAxDr598X6NLf8ftijz3ymfqxj0QhMTgMFsdOWWQ0NT+RRp/7jKUvmogpSNR
        hZ9gCGyaFOU6r+G7Q2B3yHX4Ixqf0GI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-4oUB2T-EMwiUbwEH7bjctg-1; Mon, 11 Jan 2021 04:59:11 -0500
X-MC-Unique: 4oUB2T-EMwiUbwEH7bjctg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34708107ACF7;
        Mon, 11 Jan 2021 09:59:09 +0000 (UTC)
Received: from T590 (ovpn-14-16.pek2.redhat.com [10.72.14.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 700755D9F4;
        Mon, 11 Jan 2021 09:58:58 +0000 (UTC)
Date:   Mon, 11 Jan 2021 17:58:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [percpu_ref]  2b0d3d3e4f:  reaim.jobs_per_min -18.4% regression
Message-ID: <20210111095854.GA4155851@T590>
References: <20210110143247.GA6259@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110143247.GA6259@xsang-OptiPlex-9020>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:32:47PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -18.4% regression of reaim.jobs_per_min due to commit:
> 
> 
> commit: 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: reaim
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 100%
> 	test: short
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01
> 
> test-description: REAIM is an updated and improved version of AIM 7 benchmark.
> test-url: https://sourceforge.net/projects/re-aim-7/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput -2.8% regression                |
> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | runtime=300s                                                              |
> |                  | test=lru-file-mmap-read-rand                                              |
> |                  | ucode=0x5003003                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 14.5% improvement            |
> | test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory    |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=50%                                                               |
> |                  | test=page_fault2                                                          |
> |                  | ucode=0x16                                                                |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops -13.0% regression            |
> | test machine     | 104 threads Skylake with 192G memory                                      |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=50%                                                               |
> |                  | test=malloc1                                                              |
> |                  | ucode=0x2006906                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput -2.3% regression                |
> | test machine     | 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory                |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | runtime=300s                                                              |
> |                  | test=lru-file-mmap-read-rand                                              |
> |                  | ucode=0x5002f01                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | fio-basic: fio.read_iops -4.8% regression                                 |
> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | bs=4k                                                                     |
> |                  | cpufreq_governor=performance                                              |
> |                  | disk=2pmem                                                                |
> |                  | fs=xfs                                                                    |
> |                  | ioengine=libaio                                                           |
> |                  | nr_task=50%                                                               |
> |                  | runtime=200s                                                              |
> |                  | rw=randread                                                               |
> |                  | test_size=200G                                                            |
> |                  | time_based=tb                                                             |
> |                  | ucode=0x5002f01                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.stackmmap.ops_per_sec -45.4% regression              |
> | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory      |
> | test parameters  | class=memory                                                              |
> |                  | cpufreq_governor=performance                                              |
> |                  | disk=1HDD                                                                 |
> |                  | nr_threads=100%                                                           |
> |                  | testtime=10s                                                              |
> |                  | ucode=0x5002f01                                                           |
> +------------------+---------------------------------------------------------------------------+

Just run a quick test of the last two on 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of
percpu_ref in fast path) and cf785af19319 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()").

Not see difference in the two kernel(fio on null_blk with 224 hw queues,
and 'stress-ng --stackmmap-ops') on one 224 cores, dual sockets system.

BTW this patch itself doesn't touch fast path code, so it is supposed to
not affect performance.

Can you double check if the test itself is good?

Note: cf785af19319 is 2b0d3d3e4fcf^



Thanks,
Ming

