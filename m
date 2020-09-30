Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB71127EED2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgI3QS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:18:56 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:60320 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727426AbgI3QSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:18:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A26AD41304;
        Wed, 30 Sep 2020 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1601482732; x=1603297133; bh=BaLuW/JZFO3VU5hu0YrWImsNB
        z/UdPmOUw6h808shmY=; b=TnVKoem5KMWup9u/DFo59aZHTADOJgEfWYHjbVLkB
        uPgYKjMYPq99Uix48euP14d4ZYek0j0NccsIE/8ESKz2AicikRCrr48v4OcxmhS1
        N6ipQbPmnZJvy4glp1rrFJA6G/O4kVo2+ivkxAeq6x0V5BIjyPwDb2BAMETQrLw+
        Ro=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xz0a6kCL6vTL; Wed, 30 Sep 2020 19:18:52 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 79A3C4125E;
        Wed, 30 Sep 2020 19:18:51 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.78) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 30
 Sep 2020 19:18:50 +0300
Message-ID: <ff66efae07b4b97ac5f891e6b37c348105dc17db.camel@yadro.com>
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: do not touch TB bit without
 SPI_NOR_HAS_TB
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Sep 2020 19:22:45 +0300
In-Reply-To: <758b2772-3c44-1184-066e-df890d05a21a@ti.com>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
         <20200921112450.4824-2-i.mikhaylov@yadro.com>
         <9bfb10df-64d8-4a5e-b0ad-a8b5f4efc56f@ti.com>
         <4a5945534f7b41cb799c044ec8c9d31c61d5beda.camel@yadro.com>
         <758b2772-3c44-1184-066e-df890d05a21a@ti.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.2.78]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 19:30 +0530, Vignesh Raghavendra wrote:
> 
> On 9/30/20 6:37 PM, Ivan Mikhaylov wrote:
> > On Wed, 2020-09-30 at 15:06 +0530, Vignesh Raghavendra wrote:
> > > On 9/21/20 4:54 PM, Ivan Mikhaylov wrote:
> > > > Some chips like macronix don't have TB(Top/Bottom protection)
> > > > bit in the status register. Do not write tb_mask inside status
> > > > register, unless SPI_NOR_HAS_TB is present for the chip.
> > > > 
> > > 
> > > Not entirely accurate.. Macronix chips have TB bit in config register
> > > and is OTP and hence should not be touched ideally...
> > > 
> > > You still need to "read" that bit to determine actual scheme (Top vs
> > > Bottom). This is needs to be done before 2/2 enables SPI_NOR_HAS_LOCK
> > > flag for macronix flashes.
> > 
> > Vignesh, that's the point about this commit to generalize this part about TB
> > bit
> > plus there is already exist SPI_NOR_HAS_TB flag which representing state of
> > TB
> > existence. I didn't add any support for macronix's TB bit, that's true but
> > that's enough to make macronix chips able to use lock mechanism with default
> > 'use_top' or any other chips which doesn't have TB bit.
> 
> Right, but 2/2 "enables" locking mechanism for Macronix flashes. Therefore
> its 
> necessary to take TB bit into account so that implementation is correct. 
> What if OTP bit is set as "use_bottom"? Although this is non default, 
> we need to take care of this case for correctness.

Maybe wording of my commit message is incorrect, let's try to think about this
commit without macronix words in it. What do you think? Just additional patch
for control TB writes.

mtd: spi-nor: do not touch TB bit without SPI_NOR_HAS_TB
    
Do not write tb_mask inside status register, unless SPI_NOR_HAS_TB is   		
present for the chip.

If we talking from OTP point for Macronix then in this case better way to make
lock/unlock inside macronix.c which brings a lot of copypaste. I'll try to
rework it.

> > > I guess macronix does not support SR_SRWD right? This needs special
> > > treatment as well.
> > 
> > It does support SR_SRWD as well. No need any special treatment here.
> > 
> 
> I did not find it in one Macronix datasheet at least:
> https://www.macronix.com/Lists/Datasheet/Attachments/7902/MX25L25673G,%203V,%20256Mb,%20v1.6.pdf
> 
> Are you sure all Macronix flashes support SRWD?
> 

No, I'm not sure, I did it more than month ago and I've checked BP0-X bits +
SRWD bits in the documentation at this time for whole set of chips in
macronix.c. This one (mx25l25673g) not even listed in macronix.c. Also SRWD was
present there until 1.3 rev for this chip from documentation.

I've noticed one thing also:

	{ "mx25l51245g", INFO(0xc2201a, 0, 64 * 1024, 1024,
			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
			      SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
			      SPI_NOR_4BIT_BP) },
	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
			      SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
			      SPI_NOR_4BIT_BP) },

mx25l51245g and mx66l51235l have same id and different flags(SECT_4K).
As example if you have mx66l51235l, driver will take mx25l51245g because it
comes first in the chip list. I don't think that's right but I didn't find
information how to distinguish them.

Thanks.

