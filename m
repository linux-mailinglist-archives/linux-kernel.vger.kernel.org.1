Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644972AF6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKKQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgKKQfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:35:36 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339F9206F1;
        Wed, 11 Nov 2020 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605112533;
        bh=vF5/Tu4Qygs39cHM41EGa7wsINPDLQw8Vbqv8foqudM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ISaLpxz5fjyy8Mjol+l4WNuSyZcAD1T9cf8EI7cIbFXSPjlF3WqAiSoTzuz3jq20
         vO3Mv0IYXTQD7wIsoQD46GSJD0I8VGO3k8ueHWCbD3WGfAKr2qCDqQCA3fpLJ3voRh
         C3XZxJmR0FyrNSbgjdYMR7ABeimRYrtkW/GyfZlQ=
Date:   Wed, 11 Nov 2020 17:36:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there
 is no console
Message-ID: <X6wTEpJwC+ZoLSAy@kroah.com>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 02:54:49PM +0100, Petr Mladek wrote:
> stdin, stdout, and stderr standard I/O stream are created for the init
> process. They are not available when there is no console registered
> for /dev/console. It might lead to a crash when the init process
> tries to use them, see the commit 48021f98130880dd742 ("printk: handle
> blank console arguments passed in.").
> 
> Normally, ttySX and ttyX consoles are used as a fallback when no consoles
> are defined via the command line, device tree, or SPCR. But there
> will be no console registered when an invalid console name is configured
> or when the configured consoles do not exist on the system.
> 
> Users even try to avoid the console intentionally, for example,
> by using console="" or console=null. It is used on production
> systems where the serial port or terminal are not visible to
> users. Pushing messages to these consoles would just unnecessary
> slowdown the system.
> 
> Make sure that stdin, stdout, stderr, and /dev/console are always
> available by a fallback to the existing ttynull driver. It has
> been implemented for exactly this purpose but it was used only
> when explicitly configured.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Tricky, and nice to use the existing driver for this, I like it:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
