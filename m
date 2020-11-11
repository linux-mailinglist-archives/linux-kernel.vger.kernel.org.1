Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640CD2AF8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgKKTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:23:14 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:43288 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgKKTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:23:13 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 75377803071C;
        Wed, 11 Nov 2020 19:23:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 79_EhWoZh6MA; Wed, 11 Nov 2020 22:23:01 +0300 (MSK)
Date:   Wed, 11 Nov 2020 22:22:59 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <20201111192259.ovdyjcuue7fx2bqa@mobilestation>
References: <202011021254.XC70BaQT-lkp@intel.com>
 <20201110113827.hl5i27cpl6exo3md@mobilestation>
 <20201110163556.3e3423f6@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110163556.3e3423f6@xps13>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 04:35:56PM +0100, Miquel Raynal wrote:
> Hi Serge,
> 
> Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Tue, 10 Nov
> 2020 14:38:27 +0300:
> 
> > Hello Miquel,
> > 
> > A situation noted by the warning below won't cause any problem because
> > the casting is done to a non-dereferenced variable. It is utilized
> > as a pointer bias later in that function. Shall we just ignore the
> > warning or still fix it somehow?
> 

> Do you think the cast to a !__iomem value is mandatory here?

It's not mandatory to have the casting with no __iomem, but wouldn't
doing like this:
+ 	shift = (ssize_t __iomem)src & 0x3;
be looking weird? Really, is there a good way to somehow extract the first
two bits of a __iomem pointer without getting the sparse warning?

-Sergey

> 
> Perhaps if you find an elegant wait to avoid the warning it would be
> nice, otherwise I guess we'll let it aside as a false positive.
> 
> Cheers,
> Miquèl
