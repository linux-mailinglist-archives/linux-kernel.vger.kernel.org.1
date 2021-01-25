Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A27302FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbhAYXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732174AbhAYXLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:11:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86293229C4;
        Mon, 25 Jan 2021 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611616272;
        bh=X7bRUoPwXu8J9VKI55RqWL4PrEa6+q0BmTV/swTO4uw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OQCCTo8yw5FY7cE+Nj81t3IOOaDnURS8q3G12ie3SioxqH3u1uKMm1MfhkCZwUHsk
         dN/WsUVVUYWk5SvzWK+eTlsAFQZ0XgVVY3kGkSdEx6PlfEhlm3lXWD511DfaP+GjJn
         bj/ptaefY0DhcJyOzxJnd461N2LL1p+cx5bJIy0o=
Date:   Mon, 25 Jan 2021 15:11:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
Message-Id: <20210125151111.0da207db337a575e5346bd08@linux-foundation.org>
In-Reply-To: <4367cc87-1ebf-6df2-d2d4-939c548ca790@redhat.com>
References: <20210125042441.20030-1-longman@redhat.com>
        <3b3f2b56-e66a-db5e-8d8e-95f3812c6838@huawei.com>
        <4367cc87-1ebf-6df2-d2d4-939c548ca790@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 09:12:56 -0500 Waiman Long <longman@redhat.com> wrote:

> Yes, this patch should go to stable. I think the stable tree maintainers 
> will automatically pick up patches with the "Fixes" tag. That is why I 
> don't explicitly put a "cc:stable" line in the patch.

No.  Both the Fixes: and the cc:stable are needed for the backport. 
Because sometimes we fix things but don't consider the fix important
enough to risk the backport.

