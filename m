Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235A2FA7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407221AbhARRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407154AbhARRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:38:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 446E1223E8;
        Mon, 18 Jan 2021 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610991424;
        bh=bvqqgkmFm3rdSY0WYtfXdrX5syoNxA/lRBODaxHFdA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNjUdsAH/RmPHlzwkm0jOtNsZuDRO9qO8liR7juCrVZd/8WCzwmTfnjRo3TuLFu6+
         e+9AXAZzDX5QBKI/KV8qOyebh1UW10KkeVrGKE2acv0SBQ6+O2LzzGcgFXzyg+6oS7
         xbAXBvXrm393GkG9isrSKFLIt5OiQkzOEMgjpcfI=
Date:   Mon, 18 Jan 2021 18:37:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Al Cooper <alcooperx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: bdc: Remove the BDC PCI driver
Message-ID: <YAXHPk+kAGY45cgN@kroah.com>
References: <20210115213142.35003-1-alcooperx@gmail.com>
 <878s8qwkgz.fsf@kernel.org>
 <YAVy3KKu7n522aUU@kroah.com>
 <87wnwav3hi.fsf@kernel.org>
 <CAMeQTsbQcbrBMvh2uzPjCJ1bMDQtZTEUMJ9Y9mhmGTnxhN-3+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeQTsbQcbrBMvh2uzPjCJ1bMDQtZTEUMJ9Y9mhmGTnxhN-3+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 01:54:16PM +0100, Patrik Jakobsson wrote:
> On Mon, Jan 18, 2021 at 1:22 PM Felipe Balbi <balbi@kernel.org> wrote:
> >
> >
> > Hi,
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > >> Al Cooper <alcooperx@gmail.com> writes:
> > >> > The BDC PCI driver was only used for design verification with
> > >> > an PCI/FPGA board. The board no longer exists and is not in use
> > >> > anywhere. All instances of this core now exist as a memory mapped
> > >> > device on the platform bus.
> > >> >
> > >> > NOTE: This only removes the PCI driver and does not remove the
> > >> > platform driver.
> > >> >
> > >> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > >>
> > >> It sounds like it could be used for pre-silicon verification of newer
> > >> Core Releases, much like Synopsys still uses the HAPS (with mainline
> > >> linux, mind you) for silicon validation.
> > >>
> > >> Why would we delete this small shim if it *could* still be useful?
> > >
> > > It ends up conflicting with the PCI id of a device that is actually in
> > > the wild (a camera on Apple laptops).  So it's good to drop this driver
> > > so the wrong driver doesn't get constantly bound to the wrong device.
> >
> > I see. Oh well...
> 
> It would also help if this got disabled in stable so existing kernels
> stop loading bdc.
> 
> Can this patch go directly into stable or should I send a patch that
> adds "depends on BROKEN"?

A patch for that, that I can take now for 5.11-final and backport to
stable kernels would be fine.

thanks,

greg k-h
