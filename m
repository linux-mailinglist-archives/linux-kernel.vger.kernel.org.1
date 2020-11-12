Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881B62B0862
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgKLP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:27:43 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:48262 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgKLP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:27:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 417D3803017D;
        Thu, 12 Nov 2020 15:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IeRGtuy7iSgB; Thu, 12 Nov 2020 18:27:40 +0300 (MSK)
Date:   Thu, 12 Nov 2020 18:27:39 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>, <kbuild-all@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <20201112152739.r4673zyeixkcwukx@mobilestation>
References: <202011021254.XC70BaQT-lkp@intel.com>
 <20201110113827.hl5i27cpl6exo3md@mobilestation>
 <20201110163556.3e3423f6@xps13>
 <20201111192259.ovdyjcuue7fx2bqa@mobilestation>
 <20201112092715.7e466405@xps13>
 <8cdc6166-7183-c8a9-5c27-93a511e6471a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cdc6166-7183-c8a9-5c27-93a511e6471a@ti.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vignesh

On Thu, Nov 12, 2020 at 08:30:42PM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 11/12/20 1:57 PM, Miquel Raynal wrote:
> > Hi Sergey,
> > 
> > Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Wed, 11 Nov
> > 2020 22:22:59 +0300:
> > 
> >> On Tue, Nov 10, 2020 at 04:35:56PM +0100, Miquel Raynal wrote:
> >>> Hi Serge,
> >>>
> >>> Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Tue, 10 Nov
> >>> 2020 14:38:27 +0300:
> >>>   
> >>>> Hello Miquel,
> >>>>
> >>>> A situation noted by the warning below won't cause any problem because
> >>>> the casting is done to a non-dereferenced variable. It is utilized
> >>>> as a pointer bias later in that function. Shall we just ignore the
> >>>> warning or still fix it somehow?  
> >>>   
> >>
> >>> Do you think the cast to a !__iomem value is mandatory here?  
> >>
> >> It's not mandatory to have the casting with no __iomem, but wouldn't
> >> doing like this:
> >> + 	shift = (ssize_t __iomem)src & 0x3;
> >> be looking weird? Really, is there a good way to somehow extract the first
> >> two bits of a __iomem pointer without getting the sparse warning?
> > 
> > I asked around me, what about trying uintptr_t?
> > 
> 

> One more way is to use __force to tell sparse that this casting is
> intentional:
> 
>        shift = (__force ssize_t)src & 0x3;

Oh, great! That solution is actually much better than using some
currently unexplained sparse peculiarity! I was thinking about applying
some other attribute, but __force just didn't come to my mind. Thank
you very much for the suggestion. I'll post the fix with the solution
suggested by you.

-Sergey

> 
> 
> > Thanks,
> > Miquèl
> > 
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> > 
