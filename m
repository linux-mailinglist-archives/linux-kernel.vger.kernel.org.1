Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FB2EC3F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhAFTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbhAFTdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:33:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDE392312C;
        Wed,  6 Jan 2021 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609961585;
        bh=660NBkaEC1hJB/mFkMWFSGgp4y+beSOalMN9oPgqXHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fcBi4bWK+4+gt9XJbwxUO0gNGKlj4eux8unZWWusjpR501jIFHD6/jzmdrN/zsgg2
         LXeDSi+SEtRDsaHWW6uvdPZcegfECJrcDQEQJ7b9REDWxSly4saXF0ENqV0PAn+9dN
         Qkd3KthLSgjWEMvS0K2WEBq3Pm9FPtQSgx2zO7u0=
Date:   Wed, 6 Jan 2021 11:33:04 -0800
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
Message-Id: <20210106113304.e74683a0e1b8639e930b21f6@linux-foundation.org>
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

> > --- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
> > +++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
> > @@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
> >  {
> >  	struct mem_cgroup *memcg = page_memcg(page);
> >  
> > -	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> > +	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
> >  	return mem_cgroup_lruvec(memcg, pgdat);
> 
> Thanks for fixing this. We also encountered this issue in kdump kernel
> with the mainline 5.10 kernel since 'cgroup_disable=memory' is added.

Thanks - I added the cc:stable.
