Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32482812B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbgJBMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBMaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:30:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252D620665;
        Fri,  2 Oct 2020 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601641802;
        bh=7TRPhB5ReWxY6f9LG4qgPUTaPS83aCAvxWh313ilm1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyzdkXAS2WrJwE6ETp1YVEj9XQRL42bJvDP+nOCdsRKNUxXbgQShgt3EoKA9oRXQA
         DymApZUn5Ecg14p38e054FZkzAQYZJl0lzNZW9B1/CUBDVliaU+G7dZ79THdidqgfn
         ccExzJ+E1jcfvAvT7wlrbELclvo2wDM/vWwISGO8=
Date:   Fri, 2 Oct 2020 14:30:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tammo Block <tammo.block@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3 0/6] vt: Add SRG mouse reporting features
Message-ID: <20201002123002.GA3346488@kroah.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 12:57:22PM +0200, Tammo Block wrote:
> Hi everybody,
> 
> this patchset adds xterm like mouse reporting features to the console.
> 
> The linux virtual console has support for mouse reporting since 1994 or so,
> but the kernel only supports the original X10/X11 style standard protocols.
> To support more protocols these patches expand the kernel structures in a
> up- and downwards compatible way, see the last patch for detailed
> documentation and pointers to even more detailed docs.
> 
> The main goal is to become compatible with xterm, as most TUI software today
> is tested in xterm or another compatible terminal.
> 
> Support by the mouse daemons (consolation, gpm) will be needed too.

What happened to this feature.  Was there a new set of patches or was
this the last one?

mouse support for the console feels odd these dyas, who would use this?

thanks,

greg k-h
