Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059B02BB9EF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgKTXTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgKTXTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:49 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFEF2240C;
        Fri, 20 Nov 2020 23:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605914389;
        bh=CgKb22sqL72nT7lPhX4BhOYK565Z8Zz2St8cZ261t+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FM0WixIhD8TuccCPJXLzguGZIUhfQlPCO5mOwYN+W01KpSNVZTdxEjjnw0uX5ORus
         klzQeKNh7Du+eWGTqXM2978qjY/ozbXl0NdWcxL9T6z4vBYBHNDL2G2b7neMd/Uo1C
         lNXc3gRtQi1QxA0izArBvqCfn93EdvrQjEBbXCig=
Date:   Fri, 20 Nov 2020 15:19:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
Message-Id: <20201120151948.c3f4175ed18ed74e46760b87@linux-foundation.org>
In-Reply-To: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 16:27:27 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> The current relock logical will change lru_lock when found a new
> lruvec, so if 2 memcgs are reading file or alloc page at same time,
> they could hold the lru_lock alternately, and wait for each other for
> fairness attribute of ticket spin lock.
> 
> This patch will sort that all lru_locks and only hold them once in
> above scenario. That could reduce fairness waiting for lock reget.
> Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
> gain on my 2P*20core*HT machine.

But what happens when all or most of the pages belong to the same
lruvec?  This sounds like the common case - won't it suffer?

