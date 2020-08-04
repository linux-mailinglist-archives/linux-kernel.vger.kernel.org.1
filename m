Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30F323BA1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHDMGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 08:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbgHDL5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:57:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53641208A9;
        Tue,  4 Aug 2020 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542230;
        bh=R+Foz/8zo9+GgInhMqlvYCUr1NnxOx7pfypaHXJtLWU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ET8j1kSfWY6jHru5raK6NT3mqrxz3v7kY1krCYzhz+E6sE0bOwwGXa5kR6WG5l+F4
         t5GzhPIgTX9huR5qmEhYxFVcmtVpUJznvNbYuAc9EwVNCNXpwK/1IjAtJGcubWZfLp
         3xJ+2DVeN6f4YMugSyc7NFCN6J/8WyQFjBqvEASM=
Date:   Tue, 4 Aug 2020 13:56:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804115650.GB203147@kroah.com>
References: <20200804111332.dex7jobmabifdzw5@function>
 <20200804113413.GA181242@kroah.com>
 <20200804114951.ijs3hnezi4f64nll@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804114951.ijs3hnezi4f64nll@function>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:49:51PM +0200, Samuel Thibault wrote:
> Greg KH, le mar. 04 août 2020 13:34:13 +0200, a ecrit:
> > On Tue, Aug 04, 2020 at 01:13:32PM +0200, Samuel Thibault wrote:
> > > Drivers using serialio are already made available in Kconfig only under
> > > the ISA condition.
> > > 
> > > This solves warnings in inb/outb macros on platform that do not have 
> > > support for ISA.
> > > 
> > > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > > 
> > > Index: linux-2.6/drivers/accessibility/speakup/Makefile
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/accessibility/speakup/Makefile
> > > +++ linux-2.6/drivers/accessibility/speakup/Makefile
> > > @@ -16,6 +16,7 @@ obj-$(CONFIG_SPEAKUP_SYNTH_TXPRT) += spe
> > >  obj-$(CONFIG_SPEAKUP_SYNTH_DUMMY) += speakup_dummy.o
> > >  
> > >  obj-$(CONFIG_SPEAKUP) += speakup.o
> > > +obj-$(CONFIG_ISA) += serialio.o
> > >  speakup-y := \
> > >  	buffers.o \
> > >  	devsynth.o \
> > > @@ -25,7 +26,6 @@ speakup-y := \
> > >  	keyhelp.o \
> > >  	kobjects.o \
> > >  	selection.o \
> > > -	serialio.o \
> > >  	spk_ttyio.o \
> > >  	synth.o \
> > >  	thread.o \
> > 
> > Oops, no, I get the following build errors with this patch:
> > 
> > ERROR: modpost: "spk_wait_for_xmitr" [drivers/accessibility/speakup/speakup.ko] undefined!
> 
> Yes, it depends on the first of the queue.

Ah, missed that, ok, let me try this again...

