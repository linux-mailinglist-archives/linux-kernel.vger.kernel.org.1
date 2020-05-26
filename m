Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463421DF7BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgEWOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 10:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbgEWOFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 10:05:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7842072C;
        Sat, 23 May 2020 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590242707;
        bh=t8EOi/+FRcIQN8xz8j2kTaxVW8mQa3mV2jwc7/rtK/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFJPBOGpTork96FxBEvOU0Cf5WzBYFjxTcUgQH0axEByYEehrw9p1Gt7n2EFKkVxV
         JzP65rInJCzSIuHhvHeDje/wY6lMAOPWRZESkmFsJ4mooR9gU76dw2/3TfSCqIYwqk
         4Xzwp5DGzakiBYXhscrtVfJ/MeBsT3NMU+R8B98c=
Date:   Sat, 23 May 2020 16:05:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7
Message-ID: <20200523140505.GB114366@kroah.com>
References: <20200523131759.GA55886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523131759.GA55886@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 03:17:59PM +0200, Greg KH wrote:
> The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:
> 
>   Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc7
> 
> for you to fetch changes up to 4ef12f7198023c09ad6d25b652bd8748c965c7fa:
> 
>   kobject: Make sure the parent does not get released before its children (2020-05-21 11:01:27 +0200)
> 
> ----------------------------------------------------------------
> Driver core / kobject fixes for 5.7-rc7
> 
> Here are 3 small driver core and kobject fixes for 5.7-rc7
> 
> The kobject fix resolves a bug that the should not normally ever be hit,
> but the kunit tests were hitting pretty regularly.  It's been reviewed
> and tested by a bunch of people and stared at by me for a long time, so
> it should be good.

Nope, it isn't, Guenter reports runtime failures with this patch
applied.

So please don't pull this just yet...

thanks,

greg k-h
