Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB627BC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgI2FkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgI2FkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:40:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601357998;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akS9VzeQKH3+gMJC7QESfPY5dZwr7bk07gjmZdMXaD4=;
        b=QrNCebFKbQIP2k0Xa+BTMtfok8qd0FLkDuLpb24myXz59p1gGBjoYi41WmlZQj3iG9ZocN
        QYb54m3eGxOGdXsOSQaygjZwpdOLesW5k0v5llsTF2yTVzJiMTaWVmvBWEGCwRpxMXpeok
        4dUpQ4ONqseXEwlSh3a2CpBJ4f+AkME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-k-5DdBi6MuOq8G07DGALSw-1; Tue, 29 Sep 2020 01:39:54 -0400
X-MC-Unique: k-5DdBi6MuOq8G07DGALSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462C08797D4;
        Tue, 29 Sep 2020 05:39:52 +0000 (UTC)
Received: from [10.64.54.144] (vpn2-54-144.bne.redhat.com [10.64.54.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3517C3782;
        Tue, 29 Sep 2020 05:39:50 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 0/2] arm64/mm: Enable color zero pages
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        robin.murphy@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20200928072256.13098-1-gshan@redhat.com>
 <20200928152206.GC27500@gaia>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <094868d8-3eed-6e83-70b4-f8833101acf2@redhat.com>
Date:   Tue, 29 Sep 2020 15:39:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200928152206.GC27500@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 9/29/20 1:22 AM, Catalin Marinas wrote:
> On Mon, Sep 28, 2020 at 05:22:54PM +1000, Gavin Shan wrote:
>> Testing
>> =======
>> [1] The experiment reveals how heavily the (L1) data cache miss impacts
>>      the overall application's performance. The machine where the test
>>      is carried out has the following L1 data cache topology. In the
>>      mean while, the host kernel have following configurations.
>>
>>      The test case allocates contiguous page frames through HugeTLBfs
>>      and reads 4-bytes data from the same offset (0x0) from these (N)
>>      contiguous page frames. N is equal to 8 or 9 separately in the
>>      following two test cases. This is repeated for one million of
>>      times.
>>
>>      Note that 8 is number of L1 data cache ways. The experiment is
>>      cause L1 cache thrashing on one particular set.
>>
>>      Host:      CONFIG_ARM64_PAGE_SHIFT=12
>>                 DEFAULT_HUGE_PAGE_SIZE=2MB
>>      L1 dcache: cache-line-size=64
>>                 number-of-sets=64
>>                 number-of-ways=8
>>
>>                              N=8           N=9
>>      ------------------------------------------------------------------
>>      cache-misses:           43,429        9,038,460
>>      L1-dcache-load-misses:  43,429        9,038,460
>>      seconds time elapsed:   0.299206372   0.722253140   (2.41 times)
>>
>> [2] The experiment should have been carried out on machine where the
>>      L1 data cache capacity of one particular way is larger than 4KB.
>>      However, I'm unable to find such kind of machines. So I have to
>>      evaluate the performance impact caused by L2 data cache thrashing.
>>      The experiment is carried out on the machine, which has following
>>      L1/L2 data cache topology. The host kernel configuration is same
>>      to [1].
>>
>>      The corresponding test program allocates contiguous page frames
>>      through hugeTLBfs and builds VMAs backed by zero pages. These
>>      contiguous pages are sequentially read from fixed offset (0) in step
>>      of 32KB and by 8 times. After that, the VMA backed by zero pages are
>>      sequentially read in step of 4KB and by once. It's repeated by 8
>>      millions of times.
>>
>>      Note 32KB is the cache capacity in one L2 data cache way and 8 is
>>      number of L2 data cache sets. This experiment is to cause L2 data
>>      cache thrashing on one particular set.
>>
>>      L1 dcache:  <same as [1]>
>>      L2 dcache:  cache-line-size=64
>>                  number-of-sets=512
>>                  number-of-ways=8
>>
>>      -----------------------------------------------------------------------
>>      cache-references:       1,427,213,737    1,421,394,472
>>      cache-misses:              35,804,552       42,636,698
>>      L1-dcache-load-misses:     35,804,552       42,636,698
>>      seconds time elapsed:   2.602511671      2.098198172      (+19.3%)
> 
> No-one is denying a performance improvement in a very specific way but
> what's missing here is explaining how these artificial benchmarks relate
> to real-world applications.
> 

Thanks for your comments. It depends on the activities of reading zero
pages and its frequency. The idea is to distribute reading zero page(s)
on multiple sets of caches. Otherwise, the cache sets corresponding to
these zero page(s) are have more load and prone to cause cache thrashing,
depending on the workload pattern though.

As discussed on v1, there are two use cases from the kernel code: (1)
/proc/vmcore (2) DAX. For (1), it's only valid on x86 where those
non-RAM-resident pages are mapped and backed by zero page(s). For (2),
I was expecting to setup xfs and DAX on RBD (Ram Block Device).
Unfortunately, DAX support for RBD was removed two years ago and
I'm unable to enable xfs and DAX on RBD. DAX is only supported on
limited hardware and I don't have around.

    # mknod /dev/ramdisk b 1 20
    # mkfs.xfs /dev/ramdisk
    # mkdir -p /tmp/ramdisk
    # mount -txfs -odax /dev/ramdisk /tmp/ramdisk
    # dmesg | tail -n 4
    [ 3721.848830] brd: module loaded
    [ 3772.015934] XFS (ram20): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
    [ 3772.023423] XFS (ram20): DAX unsupported by block device. Turning off DAX.
    [ 3772.030285] XFS (ram20): DAX and reflink cannot be used together!

the feature just needs a couple of extra pages and it wouldn't be a
concern. However, the caching behavior for reading zero page(s) is
altering because the caches for zero pages are distributed. It depends
on how frequently these zero page(s) are accessed. Also, I tried to
build the kernel image and no performance altering is detected.

    command:           make -j 80 clean; time make -j 80
                       (was executed for 3 times)
    without the patch: 3m29.084s 3m29.265s 3m30.806s
    with the patch:    3m28.954s 3m29.819s 3m30.180s

Cheers,
Gavin

