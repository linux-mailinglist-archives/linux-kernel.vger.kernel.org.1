Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB782BB4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKTTJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:09:17 -0500
Received: from m12-12.163.com ([220.181.12.12]:35264 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgKTTJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=DiHu0
        po/f5/WN7ZezhXfY9C5nO2oq5AMzNtm78n4y4c=; b=ZunsjLNlyM4hRgqY8hUFv
        gG3w2E68cAa6AwosVxco4H8X1sMWRodPIULLbuUM8jmSD+6HyhU+9jP/I11k4ny0
        5D8MXO5k9xCGH0gUam5MSEaCd6hrrI/jFBN3S+avWpIJGyJ0MVnUksGy/qSupyNY
        /fueLB1J48wGlQX4pDJt+0=
Received: from localhost (unknown [101.86.213.141])
        by smtp8 (Coremail) with SMTP id DMCowAAnChxFFLhfn+9sCw--.55196S2;
        Sat, 21 Nov 2020 03:08:53 +0800 (CST)
Date:   Sat, 21 Nov 2020 03:08:52 +0800
From:   Hui Su <sh_def@163.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201120190852.GA19256@rlk>
References: <20201117171242.GA120587@rlk>
 <20201117174117.GQ29991@casper.infradead.org>
 <20201117174633.GA158014@rlk>
 <20201117174727.GR29991@casper.infradead.org>
 <20201117175658.GA158143@rlk>
 <20201117175900.GS29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117175900.GS29991@casper.infradead.org>
X-CM-TRANSID: DMCowAAnChxFFLhfn+9sCw--.55196S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1rAw43Wr47CFyftF13Arb_yoWrJFyfp3
        43tanIyF1kJ3WDJr1vgw1Uuw1qqw4ftwn0gr1UZ348CFn0yFW0qr9rtr1rua4qgFyku3yF
        yrWUWa43t3y2y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHxRgUUUUU=
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDgXiX1rbLHniewAAs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 05:59:00PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 18, 2020 at 01:56:58AM +0800, Hui Su wrote:
> > On Tue, Nov 17, 2020 at 05:47:27PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 18, 2020 at 01:46:33AM +0800, Hui Su wrote:
> > > > On Tue, Nov 17, 2020 at 05:41:17PM +0000, Matthew Wilcox wrote:
> > > > > On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> > > > > > lru_list lru bit 0 can tell whether the list is
> > > > > > avtive lru-list or not.
> > > > > > lru_list lru bit 1 can tell whether the list is
> > > > > > file lru-list or not.
> > > > > > 
> > > > > > And fix some define type in shrink_active_list()
> > > > > > and get_scan_count().
> > > > > > 
> > > > > > v1->v2:
> > > > > > correct the commit message, and fix the define type.
> > > > > 
> > > > > No, still incorrect.
> > > > 
> > > > I am a little confused, can you tell in detail?
> > > 
> > > Have you booted a kernel with this change?  Have you run any kind of
> > > tests on it?
> > 
> > Yes, I boot it with qemu-system-x86_64-4.1.50 on ubuntu20.04:
> > qemu-system-x86_64 -kernel /home/rlk/workspace/compile/out/arch/x86_64/boot/bzImage -hda \
> >  /home/rlk/myspace/qemu_build/rootfs.img -append "root=/dev/sda console=ttyS0" -nographic
> > 
> > using the kernel compiled with ubuntu20.04's default .config.
> > 
> > It seems nothing abnormal.
> > And i did not do other test.
> 
> Maybe you should ... how about LTP?  I think that's pretty straightforward
> to set up and run.

Hi Matthew:

Thanks for your advice, i finally setup a test platform powered by
jenkins and QEMU emulator version 4.2.1 with two evening. This is
the things that i always wanted to do but didn't do.

I apply this change based on the commit: 4d02da974ea8, and compile
it with x86_64_defconfig:
make bzImage O=/var/lib/jenkins/workspace/linux_kernel_ltp/out/

Then start qemu:
sudo qemu-system-x86_64 \
    -kernel /var/lib/jenkins/workspace/linux_kernel_ltp/out/arch/x86/boot/bzImage \
    -hda /home/ubuntu/myspace/qemu_build/ubuntu.img \
    -hdb /home/ubuntu/myspace/qemu_build/init.img       \
    -append "root=/dev/sda console=ttyS0" \
    -nographic \
    -m 1024 \
    -fsdev local,id=fs1,path=/home/ubuntu/workspace,security_model=none \
    -device virtio-9p-pci,fsdev=fs1,mount_tag=jeff-host-code

Then run the ltp test:
sudo bash /opt/ltp/runltp -f mm

The result is:
Test Start Time: Sat Nov 21 02:06:46 2020
-----------------------------------------
Testcase                                           Result     Exit Value
--------                                           ------     ----------
mm01                                               PASS       0    
mm02                                               PASS       0    
mtest01                                            PASS       0    
mtest01w                                           PASS       0    
mtest05                                            PASS       0    
mtest06                                            FAIL       2    
mtest06_2                                          PASS       0    
mtest06_3                                          PASS       0    
mem02                                              PASS       0    

mmapstress01                                       PASS       0    
mmapstress02                                       PASS       0    
mmapstress03                                       PASS       0    
mmapstress04                                       PASS       0    
mmapstress05                                       PASS       0    
mmapstress06                                       PASS       0    
mmapstress07                                       PASS       0    
mmapstress08                                       PASS       0    
mmapstress09                                       PASS       0    
mmapstress10                                       PASS       0    
mmap10                                             PASS       0    
mmap10_1                                           PASS       0    
mmap10_2                                           CONF       32   
mmap10_3                                           CONF       32   
mmap10_4                                           CONF       32   
ksm01                                              CONF       32   
ksm01_1                                            CONF       32   
ksm02                                              CONF       32   
ksm02_1                                            CONF       32   
ksm03                                              CONF       32   
ksm03_1                                            CONF       32   
ksm04                                              CONF       32   
ksm04_1                                            CONF       32   
ksm05                                              CONF       32   
ksm06                                              CONF       32   

thp02                                              CONF       32   
thp03                                              CONF       32   
thp04                                              CONF       32   
vma01                                              PASS       0    
vma02                                              CONF       32   
vma03                                              CONF       32   
vma04                                              CONF       32   
vma05                                              CONF       32   
overcommit_memory01                                PASS       0    
overcommit_memory02                                CONF       32   
overcommit_memory03                                PASS       0    
overcommit_memory04                                PASS       0    
overcommit_memory05                                PASS       0    
overcommit_memory06                                PASS       0    
max_map_count                                      PASS       0    
min_free_kbytes                                    PASS       0    

-----------------------------------------------
Total Tests: 76
Total Skipped Tests: 29
Total Failures: 1
Kernel Version: 5.10.0-rc4+
Machine Architecture: x86_64
Hostname: ubuntu

The one failure happens without my change, too.(maybe my config is
not correct? I am not sure). 

Last, i think this change have no problem.
And what's your opinions, Matthew.

Thanks.


