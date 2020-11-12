Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4104A2B0131
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKLI1W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 03:27:22 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38055 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:27:22 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C3B37FF812;
        Thu, 12 Nov 2020 08:27:16 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:27:15 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <20201112092715.7e466405@xps13>
In-Reply-To: <20201111192259.ovdyjcuue7fx2bqa@mobilestation>
References: <202011021254.XC70BaQT-lkp@intel.com>
        <20201110113827.hl5i27cpl6exo3md@mobilestation>
        <20201110163556.3e3423f6@xps13>
        <20201111192259.ovdyjcuue7fx2bqa@mobilestation>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Wed, 11 Nov
2020 22:22:59 +0300:

> On Tue, Nov 10, 2020 at 04:35:56PM +0100, Miquel Raynal wrote:
> > Hi Serge,
> > 
> > Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Tue, 10 Nov
> > 2020 14:38:27 +0300:
> >   
> > > Hello Miquel,
> > > 
> > > A situation noted by the warning below won't cause any problem because
> > > the casting is done to a non-dereferenced variable. It is utilized
> > > as a pointer bias later in that function. Shall we just ignore the
> > > warning or still fix it somehow?  
> >   
> 
> > Do you think the cast to a !__iomem value is mandatory here?  
> 
> It's not mandatory to have the casting with no __iomem, but wouldn't
> doing like this:
> + 	shift = (ssize_t __iomem)src & 0x3;
> be looking weird? Really, is there a good way to somehow extract the first
> two bits of a __iomem pointer without getting the sparse warning?

I asked around me, what about trying uintptr_t?

Thanks,
Miquèl
