Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9A1F3641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 10:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgFIInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 04:43:10 -0400
Received: from verein.lst.de ([213.95.11.211]:41334 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgFIInK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:43:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D38BC68AFE; Tue,  9 Jun 2020 10:43:05 +0200 (CEST)
Date:   Tue, 9 Jun 2020 10:43:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Rientjes <rientjes@google.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200609084305.GA21671@lst.de>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost> <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com> <20200609054306.GA9606@lst.de> <s5hsgf4irzt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsgf4irzt.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:05:26AM +0200, Takashi Iwai wrote:
> > >From the disassembly it seems like a vmalloc allocation is NULL, which
> > seems really weird as this patch shouldn't make a difference for them,
> > and I also only see a single places that allocates the field, and that
> > checks for an allocation failure.  But the sound code is a little
> > hard to unwind sometimes.
> 
> It's not clear which sound device being affected, but if it's
> HD-audio on x86, runtime->dma_area points to a vmapped buffer from
> SG-pages allocated by dma_alloc_coherent().
> 
> OTOH, if it's a USB-audio, runtime->dma_area is a buffer by
> vmalloc().

Err, you can't just vmap a buffer returned from dma_alloc_coherent,
dma_alloc_coherent returns values are opaque and can't be used
for virt_to_page.  Whatever that code did has already been broken
per the DMA API contract and on many architectures and just happend
to work on x86 by accident.
