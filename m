Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1732A7F66
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgKENDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:03:22 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA3D20735;
        Thu,  5 Nov 2020 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604581401;
        bh=0AXaulBY/90pxUS9mtS7AMho9tYU/Li0HNUEeLEWX2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klbXHrXLpjN5NX5mdMZ5bxcU9bu2eoq30WzZH9JuOXLcfbYLfV4dCCg5oHhIpWN3w
         OY2yxjVk3y7r7xoBAWYT9smUaUNtX4fhV24bZ3kZIQqDJ6Lg0vFwazxUwwRl0CPt/Y
         sfrXNx4/R18Nsbmb3G+0xjwSu8BRlawN5gfh6/tc=
Date:   Thu, 5 Nov 2020 14:04:10 +0100
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
Subject: Re: [PATCH v5 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20201105130410.GA412878@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-7-shuo.a.liu@intel.com>
 <20201104190235.GA2855400@kroah.com>
 <20201105031029.GB17702@shuo-intel.sh.intel.com>
 <20201105062907.GA693781@kroah.com>
 <20201105073545.GD17702@shuo-intel.sh.intel.com>
 <20201105082639.GB3426404@kroah.com>
 <20201105090200.GE17702@shuo-intel.sh.intel.com>
 <20201105091645.GA3436809@kroah.com>
 <20201105124822.GF17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105124822.GF17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 08:48:22PM +0800, Shuo A Liu wrote:
> > > > > Though i can
> > > > > keep some reserved fields for alignment (and to keep same data structure
> > > > > layout with the hypervisor), right?
> > > > > Documentation/driver-api/ioctl.rst says that explicit reserved fields
> > > > > could be used.
> > > >
> > > > If you need alignment, yes, that is fine, but that's not what you are
> > > > saying these are for.  And if you need alignment, why not move things
> > > > around so they are properly aligned.
> > > >
> > > > And this structure has nothing to do with the hypervisor structure,
> > > > that's a internal-kernel structure, not a userspace-visable thing if you
> > > > are doing things correctly.
> > > 
> > > It's the same structure with the one in hypervisor. HSM driver
> > > doesn't maintain the VM much, it just pass the data for VM creation from
> > > userspace to hypervisor.
> > 
> > That sounds ripe for abuse, good luck!
> 
> The hypervisor will do the sanity check. In this case, HSM driver can be
> kept simple.

Hah, good luck with the fuzzers, crashing a hypervisor will be fun for
them!

greg k-h
