Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D189023B87F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgHDKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 06:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgHDKJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F59D2177B;
        Tue,  4 Aug 2020 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596535773;
        bh=BDVRKWhd/ahtDaxAjQb6ui5srULsGQG8iPjKOzeDYao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW3ipZV+5YAVRX5Mn3sd2PMkK5RfgdNxEPEBVHalyf3pdxQYUpoQ/aWmu9g8OVNO/
         UHSDj/TmDBH1ny1fFVAMNTwHr5UsZ7dS/yOWnOaDiYecJ7q8FF5dJTSGn5ZQDWDsxP
         X+OXH8O94E8uZsnuiSeS4+o2q23ICjydFY0+r/Xc=
Date:   Tue, 4 Aug 2020 12:09:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH kernel] serial_core: Check for port state when tty is
 in error state
Message-ID: <20200804100912.GA2671027@kroah.com>
References: <20200728124359.980-1-aik@ozlabs.ru>
 <eb3cf1b2-8519-1722-22aa-6182ee734a27@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3cf1b2-8519-1722-22aa-6182ee734a27@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:02:27PM +1000, Alexey Kardashevskiy wrote:
> Ping?
> 
> ps. Greg, your name came up in "git format-patch -M --stdout -1 HEAD |
> ./scripts/get_maintainer.pl --norolestats --l" ;)

It's in my queue to review, but can't do anything now that the merge
window is open.

Also, as it's an RFC, that means you don't think it should be merged, so
perhaps do some work to verify that you think this is correct and resend
it?

thanks,

greg k-h
