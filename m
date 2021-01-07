Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508B62ED386
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbhAGP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbhAGP2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:28:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC85923405;
        Thu,  7 Jan 2021 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610033294;
        bh=Q9kUjt5PP/PH3FRjQNamp/tNo9xumQJ21/Smoe2v2Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwbQ4c8txsphQrHS/XqnnPWrj8k/1i/3u/fXSn7YbpWoeW4+9w3U6aa/vZQBVXWRz
         1+cvO3PRQlEHdR7FFKXFsj1UZfmZKfruSQY/rdQy5Z8SyNRjielX121hxttzVuXPwu
         hFJlineBnad5pwtqTlNnEp0nRUwXuNtdr1hvW6bM=
Date:   Thu, 7 Jan 2021 16:29:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     minyard@acm.org, Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com
Subject: Re: [PATCH 2/2] drivers:tty:pty: Fix a race causing data loss on
 close
Message-ID: <X/co3Uq719eXempQ@kroah.com>
References: <20201124004902.1398477-1-minyard@acm.org>
 <20201124004902.1398477-3-minyard@acm.org>
 <20210102144109.GA4173@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102144109.GA4173@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 02, 2021 at 08:41:09AM -0600, Corey Minyard wrote:
> On Mon, Nov 23, 2020 at 06:49:02PM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > Remove the tty_vhangup() from the pty code and just release the
> > redirect.  The tty_vhangup() results in data loss and data out of order
> > issues.
> 
> It's been a while, so ping on this.  I'm pretty sure this is the right
> fix, the more I've thought about it.

Sorry, was waiting to see if someone else would review it :)

Will go do so now...

greg k-h
