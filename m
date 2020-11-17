Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE792B5F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgKQMaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKQMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:30:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:30:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kf07W-0004Xh-UE; Tue, 17 Nov 2020 13:30:02 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kf07V-0005Ms-RP; Tue, 17 Nov 2020 13:30:01 +0100
Date:   Tue, 17 Nov 2020 13:30:01 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, kernel@pengutronix.de,
        Han Xu <han.xu@nxp.com>
Subject: Re: mtd: rawnand: gpmi: regression since
 e5e5631cc88987a6f3cd8304660bd9190da95916
Message-ID: <20201117123001.GE29830@pengutronix.de>
References: <315838324eb25d3a1ab37ee90fa28fa1cdc48cae.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315838324eb25d3a1ab37ee90fa28fa1cdc48cae.camel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:28:49 up 271 days, 19:59, 95 users,  load average: 0.10, 0.21,
 0.25
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:16:26AM +0100, Juergen Borleis wrote:
> Hi,
> 
> reading a NAND page in raw mode is required to check the consistence of the so-
> called FCBs (used to boot the SoC from NAND content).
> 
> Before e5e5631cc88987a6f3cd8304660bd9190da95916 ("mtd: rawnand: gpmi: Use
> nand_extract_bits()") it reads the first page of the NAND correctly as:
> 
> 00000000  00 00 88 fb ff ff 46 43  42 20 00 00 00 01 50 3c  |......FCB ....P<|
> 00000010  19 06 00 00 00 00 00 08  00 00 80 08 00 00 40 00  |..............@.|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 09 00  |................|
> 00000030  00 00 00 02 00 00 00 02  00 00 09 00 00 00 0a 00  |................|
> 00000040  00 00 03 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000060  00 00 00 00 00 00 00 00  00 00 00 01 00 00 80 10  |................|
> 00000070  00 00 55 01 00 00 55 01  00 00 01 00 00 00 9e 07  |..U...U.........|
> 00000080  00 00 02 00 00 00 00 08  00 00 00 00 00 00 00 00  |................|
> 00000090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000200  40 05 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |@...............|
> 00000210  40 01 00 00 00 80 05 00  00 80 05 00 40 01 00 00  |@...........@...|
> 00000220  c0 03 00 00 80 02 00 00  00 00 00 00 00 00 00 00  |................|
> 00000230  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000240  00 00 00 00 00 00 00 00  00 00 00 00 00 00 07 00  |................|
> 00000250  80 83 06 00 00 00 07 00  00 00 07 00 00 07 00 00  |................|
> 00000260  00 42 06 00 80 05 00 00  00 40 06 00 00 00 00 00  |.B.......@......|
> 00000270  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000790  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fc  |................|
> 000007a0  03 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 000007b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000800  ff 00 00 00 00 00 00 00  00 00 00 00 17 15 06 06  |................|
> 00000810  10 1f 03 07 00 00 00 1c  0f 17 1f 05 00 00 00 00  |................|
> 00000820  00 19 00 00 0e 19 00 00  00 00 00 00 00 00 00 00  |................|
> 00000830  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000880
> 
> After applying e5e5631cc88987a6f3cd8304660bd9190da95916 reading the same page
> the reported content is broken (the NAND page still contains correct data):
> 
> 00000000  00 00 88 fb ff ff 46 43  42 20 00 00 00 01 50 3c  |......FCB ....P<|
> 00000010  19 06 00 00 00 00 00 08  00 00 80 08 00 00 40 00  |..............@.|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 09 00  |................|
> 00000030  00 00 00 02 00 00 00 02  00 00 09 00 00 00 0a 00  |................|
> 00000040  40 05 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |@...............|
> 00000050  40 01 00 00 00 80 05 00  00 80 05 00 40 01 00 00  |@...........@...|
> 00000060  c0 03 00 00 80 02 00 00  00 00 00 00 00 00 00 00  |................|
> 00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000250  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fc  |................|
> 00000260  03 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000270  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 000002c0  06 70 c0 a8 00 00 00 00  00 00 00 00 40 00 00 00  |.p..........@...|

Note beginning from offset 0x2c0 we get some uninitialized data. Among
other things we saw systemd unit files there.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
