Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816C527B282
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgI1Qse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:48:34 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:48422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgI1Qru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:47:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B9179181D303A;
        Mon, 28 Sep 2020 16:47:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:967:968:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2689:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4384:4605:5007:6117:6119:7522:7808:7903:9025:9388:10004:10400:10848:11026:11232:11257:11473:11658:11914:12296:12297:12438:12679:12740:12760:12895:13071:13255:13439:14180:14181:14659:14721:21060:21080:21220:21324:21394:21433:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: arch33_3216d3d27183
X-Filterd-Recvd-Size: 3948
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Sep 2020 16:47:47 +0000 (UTC)
Message-ID: <8cf2fad1659acd756703deb106d55483bd1e1eb9.camel@perches.com>
Subject: Re: [PATCH 03/18] [ARM] pata_icside: use semicolons rather than
 commas to separate statements
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Sep 2020 09:47:45 -0700
In-Reply-To: <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
         <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-27 at 21:12 +0200, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

Hi Julia.

How did you decide on this patch subject header line?

It's certainly reasonable, but not what I would expect
from any automation.

A somewhat common method of finding the most commonly used
"git log" subject line doesn't easily provide a similar heading.

$ git log --no-merges --format='%s' drivers/ata/pata_icside.c
treewide: Add SPDX license identifier for more missed files
libata: remove ata_sff_data_xfer_noirq()
scsi: rename SCSI_MAX_{SG, SG_CHAIN}_SEGMENTS
Drivers: ata: remove __dev* attributes.
ata: Convert ata_<foo>_printk(KERN_<LEVEL> to ata_<foo>_<level>
libata-sff: separate out BMDMA irq handler
libata-sff: separate out BMDMA EH
libata-sff: clean up BMDMA initialization
libata-sff: clean up inheritance in several drivers
include cleanup: Update gfp.h and slab.h includes to prepare for breaking implicit slab.h inclusion from percpu.h
[libata] convert drivers to use ata.h mode mask defines
[ARM] dma: Use sensible DMA parameters for Acorn drivers
[ARM] dma: pata_icside's contiguous sg array is now redundant
libata-sff: Fix oops reported in kerneloops.org for pnp devices with no ctl
libata: rename SFF port ops
libata: rename SFF functions
libata: make reset related methods proper port operations
libata: implement and use ops inheritance
libata: implement and use SHT initializers
libata: implement and use ata_noop_irq_clear()
libata: eliminate the home grown dma padding in favour of
libata: convert to chained sg
Fix pata_icside build for recent libata API changes
libata: implement and use ata_port_desc() to report port configuration
[libata] Remove ->port_disable() hook
[libata] Remove ->irq_ack() hook, and ata_dummy_irq_on()
[ARM] pata_icside: fix the FIXMEs
[libata] PATA drivers: remove ATA_FLAG_SRST
[ARM] pata_icside: fix build errors
[ARM] ecard: add ecardm_iomap() / ecardm_iounmap()
[ARM] ecard: add helper function for setting ecard irq ops
[ARM] Add support for ICSIDE interface on RiscPC

$ git log --no-merges --format='%s' drivers/ata/pata_icside.c | \
  cut -f1 -d":" | sort | uniq -c | sort -rn
     10 libata
      5 libata-sff
      2 [ARM] pata_icside
      2 [ARM] ecard
      2 [ARM] dma
      1 treewide
      1 scsi
      1 [libata] Remove ->port_disable() hook
      1 [libata] Remove ->irq_ack() hook, and ata_dummy_irq_on()
      1 [libata] PATA drivers
      1 [libata] convert drivers to use ata.h mode mask defines
      1 include cleanup
      1 Fix pata_icside build for recent libata API changes
      1 Drivers
      1 ata
      1 [ARM] Add support for ICSIDE interface on RiscPC


