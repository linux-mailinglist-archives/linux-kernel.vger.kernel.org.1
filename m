Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0E2D4935
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbgLISlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbgLISki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:40:38 -0500
Date:   Wed, 9 Dec 2020 19:41:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607539198;
        bh=+y7Cfhfw6QogvsTqdVqaVWySstSvOsQDl0uHOZ1gbxs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+TPtQlelMwUTdyWFbcoozEYzb0ahYIEt0CH4++iyrLEvOPtCh+DT6VYcdkEG2+iA
         VJw0TgNpEXrDIdExPIelKDGRXLt93QpTzkjEbAblTlOlBsogjxY2Em385UdNxu5rhH
         FWoT1loIPPgcfV++Kwm4MShcKVbmo0MFibIbLPbM=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nslusarek@gmx.net
Cc:     jhansen@vmware.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/vmw_vmci: bail out earlier on too big queue
 allocation
Message-ID: <X9EaSums0U4BB9r6@kroah.com>
References: <trinity-96cb58f7-02ae-4ae2-b05d-169e1aa82c64-1606066857501@3c-app-gmx-bs01>
 <X9EaIdgBeU/QBazh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9EaIdgBeU/QBazh@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:40:33PM +0100, Greg KH wrote:
> On Sun, Nov 22, 2020 at 06:40:57PM +0100, nslusarek@gmx.net wrote:
> > From: Norbert Slusarek <nslusarek@gmx.net>
> > Date: Sun, 22 Nov 2020 19:16:41 +0100
> > Subject: [PATCH] misc/vmw_vmci: bail out earlier on too big queue allocation
> > 
> > For the allocation of a queue pair in qp_host_alloc_queue() an arbitrary value can be
> > passed for produce_size, which can lead to miscalculation of memory we'd like to allocate
> > in one take. A warning is triggered at __alloc_pages_nodemask() in mm/page_alloc.c:4737
> > which aborts the false allocation, but it results in a VMware machine freezing
> > for an infinite time.
> > 
> > Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>
> > 
> 
> <snip>
> 
> Can you resend this in a non-html format, so that we can apply it, and
> so it will show up on the public mailing lists?

Oh nevermind, you already did, sorry about that...
