Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2754C267A90
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgILNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 09:05:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgILNF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 09:05:28 -0400
Received: from zn.tnic (p200300ec2f1f6200f2fe65a0519df81f.dip0.t-ipconnect.de [IPv6:2003:ec:2f1f:6200:f2fe:65a0:519d:f81f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 809851EC03D2;
        Sat, 12 Sep 2020 15:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599915926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mDYEnNZ93sQ+DUzfOKyjtgJDGqR5jZv35kCSP5ZDSLQ=;
        b=TkNtwS8AeJQbXWMyDivYRc7k1doCzvTcsCKmlFO22S93H2i8Sf9oPpuBP9LK15yy5qz2r/
        61aomu/Aensqi06aQBp3zySJ8HziKKf1jfw3T1UhOv4qqWWNe+lvcJUu3G+qmgXkSlg79e
        YaCB/jTWxHzP7YSAYMvGmaso3aEu+GQ=
Date:   Sat, 12 Sep 2020 15:05:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200912130515.GB3678@zn.tnic>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic>
 <20200911230703.GA2971@nazgul.tnic>
 <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912083739.GA4827@zn.tnic>
 <CY4PR04MB3751C8FA76C49708370E928DE7250@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751C8FA76C49708370E928DE7250@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 12:18:52PM +0000, Damien Le Moal wrote:
> But it was Thunderbird, getting real plain text emails with outlook is
> impossible.

Yeap.

> Corruption I think came from the copy-paste from the Mac bash
> terminal... Tabs get replaced by spacers.

Yeah, never copy-paste hunks. I go "git diff > /tmp/diff" and then load
it into the editor which has the mail opened ":r /tmp/diff" (vim).

> Host-managed is still a thing, getting bigger. But host-aware never really
> gained a lot of traction due to, I think, the potentially very weird performance
> profile they can get into (Hmmm... similar to recent drive-managed noise...)

Yeah, I had the suspicion that it would be some raisins like that.

> No worries, we will fix the mess (sorry we hit you again !).

Yeah, thanks and no probs.

> The patch was space corrupted, but could you still try it ? Did it solve your
> problem ? I can recend it (minus space corruption) if needed.

Yeah, I see

[    3.263400] ata4: SATA max UDMA/133 abar m131072@0xfe380000 port 0xfe380280 irq 45
[    4.943083] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.951590] ata4.00: NCQ Send/Recv Log not supported
[    4.961868] ata4.00: ATA-10: ST8000AS0022-1WL17Z, SN01, max UDMA/133
[    4.977167] ata4.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.987217] ata4.00: NCQ Send/Recv Log not supported
[    5.004230] ata4.00: configured for UDMA/133

but no "sdc" device or a partition or so. So I can't even do fdisk -l on it.

I see your other version - I'll test that later because real life awaits
and it is weekend and so on...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
