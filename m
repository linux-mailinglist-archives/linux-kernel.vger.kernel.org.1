Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA22678E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgILIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgILIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:37:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0BAC061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:37:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1f6200b3d433c484530811.dip0.t-ipconnect.de [IPv6:2003:ec:2f1f:6200:b3d4:33c4:8453:811])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CD5E1EC0347;
        Sat, 12 Sep 2020 10:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599899868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vb1mIz5YnEqMm6NJvAyF7gURzWntu8xRA3o7R8EPRF0=;
        b=k5xvIXPsE5NSlS2oEaZ4EgZIb92vVwlv1ARqElkBX9NF3UeL0Nr4YT7lPmv1UVNWyL1RiY
        rO4QMXDbMCpFxewN2fEVnCL2puqoZopXI4icipRytGaNMK/RKMyhYyb2OYORSrV12ONOuS
        FoFaHNDxCqf5zzbbbtVtdTplMxd1PtU=
Date:   Sat, 12 Sep 2020 10:37:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200912083739.GA4827@zn.tnic>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic>
 <20200911230703.GA2971@nazgul.tnic>
 <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On Sat, Sep 12, 2020 at 02:31:55AM +0000, Damien Le Moal wrote:
> Can you try this:

sure, but it is white-space damaged:

checking file drivers/scsi/sd.c
patch: **** malformed patch at line 86: scsi_disk *sdkp)

Welcome to the world of outlook and how sending patches with it never
works. You guys might need linux.wdc.com now :-)))

> That should fix the above as well as the hang on boot with CONFIG_BLK_DEV_ZONED
> disabled (for that one I do not totally understand what is going on...).
>
> We do not have any host-aware disk for testing (as far as I know, nobody is
> selling these anymore),

Yeah, so Johannes said. I love it how a (relatively) brand new
technology gets immediately deprecated :-\

> so our test setup is a bit lame in this area. We'll rig something up
> with tcmu-runner emulation to add tests for these devices to avoid
> a repeat of such problem. And we'll make sure to add a test for
> host-aware+partitions, since we at least know for sure there is one
> user :)

Bah, I use it as a big data dump so if you say, I should make use of it
as a proper zoned device (I've skimmed through http://zonedstorage.io/ a
bit last night), I can try to find some time...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
