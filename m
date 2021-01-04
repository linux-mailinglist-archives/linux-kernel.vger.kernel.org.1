Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B52EA08D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbhADXNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:13:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbhADXNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:13:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E571207BC;
        Mon,  4 Jan 2021 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609801944;
        bh=4xw73rpmOn2Qfj9HGYOfgfQn8qxUL654PxIL6NQ0Cf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPz8mtUOm85S9cfTmYh4GyRuGL0788hMhQtK2AL2mG+RlRLBtqNhVdn9zQvsc+mID
         //R5yswLdwVqdC87YRCWHkbBr0FVj9HjVC8cwSIXe7QdRoog2BHh7KN0VuQna0ei05
         8/nTHrvKWbBcEp6xz/NBAaqfG7VRgS3awhzCv0nI=
Date:   Mon, 4 Jan 2021 15:12:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     vjitta@codeaurora.org
Cc:     minchan@kernel.org, glider@google.com, dan.j.williams@intel.com,
        broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v4 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
Message-Id: <20210104151223.34f97a033e966c9cc89915cb@linux-foundation.org>
In-Reply-To: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
References: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 18:15:30 +0530 vjitta@codeaurora.org wrote:

> Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
> 
> Aim is to have configurable value for  STACK_HASH_SIZE,
> so depend on use case one can configure it.
> 
> One example is of Page Owner, default value of
> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> Making it configurable and use lower value helps to enable features like
> CONFIG_PAGE_OWNER without any significant overhead.

Questions regarding the stackdepot code.

- stack_table_tmp[] is __initdata.  So after initmem is released,
  that "consume 8MB of static memory" should no longer be true.  But
  iirc, not all architectures actually release __initdata memory.  Does
  your architecture do this?

- Stackdepot copies stack_table_tmp[] into vmalloced memory during
  initcalls.  Why?  Why not simply make stack_table_tmp[] no longer
  __initdata and use that memory for all time?

  Presumably because in the stack_depot_disable==true case, we
  release stack_table_tmp[] memory, don't vmalloc for a copy of it, and
  save a bunch of memory?  If so, this assumes that the __initdata
  memory is freed.

- Why is that hash table so large?  Is it appropriately sized?

- SMP is up and running during init_stackdepot(), I think?  If so, is
  that huge memcpy smp-safe?  Can other CPUs be modifying
  stack_table_tmp[] while the memcpy is in flight?



