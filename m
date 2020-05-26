Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49551B1D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgDUDmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 23:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgDUDmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:42:03 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3978D2071E;
        Tue, 21 Apr 2020 03:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587440523;
        bh=pEWs0YVxnwM137MWzOatekWnY7m66tGMYW/Tb3G2/Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2+sTaQ9C92+mNvG74s1lGlASAYFvm1PXnLkL9zCt8kUznsvq6OZI1vH4SpkUM+lh
         S5E2Vt4nzpvwGQWz5oDtE34stx98odqJca40dB3JNp3NlcioZ+7bc5VxXZYTt8K2tp
         2ea4JhE3hUb9NX4Puf8Xqcmcz3P58ZNdCsGWjUGk=
Date:   Mon, 20 Apr 2020 20:42:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/filemap.c: clear page error before actual read
Message-Id: <20200420204202.96450f776ee42bdc39b191b8@linux-foundation.org>
In-Reply-To: <20200303082541.33354-1-tian.xianting@h3c.com>
References: <20200303082541.33354-1-tian.xianting@h3c.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 16:25:41 +0800 Xianting Tian <tian.xianting@h3c.com> wrote:

> Mount failure issue happens under the scenario:
> Application totally forked dozens of threads to mount the same
> number of cramfs images separately in docker, but several mounts
> failed with high probability.
> Mount failed due to the checking result of the page
> (read from the superblock of loop dev) is not uptodate after
> wait_on_page_locked(page) returned in function cramfs_read:
>    wait_on_page_locked(page);
>    if (!PageUptodate(page)) {
>       ...
>    }
> 
> The reason of the checking result of the page not uptodate:
> systemd-udevd read the loopX dev before mount, because the status
> of loopX is Lo_unbound at this time, so loop_make_request directly
> trigger the calling of io_end handler end_buffer_async_read, which
> called SetPageError(page). So It caused the page can't be set to
> uptodate in function end_buffer_async_read:
>    if(page_uptodate && !PageError(page)) {
>       SetPageUptodate(page);
>    }

I'm wondering whether we should instead be invalidating the blockdev's
pagecache around the time of the loop binding.

But it's hard to say because loop_make_request() hasn't existed for a
long time.  What kernel version are you working against?

Are you able to test a (much) more recent kernel?  If so, and if the
problem persists, please update your problem description based on the
current kernel code so that others can more easily go in and take a
look, thanks.


