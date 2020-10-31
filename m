Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC022A1546
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 11:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgJaKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 06:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgJaKdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 06:33:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327BC20729;
        Sat, 31 Oct 2020 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604140421;
        bh=OBA0wXzrhwoJDrsIX45Y7HMnr4LOhr8ofxiE6WOB01c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W42+sbriLJoslPigcmXApXIhL6cLPuQyl/Wc+VXNFPHpTTt765HHVdhGY5HMgKIPp
         MCy+syK2fHqQLVMoLraB7gZYGUleQTQc/73wdl7iELMYXzYYKnLDzNfaFoVVVvymxI
         3WsgWUuj/YLWUJgnVkfdbfnERt1U/5QOJ5CAeWWs=
Date:   Sat, 31 Oct 2020 11:34:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     ricky_wu@realtek.com, arnd@arndb.de, bhelgaas@google.com,
        vaibhavgupta40@gmail.com, rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
Message-ID: <20201031103427.GC961225@kroah.com>
References: <20200824030006.30033-1-ricky_wu@realtek.com>
 <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
 <20200914155830.GA3525000@kroah.com>
 <e52d7258-e760-81ac-9093-abe7c3504ee2@googlemail.com>
 <b0698b1e-227e-1cfb-4ed8-da83a4ed7b18@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0698b1e-227e-1cfb-4ed8-da83a4ed7b18@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 07:20:34PM +0100, Chris Clayton wrote:
> Hi Greg,
> 
> On 18/09/2020 15:35, Chris Clayton wrote:
> > Mmm, gmail on android seems to have snuck some html into my reply, so here goes again...
> > 
> > On 14/09/2020 16:58, Greg KH wrote:
> >> On Sun, Sep 13, 2020 at 09:40:56AM +0100, Chris Clayton wrote:
> >>> Hi Greg and Arnd,
> >>>
> >>> On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
> >>>> From: Ricky Wu <ricky_wu@realtek.com>
> >>>>
> >>>> this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
> >>>> missing card reader
> >>>>
> >>>
> >>> In his changelog above, Ricky didn't mention that this patch fixes a regression that was introduced (in 5.1) by commit
> >>> bede03a579b3.
> >>>
> >>> The patch that I posted to LKML contained the appropriate Fixes, etc tags. After discussion, the patch was changed to
> >>> remove the code that effectively disables the RTS5229 cardreader on (at least some) Intel NUC boxes. I prepared the
> >>> patch that Ricky submitted but he didn't include my Signed-off-by or the Fixes tag. I think the following needs to be
> >>> added to the changelog.
> >>>
> >>> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
> >>> Link: https://marc.info/?l=linux-kernel&m=159105912832257
> >>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
> >>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> >>>
> >>> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on the Intel NUC6CAYH box.
> >>>
> >>> My main point, however, is that the patch is also needed in the 5.4 (longterm) and 5.8 (stable) series kernels.
> >>
> >> It's too late to change the commit log now that it is in my tree, but
> >> once it hits Linus's tree for 5.9-rc1, I can backport it to those stable
> >> trees if someone reminds me :)
> >>
> 
> This is the reminder you suggested. The patch is now in Linus's tree and the commit id is
> 551b6729578a8981c46af964c10bf7d5d9ddca83.

Now queued up, thanks.

greg k-h
