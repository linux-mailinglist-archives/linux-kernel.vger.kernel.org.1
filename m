Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA58266939
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 21:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgIKTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:53:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F5CC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 12:53:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f162200706a91c2aab828ed.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:2200:706a:91c2:aab8:28ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04B0C1EC0516;
        Fri, 11 Sep 2020 21:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599854002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=iiIfAdRdC2ihwZvcpGt6ZTiG2ZXSbsFnUDXd4IBoGWI=;
        b=FPSk3pL2oQkI7r+daKMBhTtXVnTP3UT/XjOIIfNBUeggJ8tMJd7LQekbrc4yp+wIi+FTbi
        AVezy5zJJPjpXrHySZ9iNoI3tBi+vSrasNi03vpGyiBMJtxDjH4zFPcX0vXuaudQ1w1pai
        W6/CKHy7k+D6RlYestmERne+1rFBR28=
Date:   Fri, 11 Sep 2020 21:53:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6] scsi:
 sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200911195312.GA4110@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tztztz,

you're not my colleague anymore and now you break my box?!?!

:-)))

Here's how: current Linus master doesn't finish booting on my
workstation and what I see as the last line printed on the console is:

...
[    6.778532] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    6.785275] ata8.00: ATA-10: WDC WD1003FZEX-00K3CA0, 01.01A01, max UDMA/133
[    6.792247] ata8.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    6.799848] ata8.00: configured for UDMA/133
[    6.804679] scsi 7:0:0:0: Direct-Access     ATA      WDC WD1003FZEX-0 1A01 PQ: 0 ANSI: 5
[    6.812884] sd 7:0:0:0: Attached scsi generic sg2 type 0
[    6.812934] sd 7:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    6.825897] sd 7:0:0:0: [sdc] 4096-byte physical blocks
[    6.831151] sd 7:0:0:0: [sdc] Write Protect is off
[    6.835966] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    6.841052] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.878559]  sdc: sdc1
[    6.881069] sd 7:0:0:0: [sdc] Attached SCSI disk
<--- EOF

I had to bisect on the workstation (yah, I know, bisecting on the
workstation is no fun...), see bisect log at the end.

Now, looking at that patch:

  5795eb443060 ("scsi: sd_zbc: emulate ZONE_APPEND commands")

yeah, that doesn't revert cleanly. But it talks about zoned-something
devices and that rings a bell because you guys broke my zoned device
once already:

[    4.954946] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.972405] ata4.00: NCQ Send/Recv Log not supported
[    4.988254] ata4.00: ATA-10: ST8000AS0022-1WL17Z, SN01, max UDMA/133
[    4.994569] ata4.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    5.004576] ata4.00: NCQ Send/Recv Log not supported
[    5.011398] ata4.00: configured for UDMA/133
[    5.015727] scsi 3:0:0:0: Direct-Access     ATA      ST8000AS0022-1WL SN01 PQ: 0 ANSI: 5
[    5.023849] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    5.023889] sd 3:0:0:0: [sdb] Host-aware zoned block device
[    5.034730] sd 3:0:0:0: [sdb] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
[    5.042511] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    5.047722] sd 3:0:0:0: [sdb] Write Protect is off
[    5.052499] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.057538] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.143300]  sdb: sdb1
[    5.145683] sdb: disabling host aware zoned block device support due to partitions
[    5.153311] sd 3:0:0:0: [sdb] Attached SCSI disk

so I thought, lemme disable that device and see if it boots. If it does, it
probably points more in the direction of this patch.

So I booted with "libata.force=4.00:disable" and yap, the box was up
just fine.

As to a reproducer - I'm guessing grabbing such a host-aware zoned
device and slapping a single partition on it, would probably trigger it.

If not, I can try to test patches but it'll take a while because this is
my main box.

$ git bisect start
# bad: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
git bisect bad b3a9e3b9622ae10064826dccb4f7a52bd88c7407
# good: [3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162] Linux 5.7
git bisect good 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
# bad: [ee01c4d72adffb7d424535adf630f2955748fa8b] Merge branch 'akpm' (patches from Andrew)
git bisect bad ee01c4d72adffb7d424535adf630f2955748fa8b
# bad: [16d91548d1057691979de4686693f0ff92f46000] Merge tag 'xfs-5.8-merge-8' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad 16d91548d1057691979de4686693f0ff92f46000
# good: [cfa3b8068b09f25037146bfd5eed041b78878bee] Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good cfa3b8068b09f25037146bfd5eed041b78878bee
# good: [3fd911b69b3117e03181262fc19ae6c3ef6962ce] Merge tag 'drm-misc-next-2020-05-07' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect good 3fd911b69b3117e03181262fc19ae6c3ef6962ce
# good: [1966391fa576e1fb2701be8bcca197d8f72737b7] mm/migrate.c: attach_page_private already does the get_page
git bisect good 1966391fa576e1fb2701be8bcca197d8f72737b7
# good: [0c8d3fceade2ab1bbac68bca013e62bfdb851d19] bcache: configure the asynchronous registertion to be experimental
git bisect good 0c8d3fceade2ab1bbac68bca013e62bfdb851d19
# bad: [f41030a20b38552a2da3b3f6bc9e7a78637d6c23] Merge tag 'selinux-pr-20200601' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
git bisect bad f41030a20b38552a2da3b3f6bc9e7a78637d6c23
# bad: [419c3d5e8012928fbf9a086b07b618146cc9277b] blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
git bisect bad 419c3d5e8012928fbf9a086b07b618146cc9277b
# bad: [b2f609e191edc9c7a9dec603318461eeb23f8a6b] block: move the blk-mq calls out of part_in_flight{,_rw}
git bisect bad b2f609e191edc9c7a9dec603318461eeb23f8a6b
# bad: [29b2a3aa296711cfdadafbf627c2d9a388fc84ee] block: export bio_release_pages and bio_iov_iter_get_pages
git bisect bad 29b2a3aa296711cfdadafbf627c2d9a388fc84ee
# good: [02992df822e7e36685593aad10721a5a9f8d3402] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
git bisect good 02992df822e7e36685593aad10721a5a9f8d3402
# good: [e732671aa5f67232cf760666a15242dead003362] block: Modify revalidate zones
git bisect good e732671aa5f67232cf760666a15242dead003362
# bad: [5795eb443060148796beeba106e4366d7f1458a6] scsi: sd_zbc: emulate ZONE_APPEND commands
git bisect bad 5795eb443060148796beeba106e4366d7f1458a6
# good: [02494d35ba5547562aae4d9c4df2d6ec33d29012] scsi: sd_zbc: factor out sanity checks for zoned commands
git bisect good 02494d35ba5547562aae4d9c4df2d6ec33d29012
# first bad commit: [5795eb443060148796beeba106e4366d7f1458a6] scsi: sd_zbc: emulate ZONE_APPEND commands

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
