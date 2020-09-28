Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3A27A6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgI1FXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 01:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1FXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:23:08 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D2F22574;
        Mon, 28 Sep 2020 05:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601270588;
        bh=1tdpaIt0z4UaRHUZek14HBH8QZ9NT08jRxGp/2wDLoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TA1UrKrgv7YGgmGS1KG5Am984JoczA7TWtTFM/PNwYjbXH5784xES8TVo0+YbjZ9X
         WLj5+TQezA8LbWnE8gZ7I0N3HUOSlz3kJNKnTfST1OiYSIWRSzq4UPoYQYupKp7ZOU
         +o1UhsXZI1W6A4kaf3l8eyTgCYBosOySUnxGvefY=
Date:   Mon, 28 Sep 2020 07:23:05 +0200
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
Subject: Re: [PATCH v4 17/17] virt: acrn: Introduce an interface for Service
 VM to control vCPU
Message-ID: <20200928052305.GC767987@kroah.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-18-shuo.a.liu@intel.com>
 <20200927104414.GC88650@kroah.com>
 <20200928041006.GE1057@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928041006.GE1057@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:10:07PM +0800, Shuo A Liu wrote:
> > You just raced with userspace and lost.  If you want to add attribute
> > files to a device, use the default attribute group list, and it will be
> > managed properly for you by the driver core.
> > 
> > Huge hint, if a driver every has to touch a kobject, or call sysfs_*,
> > then it is probably doing something wrong.
> 
> Do you mean use .groups of struct miscdevice directly ?
> 
> If yes, let me follow drivers/char/hw_random/s390-trng.c to do this.
> BTW, few driver use the .groups directly. :)

Drivers should almost never be messing with individual sysfs files.  And
this ability to use .groups is a "new" one, conversions of existing code
that do not use them is always welcome.

thanks,

greg k-h
