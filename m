Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57E92EC407
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbhAFTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbhAFTgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:36:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B48B2311B;
        Wed,  6 Jan 2021 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609961732;
        bh=n3LVOyfCd0iUhe5Om5AKlDrrPQGpP8Ciagj10Lz3MWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1X/UmIkmQLBkDHl6oOPqksf09SEBGWE6xq2fRY7FF8dOwK/X+JA40hcHoH9FSivK
         IydCPII0xJJUKQXe2Ngm0Dcdj8HPFGrQlYzjG/3SBd5QisfPfWOSHegeGiW1/tY0Al
         Uihmx0pk+fnZf4h7ChL3N35K7rHZHR1GtsHPrSRQ=
Date:   Wed, 6 Jan 2021 11:35:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Hui Su <sh_def@163.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
Message-Id: <20210106113531.6f327d37eff78e4e1bb0e13a@linux-foundation.org>
In-Reply-To: <20210106064935.GA3338@MiWiFi-R3L-srv>
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
        <20210106064935.GA3338@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 14:49:35 +0800 Baoquan He <bhe@redhat.com> wrote:

> > Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> 
> ...
>
> Thanks for fixing this. We also encountered this issue in kdump kernel
> with the mainline 5.10 kernel since 'cgroup_disable=memory' is added.

Wait.  9a1ac2288cf1 isn't present in 5.10?
