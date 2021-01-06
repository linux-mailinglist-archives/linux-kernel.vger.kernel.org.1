Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411A2EC554
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbhAFUnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727475AbhAFUnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:43:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B71A62311B;
        Wed,  6 Jan 2021 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609965744;
        bh=B+PNb+h2TeheRTPPGBzTfoOQ6M+qd4Q24FS81ZUfhlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KV/Ds+kDNkjHOEmMFYGyLDU52yYBs5Yt7qulmBQChv/DsKJiOzNZqULO+dOgLL4Gp
         9AoDKCTZ8oaf0ZBZBVlYT9e2jSeghaJxiU5WVA71n+/ATEWZ/VKScY59UDSlYSL8JU
         mg50ew8+7+NrXBFW0dPQqwf4Y9sR/j6jnA7OZGJ4=
Date:   Wed, 6 Jan 2021 12:42:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-Id: <20210106124223.587b93e5fdfd6a1a5f799c16@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
        <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
        <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
        <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
        <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
        <X/YY+mjpq15nmryI@redhat.com>
        <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 12:18:36 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> On Wed, 6 Jan 2021, Andrea Arcangeli wrote:
> > 
> > I'd be surprised if the kernel can boot with BUG_ON() defined as "do
> > {}while(0)" so I guess it doesn't make any difference.
> 
> I had been afraid of that too, when CONFIG_BUG is not set:
> but I think it's actually "if (cond) do {} while (0)".

Yes, that is so.  The thinking being that in most cases the compiler
will be smart enough to avoid generating any code for `cond' anyway.
