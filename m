Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA7267657
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgIKXHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 19:07:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42220 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgIKXHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 19:07:11 -0400
Received: from nazgul.tnic (p200300ec2f1622003e970efffe6befe7.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:2200:3e97:eff:fe6b:efe7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C720C1EC0532;
        Sat, 12 Sep 2020 01:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599865629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k6+XuMn/9By8oblAt/yFHFqB1m+wE7For/79ZVChVe8=;
        b=G8Vh76cSoScuZKA9sHJGw6tirhFfnUycEJraC7sZRFBNnImMfPAFuT/wynfGICE3imhv+q
        zHyH3FojYvqm3HUsJ9+/t7zvBAVROwwmUVqoX9fx4GCI/cZYY9+++iPUyhg8ti19gj2E+u
        y7vb6uz5TbpVzOzplxaclQ2b9LydpT8=
Date:   Sat, 12 Sep 2020 01:07:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200911230703.GA2971@nazgul.tnic>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911221759.GA2869@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 12:17:59AM +0200, Borislav Petkov wrote:
> Enabling it, fixes the issue.

Btw, I just hit the below warn with 5.8, while booting with the above
config option enabled. Looks familiar and I didn't trigger it with
5.9-rc4+ so you guys either fixed it or something changed in-between:

[    5.124321] ata4.00: NCQ Send/Recv Log not supported
[    5.131484] ata4.00: configured for UDMA/133
[    5.135847] scsi 3:0:0:0: Direct-Access     ATA      ST8000AS0022-1WL SN01 PQ: 0 ANSI: 5
[    5.143972] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    5.144033] sd 3:0:0:0: [sdb] Host-aware zoned block device
[    5.177105] sd 3:0:0:0: [sdb] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
[    5.184880] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    5.190084] sd 3:0:0:0: [sdb] 29808 zones of 524288 logical blocks + 1 runt zone
[    5.197439] sd 3:0:0:0: [sdb] Write Protect is off
[    5.202220] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.207260] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.356631]  sdb: sdb1
[    5.359014] sdb: disabling host aware zoned block device support due to partitions
[    5.389941] ------------[ cut here ]------------
[    5.394557] WARNING: CPU: 8 PID: 164 at block/blk-settings.c:236 blk_queue_max_zone_append_sectors+0x12/0x40
[    5.404300] Modules linked in:
[    5.407365] CPU: 8 PID: 164 Comm: kworker/u32:6 Not tainted 5.8.0 #7
[    5.413682] Hardware name: Micro-Star International Co., Ltd. MS-7B79/X470 GAMING PRO (MS-7B79), BIOS 1.70 01/23/2019
[    5.424191] Workqueue: events_unbound async_run_entry_fn
[    5.429482] RIP: 0010:blk_queue_max_zone_append_sectors+0x12/0x40
[    5.435543] Code: fe 0f 00 00 53 48 89 fb 0f 86 3d 07 00 00 48 89 b3 e0 03 00 00 5b c3 90 0f 1f 44 00 00 8b 87 40 04 00 00 ff c8 83 f8 01 76 03 <0f> 0b c3 8b 87 f8 03 00 00 39 87 f0 03 00 00 0f 46 87 f0 03 00 00
[    5.454099] RSP: 0018:ffffc90000697c60 EFLAGS: 00010282
[    5.459306] RAX: 00000000ffffffff RBX: ffff8887fa0a9400 RCX: 0000000000000000
[    5.466390] RDX: ffff8887faf0d400 RSI: 0000000000000540 RDI: ffff8887f0dde6c8
[    5.473474] RBP: 0000000000007471 R08: 00000000001d1c40 R09: ffff8887fee29ad0
[    5.480559] R10: 00000001434bac00 R11: 0000000000358275 R12: 0000000000080000
[    5.487643] R13: ffff8887f0dde6c8 R14: ffff8887fa0a9738 R15: 0000000000000000
[    5.494726] FS:  0000000000000000(0000) GS:ffff8887fee00000(0000) knlGS:0000000000000000
[    5.502757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.508474] CR2: 0000000000000000 CR3: 0000000002209000 CR4: 00000000003406e0
[    5.515558] Call Trace:
[    5.518026]  sd_zbc_read_zones+0x323/0x480
[    5.522122]  sd_revalidate_disk+0x122b/0x2000
[    5.526472]  ? __device_add_disk+0x2f7/0x4e0
[    5.530738]  sd_probe+0x347/0x44b
[    5.534058]  really_probe+0x2c4/0x3f0
[    5.537720]  driver_probe_device+0xe1/0x150
[    5.541902]  ? driver_allows_async_probing+0x50/0x50
[    5.546852]  bus_for_each_drv+0x6a/0xa0
[    5.550683]  __device_attach_async_helper+0x8c/0xd0
[    5.555547]  async_run_entry_fn+0x4a/0x180
[    5.559636]  process_one_work+0x1a5/0x3a0
[    5.563637]  worker_thread+0x50/0x3a0
[    5.567300]  ? process_one_work+0x3a0/0x3a0
[    5.571480]  kthread+0x117/0x160
[    5.574715]  ? kthread_park+0x90/0x90
[    5.578377]  ret_from_fork+0x22/0x30
[    5.581960] ---[ end trace 94141003236730cf ]---
[    5.586578] sd 3:0:0:0: [sdb] Attached SCSI disk
[    6.186783] ata5: failed to resume link (SControl 0)
[    6.191818] ata5: SATA link down (SStatus 0 SControl 0)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
