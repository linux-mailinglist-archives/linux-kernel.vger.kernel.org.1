Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C051D2DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 13:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENLOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 07:14:46 -0400
Received: from verein.lst.de ([213.95.11.211]:51366 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENLOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:14:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 951B268BEB; Thu, 14 May 2020 13:14:42 +0200 (CEST)
Date:   Thu, 14 May 2020 13:14:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was
 Re: WARNING in memtype_reserve)
Message-ID: <20200514111442.GA13813@lst.de>
References: <000000000000f0d8d205a531f1a3@google.com> <20200509074507.GC1831917@kroah.com> <87wo5l4ecm.fsf@nanos.tec.linutronix.de> <20200513124445.GA1082735@kroah.com> <87zhab249p.fsf@nanos.tec.linutronix.de> <20200514035458.14760-1-hdanton@sina.com> <20200514061417.GA8367@lst.de> <20200514062750.GA1488715@kroah.com> <20200514063158.GA8780@lst.de> <8bdb3488-59d0-67ce-4822-e25dbd0dc42a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bdb3488-59d0-67ce-4822-e25dbd0dc42a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 06:10:03AM -0500, Jeremy Linton wrote:
>> I only need to look at the commit for 3 seconds to tell you that it is
>> completely buggy.  While using dma_mmap_coherent is fundamentally the
>> right thing and absolutely required for dma_alloc_* allocations, USB
>> also uses it's own local gen pool allocator or plain kmalloc for not
>> DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
>> sure you hit one of those cases.
>
> ? The code path in question is usbdev_mmap() and the allocation is done ~13 
> lines lines before as a usb_alloc_coherent().

And did you take a look at how usb_alloc_coherent is implemented?  That
should make it completely obvious that not all allocations come
from dma_alloc_*.

> That sort of makes sense, except for the above, and the fact that I would 
> imagine the dma_mmap_coherent should be dealing with that case. I'm not 
> really clear about the details of the GCE usb device here, but my first 
> guess at this was the dma_pgprot() in dma_direct_mmap() is incorrectly 
> picking a pgprot...

No, dma_mmap_* / dma_direct_mmap has absolutely no business dealing
with memory that did not come from the DMA allocator.
