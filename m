Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CFA2A3FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKCJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:23:23 -0500
Received: from verein.lst.de ([213.95.11.211]:36423 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgKCJXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:23:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D53A768B02; Tue,  3 Nov 2020 10:23:18 +0100 (CET)
Date:   Tue, 3 Nov 2020 10:23:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Gloria Tsai <Gloria.Tsai@ssstc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jongpil Jung <jongpuls@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
        "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
        "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201103092318.GA16071@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U> <20201029145529.GA19011@lst.de> <20201102181327.GD20182@lst.de> <HK2PR02MB4004EE20977D0B14516B030AEE110@HK2PR02MB4004.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR02MB4004EE20977D0B14516B030AEE110@HK2PR02MB4004.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:21:16AM +0000, Gloria Tsai wrote:
> When host issue shutdown + D3hot in suspend, NVMe drive might have
> chance choosing wrong pointer which has already been used by GC then
> cause over program.
> Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on device SRAM -> over program

Aka there is data corruption?

> The issue only happens in simple suspend (shutdown+D3hot) with specific FW on Kahoku board.

Kahoku is a specific LiteOn controller?  Or it is the host system?

Maybe main issue with this patch is that it mixes up two axis:

 - use power states for suspend despite HMB on specific host systems
   identified by the DMI ids.  This kinda makes sense to me, as
   the power state based suspends has lots of advantages, so having
   a whitelist when to use it seem ok, despite the clutter that this
   causes.
 - then tie this to specific NVMe devices that don't work without this
   quirk, which leaves open the issue what we do when we encounter such
   a device in a different host system.  If shutdown + D3hot causes
   problems there is seems like for the case where the above quirk doesn't
   apply we should just skip the shutdown and let the D3hot do a surprise
   power removal?  That's mean recovery when coming back from the suspend,
   but would cause less corruption?

In other words I think this needs to be two patches:

 1) quirk based on the DMI table and allow power state based
    suspend on given host systems even when a HMB is enabled
 2) quirk based on the nvme device (and if possible use the PCI IDs)
    to disable shutdown before suspend (possibly with a warning printk
    when this happens)
