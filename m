Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522842B9F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKTBT7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 20:19:59 -0500
Received: from twhmllg4.macronix.com ([122.147.135.202]:41921 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKTBT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:19:59 -0500
Received: from TWHMLLG4.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG4.macronix.com with ESMTP id 0AK1BLtT017244
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:11:21 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 0AK1Aeb6016744;
        Fri, 20 Nov 2020 09:10:40 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id C63533B68BD7F94D29D7;
        Fri, 20 Nov 2020 09:10:40 +0800 (CST)
In-Reply-To: <20201119221558.7b484949@xps13>
References: <1604490442-9052-1-git-send-email-ycllin@mxic.com.tw>       <20201119211133.31590-1-miquel.raynal@bootlin.com> <20201119221558.7b484949@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com
Subject: =?Big5?B?pl6rSDogUmU6IFtQQVRDSF0gbXRkOiBzcGluYW5kOiBtYWNyb25peDogQWRk?=
 =?Big5?B?IHN1cHBvcnQgZm9yIE1YMzVMRnhHRTRBRA==?=
MIME-Version: 1.0
X-KeepSent: 13142059:F2BB13E4-48258626:00062B35;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF13142059.F2BB13E4-ON48258626.00062B35-48258626.00067881@mxic.com.tw>
From:   ycllin@mxic.com.tw
Date:   Fri, 20 Nov 2020 09:10:40 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/11/20 AM 09:10:40,
        Serialize complete at 2020/11/20 AM 09:10:40
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 0AK1Aeb6016744
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 19 Nov 2020
> 22:11:33 +0100:
> 
> > On Wed, 2020-11-04 at 11:47:22 UTC, YouChing Lin wrote:
> > > The Macronix MX35LF2GE4AD / MX35LF4GE4AD are 3V, 2G / 4Gbit serial
> > > SLC NAND flash device (with on-die ECC).
> > > 
> > > Validated by read, erase, read back, write, read back and nandtest
> > > on Xilinx Zynq PicoZed FPGA board which included Macronix SPI Host
> > > (drivers/spi/spi-mxic.c).
> > > 
> > > Signed-off-by: YouChing Lin <ycllin@mxic.com.tw> 
> > 
> > Applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
> nand/next, thanks.
> 
> Please use "v2" as prefix next time you change something in your patch
> instead of "RESEND", it confuses me. I applied the wrong patch, I will
> drop this one and take the "RESEND, v1" instead.
 
  OK, I got it, sorry for the mistake!

  Thanks for your time.

  YouChing.

> 
> Thanks,
> Miquèl


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

