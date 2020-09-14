Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12902690EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgINP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgINP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:58:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B682074B;
        Mon, 14 Sep 2020 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099111;
        bh=iI+DSPzAYRKbESqzB5bw8uRbrLcImU5dP6MB8tRyWtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdfQSKK/Ht1z00B3QmrPDsAFnkSAPIAF2eCYJzCyMaLPSBWiUQMxW4mASY61iH7nq
         ez2Rrbr1R2UlmzX2qrG1HocJPhXUGVt4t2DLD9DKc+l9Vgip07XCbsrvdxT4fakTS9
         Z7PAbds9Xltu/rOgdPuvcJGpP4dmbqgQFyE6SgY8=
Date:   Mon, 14 Sep 2020 17:58:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     ricky_wu@realtek.com, arnd@arndb.de, bhelgaas@google.com,
        vaibhavgupta40@gmail.com, rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
Message-ID: <20200914155830.GA3525000@kroah.com>
References: <20200824030006.30033-1-ricky_wu@realtek.com>
 <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 09:40:56AM +0100, Chris Clayton wrote:
> Hi Greg and Arnd,
> 
> On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
> > From: Ricky Wu <ricky_wu@realtek.com>
> > 
> > this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
> > missing card reader
> > 
> 
> In his changelog above, Ricky didn't mention that this patch fixes a regression that was introduced (in 5.1) by commit
> bede03a579b3.
> 
> The patch that I posted to LKML contained the appropriate Fixes, etc tags. After discussion, the patch was changed to
> remove the code that effectively disables the RTS5229 cardreader on (at least some) Intel NUC boxes. I prepared the
> patch that Ricky submitted but he didn't include my Signed-off-by or the Fixes tag. I think the following needs to be
> added to the changelog.
> 
> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
> Link: https://marc.info/?l=linux-kernel&m=159105912832257
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> 
> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on the Intel NUC6CAYH box.
> 
> My main point, however, is that the patch is also needed in the 5.4 (longterm) and 5.8 (stable) series kernels.

It's too late to change the commit log now that it is in my tree, but
once it hits Linus's tree for 5.9-rc1, I can backport it to those stable
trees if someone reminds me :)

thanks,

greg k-h
