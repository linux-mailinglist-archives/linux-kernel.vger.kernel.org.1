Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F527A6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1FZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 01:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1FZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:25:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9064C22574;
        Mon, 28 Sep 2020 05:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601270720;
        bh=wBja5Fw4x4UnSssX+xKch7t0labtipJpxl4uYrmPQ2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFNeUYsU7v1joVB01Z40TosTQv5FHITHYf85PAynGj3wi/Tr3k72e2H/y+plnY12p
         9hsNE5kQxc94D9VGjSk79QWumWRpxwBr/nwCg8KpeiQkglfOOyRtEfGCCdCuHO72eS
         GFuRLl3uAzU0V+w4zsYg1o6SPpp9dQeXsEm7T2gM=
Date:   Mon, 28 Sep 2020 07:25:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200928052516.GD767987@kroah.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-7-shuo.a.liu@intel.com>
 <20200927104702.GE88650@kroah.com>
 <20200928035030.GD1057@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928035030.GD1057@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:50:30AM +0800, Shuo A Liu wrote:
> > > +	write_lock_bh(&acrn_vm_list_lock);
> > > +	list_add(&vm->list, &acrn_vm_list);
> > > +	write_unlock_bh(&acrn_vm_list_lock);
> > 
> > Why are the _bh() variants being used here?
> > 
> > You are only accessing this list from userspace context in this patch.
> > 
> > Heck, you aren't even reading from the list, only writing to it...
> 
> acrn_vm_list is read in a tasklet which dispatch I/O requests and is wrote
> in VM creation ioctl. Use the rwlock mechanism to protect it.
> The reading operation is introduced in the following patches of this
> series. So i keep the lock type at the moment of introduction.

Ok, but think about someone trying to review this code.  Does this lock
actually make sense here?  No, it does not.  How am I supposed to know
to look at future patches to determine that it changes location and
usage to require this?

That's just not fair, would you want to review something like this?

And a HUGE meta-comment, again, why am I the only one reviewing this
stuff?  Why do you have a ton of Intel people on the Cc: yet it is, once
again, my job to do this?

If you all are wanting to burn me out, you are doing a good job...

greg k-h
