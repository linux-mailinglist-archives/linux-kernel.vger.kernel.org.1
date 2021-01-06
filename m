Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1392EC422
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhAFTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbhAFTrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:47:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B00123131;
        Wed,  6 Jan 2021 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609962381;
        bh=mTkPqvalyZGT+HNCgL8RBG8IvEJHEcO8w9JgqACOlqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOdJhUQafw8lhnLzWFVEy8xjLN97baNoa8CetSHuHg+wkKl6LbziGFBbfNl4FMqrT
         vu5eHaNGbgR9wcM8KVJ9C+TCtUEwuJsYX5dc4fKzyXkG7bhaR92EnBWv8NUH6C8bDy
         BjS+g2qj8JhLYGOuRb7YWqbfl48p7+SuMShXOmcg=
Date:   Wed, 6 Jan 2021 11:46:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-Id: <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
        <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
        <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
        <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 20:28:27 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> Alex, please consider why the authors of these lines (whom you
> did not Cc) chose to write them without BUG_ON(): it has always
> been preferred practice to use BUG_ON() on predicates, but not on
> functionally effective statements (sorry, I've forgotten the proper
> term: I'd say statements with side-effects, but here they are not
> just side-effects: they are their main purpose).
> 
> We prefer not to hide those away inside BUG macros

Should we change that?  I find BUG_ON(something_which_shouldnt_fail())
to be quite natural and readable.

As are things like the existing

BUG_ON(mmap_read_trylock(mm));
BUG_ON(wb_domain_init(&global_wb_domain, GFP_KERNEL));

etc.


No strong opinion here, but is current mostly-practice really
useful?

