Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D22798EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgIZMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 08:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgIZMqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 08:46:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91AA2080C;
        Sat, 26 Sep 2020 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601124374;
        bh=/uf0nn49RIYSExIaDQdE4XnWSgwXtCxxeYnbdrIvSFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvawAvyfMyMK1UIA8SFafD3JpFuL0Uf9/Ot1gomMG4CiS0kL2Tyiv4ocyStJFt+oh
         pCwWa2Z8wbcl+eEqkTaAny85MA4LTPMaOmi+83LEgT1lOBBIKwNMf732+FCVWrXEje
         oIHr0NLtb8/hULxaJjNIrn5PlypFu5v+i2xiWITc=
Date:   Sat, 26 Sep 2020 14:46:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>, hemantk@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: core: debugfs: Use correct format specifiers
 for addresses
Message-ID: <20200926124626.GB3321471@kroah.com>
References: <20200925171608.30881-1-manivannan.sadhasivam@linaro.org>
 <c63ae2c3-43ae-6a94-cf27-efb6cc038f83@codeaurora.org>
 <20200926052742.GB9302@linux>
 <20200926053914.GA631346@kroah.com>
 <20200926071604.GC9302@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200926071604.GC9302@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 12:46:04PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Sep 26, 2020 at 07:39:14AM +0200, Greg KH wrote:
> > On Sat, Sep 26, 2020 at 10:57:42AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Sep 25, 2020 at 12:01:54PM -0600, Jeffrey Hugo wrote:
> > > > On 9/25/2020 11:16 AM, Manivannan Sadhasivam wrote:
> > > > > For exposing the addresses of read/write pointers and doorbell register,
> > > > > let's use the correct format specifiers. This fixes the following issues
> > > > > generated using W=1 build in ARM32 and reported by Kbuild bot:
> > > > > 
> > > > > All warnings (new ones prefixed by >>):
> > > > > 
> > > > > > > drivers/bus/mhi/core/debugfs.c:75:7: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
> > > > >                                mhi_event->db_cfg.db_val);
> > > > >                                ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > >     drivers/bus/mhi/core/debugfs.c:123:7: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
> > > > >                                mhi_chan->db_cfg.db_val);
> > > > >                                ^~~~~~~~~~~~~~~~~~~~~~~
> > > > >     2 warnings generated.
> > > > > 
> > > > > drivers/bus/mhi/core/debugfs.c: In function ‘mhi_debugfs_events_show’:
> > > > > drivers/bus/mhi/core/debugfs.c:74:51: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > > > >     seq_printf(m, " local rp: 0x%llx db: 0x%pad\n", (u64)ring->rp,
> > > > >                                                     ^
> > > > > drivers/bus/mhi/core/debugfs.c: In function ‘mhi_debugfs_channels_show’:
> > > > > drivers/bus/mhi/core/debugfs.c:122:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > > > >         (u64)ring->rp, (u64)ring->wp,
> > > > >         ^
> > > > > drivers/bus/mhi/core/debugfs.c:122:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > > > >         (u64)ring->rp, (u64)ring->wp,
> > > > >                        ^
> > > > > drivers/bus/mhi/core/debugfs.c:121:62: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘dma_addr_t {aka unsigned int}’ [-Wformat=]
> > > > >     seq_printf(m, " local rp: 0x%llx local wp: 0x%llx db: 0x%llx\n",
> > > > >                                                             ~~~^
> > > > >                                                             %x
> > > > > drivers/bus/mhi/core/debugfs.c:123:7:
> > > > >         mhi_chan->db_cfg.db_val);
> > > > > 
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > > 
> > > > > Greg: This fixes the issue seen while testing the char-misc/char-misc-testing
> > > > > branch.
> > > > > 
> > > > >   drivers/bus/mhi/core/debugfs.c | 10 +++++-----
> > > > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
> > > > > index 53d05a8e168d..2536ff92b76f 100644
> > > > > --- a/drivers/bus/mhi/core/debugfs.c
> > > > > +++ b/drivers/bus/mhi/core/debugfs.c
> > > > > @@ -71,8 +71,8 @@ static int mhi_debugfs_events_show(struct seq_file *m, void *d)
> > > > >   		seq_printf(m, " rp: 0x%llx wp: 0x%llx", er_ctxt->rp,
> > > > >   			   er_ctxt->wp);
> > > > > -		seq_printf(m, " local rp: 0x%llx db: 0x%llx\n", (u64)ring->rp,
> > > > > -			   mhi_event->db_cfg.db_val);
> > > > > +		seq_printf(m, " local rp: 0x%px db: 0x%pad\n", ring->rp,
> > > > > +			   &mhi_event->db_cfg.db_val);
> > > > >   	}
> > > > >   	return 0;
> > > > > @@ -118,9 +118,9 @@ static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
> > > > >   		seq_printf(m, " base: 0x%llx len: 0x%llx wp: 0x%llx",
> > > > >   			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->wp);
> > > > > -		seq_printf(m, " local rp: 0x%llx local wp: 0x%llx db: 0x%llx\n",
> > > > > -			   (u64)ring->rp, (u64)ring->wp,
> > > > > -			   mhi_chan->db_cfg.db_val);
> > > > > +		seq_printf(m, " local rp: 0x%px local wp: 0x%px db: 0x%pad\n",
> > > > > +			   ring->rp, ring->wp,
> > > > > +			   &mhi_chan->db_cfg.db_val);
> > > > >   	}
> > > > >   	return 0;
> > > > > 
> > > > 
> > > > Documentation/printk-formats.txt seems to point out that %px is "insecure"
> > > > and thus perhaps not preferred.  Are we assuming that debugfs is only
> > > > accessible by root, and thus the %px usage here is effectively the same as
> > > > %pK?
> > > > 
> > > 
> > > No, this debugfs entry can be read by non-root users also.
> > 
> > How, the mount point of debugfs is restricted to root only :)
> > 
> 
> Sigh... I just went with the file permission of 444 :/
> 
> > > But the idea here
> > > is to effectively show the addresses to everyone so I don't think we need to
> > > hide it. The term "insecure" applies to kernel log where exposing the address
> > > doesn't make much sense (except for few obvious reasons).
> > 
> > Why does normal users need to see a kernel address?  What can they do
> > with this?  Why can't we use the "normal" hashed way of showing a kernel
> > address instead?
> > 
> 
> It was the original implementation and as you brushed my memory, only root can
> mount and read the content, so why we should hide?

Why shouldn't you?  It's good to have defense in depth, userspace should
not care about a real kernel pointer value, right?  THat's why we have
the hashed number instead, please use that.

thanks,

greg k-h
