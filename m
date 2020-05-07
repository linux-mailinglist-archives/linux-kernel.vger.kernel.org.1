Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F451C9EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 01:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgEGXEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 19:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEGXEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:04:39 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E092C208D6;
        Thu,  7 May 2020 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892679;
        bh=sOdZ8xLeykG3/i/JUyklEJJMF0/D0IIXGb47O2HJ2Mg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NSwLOrPuuyCkN9Lb9rVz/kC4ALjEmJWYGRAMAB9dt/uvKnLN9DYPrEwpFrNRCbn5j
         r9LRq+rK7er4T9EDm4MINIqFA1mQxQ0btLmgBoOvGJRS4xGhFv05Kin09la/Q5qGHB
         IJOwvyF6k/oZB0Zf7bVEVN3jGL11M4UPJ3VMRSR0=
Date:   Thu, 7 May 2020 16:04:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gavin.guo@canonical.com, kernel@gpiccoli.net,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
Message-Id: <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
In-Reply-To: <20200507215946.22589-1-gpiccoli@canonical.com>
References: <20200507215946.22589-1-gpiccoli@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 May 2020 18:59:46 -0300 "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:

> Currently we have no way to determine if compaction was triggered
> by sysctl write, but this is an interesting information to have,
> specially in systems with high uptime that presents lots of
> fragmented memory. There's no statistic indicating if compaction
> was triggered manually or ran by Linux itself, the vmstat numbers
> cannot tell the user this information.

Could add it to vmstat?

> This patch adds a very simple message to kernel log when compaction
> is requested through a write to sysctl file, and also it accumulates
> the number of previously manual compaction executions. It follows
> the approach used by drop_caches.

Userspace could write to /dev/kmsg when it decides to trigger
compaction?  Although using the kernel log seems a fairly lame way for
userspace to record its own actions...
