Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8256C221CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 09:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGPHCR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jul 2020 03:02:17 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34497 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgGPHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:02:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U2sgXws_1594882879;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2sgXws_1594882879)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 15:01:26 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716021929-mutt-send-email-mst@kernel.org>
Date:   Thu, 16 Jul 2020 15:01:18 +0800
Cc:     Hui Zhu <teawater@gmail.com>, david@redhat.com,
        jasowang@redhat.com, akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <20200716021929-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年7月16日 14:38，Michael S. Tsirkin <mst@redhat.com> 写道：
> 
> On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
>> The first, second and third version are in [1], [2] and [3].
>> Code of current version for Linux and qemu is available in [4] and [5].
>> Update of this version:
>> 1. Report continuous pages will increase the speed.  So added deflate
>>   continuous pages.
>> 2. According to the comments from David in [6], added 2 new vqs inflate_cont_vq
>>   and deflate_cont_vq to report continuous pages with format 32 bits pfn and 32
>>   bits size.
>> Following is the introduction of the function.
>> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With this
>> flag, balloon tries to use continuous pages to inflate and deflate.
>> Opening this flag can bring two benefits:
>> 1. Report continuous pages will increase memory report size of each time
>>   call tell_host.  Then it will increase the speed of balloon inflate and
>>   deflate.
>> 2. Host THPs will be splitted when qemu release the page of balloon inflate.
>>   Inflate balloon with continuous pages will let QEMU release the pages
>>   of same THPs.  That will help decrease the splitted THPs number in
>>   the host.
>>   Following is an example in a VM with 1G memory 1CPU.  This test setups an
>>   environment that has a lot of fragmentation pages.  Then inflate balloon will
>>   split the THPs.


>> // This is the THP number before VM execution in the host.
>> // None use THP.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:         0 kB
These lines are from host.

>> // After VM start, use usemem
>> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
>> // punch-holes function generates 400m fragmentation pages in the guest
>> // kernel.
>> usemem --punch-holes -s -1 800m &
These lines are from guest.  They setups the environment that has a lot of fragmentation pages.

>> // This is the THP number after this command in the host.
>> // Some THP is used by VM because usemem will access 800M memory
>> // in the guest.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    911360 kB
These lines are from host.

>> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
>> (qemu) device_add virtio-balloon-pci,id=balloon1
>> (qemu) info balloon
>> balloon: actual=1024
>> (qemu) balloon 600
>> (qemu) info balloon
>> balloon: actual=600
These lines are from host.

>> // This is the THP number after inflate the balloon in the host.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:     88064 kB
These lines are from host.

>> // Set the size back to 1024M in the QEMU monitor.
>> (qemu) balloon 1024
>> (qemu) info balloon
>> balloon: actual=1024
These lines are from host.

>> // Use usemem to increase the memory usage of QEMU.
>> killall usemem
>> usemem 800m
These lines are from guest.

>> // This is the THP number after this operation.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:     65536 kB
These lines are from host.



>> 
>> Following example change to use continuous pages balloon.  The number of
>> splitted THPs is decreased.
>> // This is the THP number before VM execution in the host.
>> // None use THP.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:         0 kB
These lines are from host.

>> // After VM start, use usemem punch-holes function generates 400M
>> // fragmentation pages in the guest kernel.
>> usemem --punch-holes -s -1 800m &
These lines are from guest.  They setups the environment that has a lot of fragmentation pages.

>> // This is the THP number after this command in the host.
>> // Some THP is used by VM because usemem will access 800M memory
>> // in the guest.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    911360 kB
These lines are from host.

>> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
>> (qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
>> (qemu) info balloon
>> balloon: actual=1024
>> (qemu) balloon 600
>> (qemu) info balloon
>> balloon: actual=600
These lines are from host.

>> // This is the THP number after inflate the balloon in the host.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    616448 kB
>> // Set the size back to 1024M in the QEMU monitor.
>> (qemu) balloon 1024
>> (qemu) info balloon
>> balloon: actual=1024
These lines are from host.

>> // Use usemem to increase the memory usage of QEMU.
>> killall usemem
>> usemem 800m
These lines are from guest.

>> // This is the THP number after this operation.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    907264 kB
These lines are from host.

> 
> I'm a bit confused about which of the above run within guest,
> and which run within host. Could you explain pls?
> 
> 

I added some introduction to show where these lines is get from.

Best,
Hui


> 
>> [1] https://lkml.org/lkml/2020/3/12/144
>> [2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
>> [3] https://lkml.org/lkml/2020/5/12/324
>> [4] https://github.com/teawater/linux/tree/balloon_conts
>> [5] https://github.com/teawater/qemu/tree/balloon_conts
>> [6] https://lkml.org/lkml/2020/5/13/1211
>> 
>> Hui Zhu (2):
>>  virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
>>  virtio_balloon: Add deflate_cont_vq to deflate continuous pages
>> 
>> drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++++++-----
>> include/linux/balloon_compaction.h  |   12 ++
>> include/uapi/linux/virtio_balloon.h |    1
>> mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
>> 4 files changed, 280 insertions(+), 30 deletions(-)
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

