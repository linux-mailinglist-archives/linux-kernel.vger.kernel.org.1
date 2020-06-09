Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CD61F39C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 13:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFILba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 07:31:30 -0400
Received: from verein.lst.de ([213.95.11.211]:41974 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFILb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:31:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E3C5D68B02; Tue,  9 Jun 2020 13:31:23 +0200 (CEST)
Date:   Tue, 9 Jun 2020 13:31:23 +0200
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
Message-ID: <20200609113123.GA547@lst.de>
References: <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost> <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com> <20200609054306.GA9606@lst.de> <s5hsgf4irzt.wl-tiwai@suse.de> <20200609084305.GA21671@lst.de> <s5hlfkwip1h.wl-tiwai@suse.de> <20200609091727.GA23814@lst.de> <s5hh7vkio0n.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7vkio0n.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:31:20AM +0200, Takashi Iwai wrote:
> > > How would be a proper way to get the virtually mapped SG-buffer pages
> > > with coherent memory?  (Also allowing user-space mmap, too)
> > 
> > dma_mmap_coherent / dma_mmap_attrs for userspace.  We don't really
> > have a good way for kernel space mappings.
> 
> And that's the missing piece right now...  :-<

Can you point me to the relevant places (allocation and vmap mostly)
so that I can take a look at how to fix this mess?
