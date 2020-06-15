Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95711F96AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgFOMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 08:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgFOMgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:36:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E323B206D7;
        Mon, 15 Jun 2020 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592224612;
        bh=MLaz9Lh1fa6o0lqJXRQNSErh5KCNk+V5uBZbIEvmyBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5wM4r/qTZh2Gd/MrVZAAxieeBAcKNrUg01uSmxjMC3u5RYWnyavygGbZTl2XKqaA
         e1/gA37Wvyg0cZw1jS5WU7VPSXJaVsvVe65KEHAyGQSs9Xk1CNBM5PBNL6wO/fcT2Y
         XP5kUxvdiMdB0Iqkmm5M5/BRDNTGHrz5i2N4kJwo=
Date:   Mon, 15 Jun 2020 14:36:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ferreira <rikajff@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] Staging: rtl8712: Addressed checkpatch.pl issues
 related to macro parameter wrapping in parentheses.
Message-ID: <20200615123639.GC943330@kroah.com>
References: <20200614173146.28292-1-rikajff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614173146.28292-1-rikajff@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 06:31:46PM +0100, Ricardo Ferreira wrote:
> Attempting to wet my feet in kernel patch submission by submitting a checkstyle
> fix for the rtl8712 driver.
> 
> Signed-off-by: Ricardo Ferreira <rikajff@gmail.com>
> ---

What changed from v1?

Always put that below the --- line, so please fix this up and do a v3.

Also, your changelog text is very odd, do you see other commits in the
kernel for these files that say things that way?  Please try to follow
how others do things.  Also read the documentation for how to make a
good changelog text, that will help out a lot.

thanks,

greg k-h
