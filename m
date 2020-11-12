Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3349F2B08A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgKLPnO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 10:43:14 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:40691 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgKLPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:43:08 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 94DAF20001A;
        Thu, 12 Nov 2020 15:43:02 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:43:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-mtd@lists.infradead.org>, <kbuild-all@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <20201112164301.60032276@xps13>
In-Reply-To: <20201112152739.r4673zyeixkcwukx@mobilestation>
References: <202011021254.XC70BaQT-lkp@intel.com>
        <20201110113827.hl5i27cpl6exo3md@mobilestation>
        <20201110163556.3e3423f6@xps13>
        <20201111192259.ovdyjcuue7fx2bqa@mobilestation>
        <20201112092715.7e466405@xps13>
        <8cdc6166-7183-c8a9-5c27-93a511e6471a@ti.com>
        <20201112152739.r4673zyeixkcwukx@mobilestation>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Thu, 12 Nov
2020 18:27:39 +0300:

> Hello Vignesh
> 
> On Thu, Nov 12, 2020 at 08:30:42PM +0530, Vignesh Raghavendra wrote:
> > 
> > 
> > On 11/12/20 1:57 PM, Miquel Raynal wrote:  
> > > Hi Sergey,
> > > 
> > > Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Wed, 11 Nov
> > > 2020 22:22:59 +0300:
> > >   
> > >> On Tue, Nov 10, 2020 at 04:35:56PM +0100, Miquel Raynal wrote:  
> > >>> Hi Serge,
> > >>>
> > >>> Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Tue, 10 Nov
> > >>> 2020 14:38:27 +0300:
> > >>>     
> > >>>> Hello Miquel,
> > >>>>
> > >>>> A situation noted by the warning below won't cause any problem because
> > >>>> the casting is done to a non-dereferenced variable. It is utilized
> > >>>> as a pointer bias later in that function. Shall we just ignore the
> > >>>> warning or still fix it somehow?    
> > >>>     
> > >>  
> > >>> Do you think the cast to a !__iomem value is mandatory here?    
> > >>
> > >> It's not mandatory to have the casting with no __iomem, but wouldn't
> > >> doing like this:
> > >> + 	shift = (ssize_t __iomem)src & 0x3;
> > >> be looking weird? Really, is there a good way to somehow extract the first
> > >> two bits of a __iomem pointer without getting the sparse warning?  
> > > 
> > > I asked around me, what about trying uintptr_t?
> > >   
> >   
> 
> > One more way is to use __force to tell sparse that this casting is
> > intentional:
> > 
> >        shift = (__force ssize_t)src & 0x3;  
> 
> Oh, great! That solution is actually much better than using some
> currently unexplained sparse peculiarity! I was thinking about applying
> some other attribute, but __force just didn't come to my mind. Thank
> you very much for the suggestion. I'll post the fix with the solution
> suggested by you.

Is the ssize_t cast the right one btw? I would definitely prefer an
unsigned type here.

Thanks,
Miquèl
