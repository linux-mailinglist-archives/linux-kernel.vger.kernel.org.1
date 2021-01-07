Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60962ECEDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbhAGLjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbhAGLjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:39:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07AB422CF8;
        Thu,  7 Jan 2021 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610019510;
        bh=1nQtu0tLpDNdkgjnePMVNCasmAQuIRbUiF4Yvi/LRfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDt+STOeN6lavK/h3Vy6GNL6Fwqh0OGDWqGgFEz9PQBOlWKTnEdVjAOsJoY8d7Cz2
         Q2bUG9i2ZSdHIIanP5apROTmSIYo0yJJgXGFugwaH4xNz/Kba0eF/HTdqJetnKpiEh
         smK8gsmNvD2xoSU/QIPwIyN23O+iNnDHIoXS7hx4=
Date:   Thu, 7 Jan 2021 12:39:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <X/bzBobubF1C5x3Q@kroah.com>
References: <20201213170503.59017-1-eli.billauer@gmail.com>
 <X/Rt+bUJ9Hs2F8nF@kroah.com>
 <5FF5C31C.6050804@gmail.com>
 <X/XH5Q6APKKt4kRR@kroah.com>
 <5FF6EDED.40408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FF6EDED.40408@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jan 07, 2021 at 01:18:05PM +0200, Eli Billauer wrote:
> Hello, Greg.
> 
> I'm afraid we're not on the same page. As mentioned in the original patch
> description, XillyUSB and the existing Xillybus variant presents a nearly
> identical API. User space programs see no difference when using one or the
> other, except for different device file names.

My point is, do NOT have different file names.  Userspace should not
care about the backing transport layer of a device.

> In that sense, it's exactly
> like tty devices. But unlike ttys, there are no ioctls or any other special
> API functions to export. Xillybus' API consists only of the basic file
> operations, which behave like you'd expect from a pipe, more or less.

Great, then do like the tty devices do and present the same device name
to userspace.

thanks,

greg k-h
