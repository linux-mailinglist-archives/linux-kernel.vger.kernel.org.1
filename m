Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBE27AFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1OXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:23:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:42270 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgI1OXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:23:05 -0400
IronPort-SDR: wGEzRi1fMh39GIt3WIW6Pr7Z4lzVW7ypVEINpU9r/GXZhG9M6jsm2xcabLP9pRKpiDCykZ/8kb
 fnYileett1qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159380168"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159380168"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:09:57 -0700
IronPort-SDR: YHKFCeCMdY+V43id/m9w5v+iLoHJB+6rsO9/fuI+9KrFSlgtL8srMAz2VH3zvDGshvmrjsrV+h
 IF8kcM28ZpTw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="514269821"
Received: from schuethe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.34.214])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:09:54 -0700
Date:   Mon, 28 Sep 2020 17:09:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, Peter Huewe <peterhuewe@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
Message-ID: <20200928140955.GA70098@linux.intel.com>
References: <20200922094128.26245-1-ardb@kernel.org>
 <20200925055626.GC165011@linux.intel.com>
 <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
 <20200925102920.GA180915@linux.intel.com>
 <20200925120018.GH9916@ziepe.ca>
 <20200927234434.GA5283@linux.intel.com>
 <9be9c7e7-c424-d241-2255-ad854221bd2e@csgroup.eu>
 <CAMj1kXGxNgixUEocma-9F3fYgdJJJADh=bvyrCziXkuArErWdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGxNgixUEocma-9F3fYgdJJJADh=bvyrCziXkuArErWdA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 08:20:18AM +0200, Ard Biesheuvel wrote:
> On Mon, 28 Sep 2020 at 07:56, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 28/09/2020 � 01:44, Jarkko Sakkinen a �crit :
> > > On Fri, Sep 25, 2020 at 09:00:18AM -0300, Jason Gunthorpe wrote:
> > >> On Fri, Sep 25, 2020 at 01:29:20PM +0300, Jarkko Sakkinen wrote:
> > >>> On Fri, Sep 25, 2020 at 09:00:56AM +0200, Ard Biesheuvel wrote:
> > >>>> On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
> > >>>> <jarkko.sakkinen@linux.intel.com> wrote:
> > >>>>>
> > >>>>> On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> > >>>>>> The TPM event log is provided to the OS by the firmware, by loading
> > >>>>>> it into an area in memory and passing the physical address via a node
> > >>>>>> in the device tree.
> > >>>>>>
> > >>>>>> Currently, we use __va() to access the memory via the kernel's linear
> > >>>>>> map: however, it is not guaranteed that the linear map covers this
> > >>>>>> particular address, as we may be running under HIGHMEM on a 32-bit
> > >>>>>> architecture, or running firmware that uses a memory type for the
> > >>>>>> event log that is omitted from the linear map (such as EfiReserved).
> > >>>>>
> > >>>>> Makes perfect sense to the level that I wonder if this should have a
> > >>>>> fixes tag and/or needs to be backported to the stable kernels?
> > >>>>>
> > >>>>
> > >>>> AIUI, the code was written specifically for ppc64, which is a
> > >>>> non-highmem, non-EFI architecture. However, when we start reusing this
> > >>>> driver for ARM, this issue could pop up.
> > >>>>
> > >>>> The code itself has been refactored a couple of times, so I think it
> > >>>> will require different versions of the patch for different generations
> > >>>> of stable kernels.
> > >>>>
> > >>>> So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see how
> > >>>> far back it applies cleanly?
> > >>>
> > >>> Yeah, I think I'll cc it with some note before the diffstat.
> > >>>
> > >>> I'm thinking to cap it to only 5.x kernels (at least first) unless it is
> > >>> dead easy to backport below that.
> > >>
> > >> I have this vauge recollection of pointing at this before and being
> > >> told that it had to be __va for some PPC reason?
> > >>
> > >> Do check with the PPC people first, I see none on the CC list.
> > >>
> > >> Jason
> > >
> > > Thanks, added arch/powerpc maintainers.
> > >
> >
> > As far as I can see, memremap() won't work on PPC32 at least:
> >
> > IIUC, memremap() calls arch_memremap_wb()
> > arch_memremap_wb() calls ioremap_cache()
> > In case of failure, then ioremap_wt() and ioremap_wc() are tried.
> >
> > All ioremap calls end up in __ioremap_caller() which will return NULL in case you try to ioremap RAM.
> >
> > So the statement "So instead, use memremap(), which will reuse the linear mapping if
> > it is valid, or create another mapping otherwise." seems to be wrong, at least for PPC32.
> >
> > Even for PPC64 which doesn't seem to have the RAM check, I can't see that it will "reuse the linear
> > mapping".
> >
> 
> It is there, please look again. Before any of the above happens,
> memremap() will call try_ram_remap() for regions that are covered by a
> IORESOURCE_SYSTEM_RAM, and map it using __va() if its PFN is valid and
> it is not highmem.
> 
> So as far as I can tell, this change has no effect on PPC at all
> unless its RAM is not described as IORESOURCE_SYSTEM_RAM.

Any chance for someone to test this on PPC32?

/Jarkko
