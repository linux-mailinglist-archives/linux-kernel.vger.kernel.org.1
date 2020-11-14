Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED82B2D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKNMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgKNMYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:24:50 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03EC420644;
        Sat, 14 Nov 2020 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605356689;
        bh=3BmQ2p970H/UfV9AY1O1bKpiVjudRQsngNx9kM+6lO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saqOi09O7IYUXypCcY3rGuE3MT4gXNHHZpVjvH+j9OQoIU2m8J4kaChHMbAvOZjOf
         3pUz8SB3hFPvAt0MsP5OCNzuetkueGQloDJhtIRPGMPwzZo4bjB1kI1A5w/PC/oUpi
         SJlzPc8K8UdvEziRcUCDwH77W4JQ1y6xE5afdJfU=
Date:   Sat, 14 Nov 2020 13:25:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, zhengjun.xing@intel.com
Subject: Re: [Fonts]  9522750c66:  fio.read_iops 7.5% improvement
Message-ID: <X6/MyFRkEPGqnNtK@kroah.com>
References: <20201112140625.GA21612@xsang-OptiPlex-9020>
 <X64r4X/By+0BTc6a@kroah.com>
 <20201114071916.GA71316@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114071916.GA71316@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 03:19:17PM +0800, Feng Tang wrote:
> Hi Greg,
> 
> On Fri, Nov 13, 2020 at 07:46:57AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Nov 12, 2020 at 10:06:25PM +0800, kernel test robot wrote:
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a 7.5% improvement of fio.read_iops due to commit:
> > > 
> > > 
> > > commit: 9522750c66c689b739e151fcdf895420dc81efc0 ("Fonts: Replace discarded const qualifier")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > I strongly doubt this :)
> 
> We just double checked, the test was run 4 times and the result are
> very stable.
> 
> The commit does looks irrelevant to fio test, and we just further
> checked the System map of the 2 kernels, and many data's alignment
> have been changed (systemmaps attached).
> 
> We have a hack debug patch to make data sections of each .o file to
> be aligned, with that the fio result gap could be reduced from +7.5%
> to +3.8%, so there is still some other factor affecting the benchmark,
> which need more checking. And with the same debug method of forcing
> data sections aligned, 2 other strange performance bumps[1][2] reported
> by 0day could be recovered.
> 
> [1]. https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
> [2]. https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/

That's really odd.  Why wouldn't .o sections be aligned already and how
does that affect the real .ko files that are created from that?  What
alignment are you forcing?

And also, what hardware is seeing this performance gains?  Something is
fitting into a cache now that previously wasn't, and tracking that down
seems like it would be very worthwhile as that is a non-trivial speedup
that some developers take years to achieve with code changes.

thanks,

greg k-h
