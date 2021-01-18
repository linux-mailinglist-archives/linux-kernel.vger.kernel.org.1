Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA082F9F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391340AbhARMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403775AbhARL4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:56:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AC25222BB;
        Mon, 18 Jan 2021 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610970943;
        bh=MCZMe+96VzwdrWAGSyNE7Jn9QLmbaq5najiGzzeV4pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8l6VRB1pI8ypImCD4mwfzNE4o6qTI8RrgiU/V6h6DRDZw1A4DW6HvefVWujjlfAQ
         ZlyMzFYy36Jy3h0peWGKoX1YF81R4zx2ZfcX/YMy1GqVvzem6hrxyQFJZMO4aeELGD
         BVGSX+loEiTggvx5mDAPe3woQYZT8butLGqkhJjg=
Date:   Mon, 18 Jan 2021 12:37:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: [PATCH] usb: bdc: Remove the BDC PCI driver
Message-ID: <YAVy3KKu7n522aUU@kroah.com>
References: <20210115213142.35003-1-alcooperx@gmail.com>
 <878s8qwkgz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s8qwkgz.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 01:30:36PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Al Cooper <alcooperx@gmail.com> writes:
> > The BDC PCI driver was only used for design verification with
> > an PCI/FPGA board. The board no longer exists and is not in use
> > anywhere. All instances of this core now exist as a memory mapped
> > device on the platform bus.
> >
> > NOTE: This only removes the PCI driver and does not remove the
> > platform driver.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> 
> It sounds like it could be used for pre-silicon verification of newer
> Core Releases, much like Synopsys still uses the HAPS (with mainline
> linux, mind you) for silicon validation.
> 
> Why would we delete this small shim if it *could* still be useful?

It ends up conflicting with the PCI id of a device that is actually in
the wild (a camera on Apple laptops).  So it's good to drop this driver
so the wrong driver doesn't get constantly bound to the wrong device.

thnaks,

greg k-h
