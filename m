Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF72C147E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgKWT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:28:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729183AbgKWT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606159711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35zTyk9zZ1bzwx+hvEhXskWjgKi8Ryp4QK7yWth92P4=;
        b=in9xqrZCiAYBET1CyGbIAAxRnb+X/vaxZ2PNFfn8vqDfNi5Q915JRKnzboQ7VzJvAQAY1x
        sCXkILerGPojJxjGWjwBUXiQNqkXA6rujyQEx88PXHkdoCdMkuBsa9HQr6p5vLwuMj2ZLE
        X/obzmcDyj/VU2+2/rTLtcFcpoHQkgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-YUgBIwujPNCRmisBaTHhuw-1; Mon, 23 Nov 2020 14:28:27 -0500
X-MC-Unique: YUgBIwujPNCRmisBaTHhuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA3C03E748;
        Mon, 23 Nov 2020 19:28:25 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-131.rdu2.redhat.com [10.10.116.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5228A60C04;
        Mon, 23 Nov 2020 19:28:24 +0000 (UTC)
Subject: Re: [locking/rwsem] 10a59003d2: unixbench.score -25.5% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, 0day robot <lkp@intel.com>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20201123155327.GA26172@xsang-OptiPlex-9020>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2fe05c84-fe0b-c7da-7ba8-c5bac2e6fb56@redhat.com>
Date:   Mon, 23 Nov 2020 14:28:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201123155327.GA26172@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 10:53 AM, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed a -25.5% regression of unixbench.score due to commit:
>
>
> commit: 10a59003d29fbfa855b2ef4f3534fee9bdf4e575 ("[PATCH v2 5/5] locking/rwsem: Remove reader optimistic spinning")
> url: https://github.com/0day-ci/linux/commits/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 932f8c64d38bb08f69c8c26a2216ba0c36c6daa8
>
> in testcase: unixbench
> on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> with following parameters:
>
> 	runtime: 300s
> 	nr_task: 30%
> 	test: shell8
> 	cpufreq_governor: performance
> 	ucode: 0xde
>
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
>
> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | fio-basic: fio.write_iops -29.9% regression                               |
> | test machine     | 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory               |
> | test parameters  | bs=4k                                                                     |
> |                  | cpufreq_governor=performance                                              |
> |                  | disk=1SSD                                                                 |
> |                  | fs=xfs                                                                    |
> |                  | ioengine=sync                                                             |
> |                  | nr_task=32                                                                |
> |                  | runtime=300s                                                              |
> |                  | rw=randwrite                                                              |
> |                  | test_size=256g                                                            |
> |                  | ucode=0x4003003                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | aim7: aim7.jobs-per-min 952.6% improvement                                |
> | test machine     | 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz with 128G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | disk=4BRD_12G                                                             |
> |                  | fs=f2fs                                                                   |
> |                  | load=100                                                                  |
> |                  | md=RAID0                                                                  |
> |                  | test=sync_disk_rw                                                         |
> |                  | ucode=0x4003003                                                           |
> +------------------+---------------------------------------------------------------------------+

A performance drop in some benchmark is expected. However, there are 
others that can show improvement. Will take a look to see if we can 
reduce the performance regression.

Thanks,
Longman

