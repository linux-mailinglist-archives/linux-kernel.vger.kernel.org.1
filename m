Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE920B369
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFZOTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 10:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgFZOTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:19:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E848F208C9;
        Fri, 26 Jun 2020 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593181177;
        bh=xGvMhYdL0SsIxlp6493J5SH2f1tkLzZPbB6DcFRR/Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0C0kKj/2XZdz9AYwQRO/gF40TOgr9vGcgeorNTOKAxS0spCnbQ7L2AZDVz564hjjC
         FIa0OrEAe6k+xkWRUrtWHFDdXedZRQtqQrZyJNeWvAy6T4tsnom5I/yP/4v2vpuGC4
         GZQqIm8GJ6oiSCu4DrEt5SUH885r/3zoomHi9WS4=
Date:   Fri, 26 Jun 2020 16:19:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200626141932.GC4141629@kroah.com>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
 <1591264879-25920-5-git-send-email-sumit.garg@linaro.org>
 <20200626121348.eeutt4py34f2yg3y@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626121348.eeutt4py34f2yg3y@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:13:48PM +0100, Daniel Thompson wrote:
> Hi Greg
> 
> This patch touches some kgdb related code in both serial and usb trees.
> 
> Any objections to my queuing this via the kgdb tree?
> 
> After testing I've concluded that this, and its friends (which only
> touch kgdb), fix enough problems that I plan to queue it for v5.8.

No objections at all:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
