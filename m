Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD02D492F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbgLISkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733209AbgLISkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:40:00 -0500
Date:   Wed, 9 Dec 2020 19:40:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607539157;
        bh=7B1JJYV3fj2v5nYpUV8P7FYYEngZTBSSDgmjiJpKbLA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNNRR+LJwYM6KxN/03T8ghHEfemVf+noQ2PNj/DDhXZEWHtNVk4DH9lJD81IK40L8
         NNPJP7jY481qAikszzxsOhepRLKLPyKohAPFno67ZE7ENP6is0P0xTmTyzv1XwSBVn
         U98iAWUJCp5mhkN3vTTFvQt/9XX1Gt6qdKi8yw2A=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nslusarek@gmx.net
Cc:     jhansen@vmware.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/vmw_vmci: bail out earlier on too big queue
 allocation
Message-ID: <X9EaIdgBeU/QBazh@kroah.com>
References: <trinity-96cb58f7-02ae-4ae2-b05d-169e1aa82c64-1606066857501@3c-app-gmx-bs01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-96cb58f7-02ae-4ae2-b05d-169e1aa82c64-1606066857501@3c-app-gmx-bs01>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 06:40:57PM +0100, nslusarek@gmx.net wrote:
> From: Norbert Slusarek <nslusarek@gmx.net>
> Date: Sun, 22 Nov 2020 19:16:41 +0100
> Subject: [PATCH] misc/vmw_vmci: bail out earlier on too big queue allocation
> 
> For the allocation of a queue pair in qp_host_alloc_queue() an arbitrary value can be
> passed for produce_size, which can lead to miscalculation of memory we'd like to allocate
> in one take. A warning is triggered at __alloc_pages_nodemask() in mm/page_alloc.c:4737
> which aborts the false allocation, but it results in a VMware machine freezing
> for an infinite time.
> 
> Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>
> 

<snip>

Can you resend this in a non-html format, so that we can apply it, and
so it will show up on the public mailing lists?

thanks,

greg k-h
