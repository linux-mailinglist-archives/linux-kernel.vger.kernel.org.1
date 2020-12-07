Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA32D1D48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgLGWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLGWZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:25:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F665C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=914UG8zVh6HNKad8qFgbFphbya57JgSOcPMsayoR1GE=; b=jpxOFeVCKHWgoJk6iNbawQlXFQ
        m7nHYI2xN0ye5GEnc5MAJ0crJ+am9aqfkjnsqMSuCcgrCf5sjPcA4Uv7Lzpfk0oyvjxtnWfj7pjii
        TgkVd2RL0k1UYQ4APlAdk+D4Hct0hb5NpgQTXdSEbdA7og6d8J3pkfOJTthMg+8YPDWvmQnZ148T2
        Of2kYPZpn5wEphmqHotVZVAEBaOajllVuNE0q0dy3I7rv+FSDODHNzr/NdJT6GA5SuPatxqhx5Abz
        IewcVRzGyqFGoHpOgeZjFzpmgJHB+pMp81r2IBXrCXTVfREHIHglCbJF3g6hnR+DzEn5TxmNEEN6e
        ULBzeTJA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmOvl-00075i-Jp; Mon, 07 Dec 2020 22:24:30 +0000
Date:   Mon, 7 Dec 2020 22:24:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mm: VM_BUG_ON lru page flags
Message-ID: <20201207222429.GC7338@casper.infradead.org>
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-8-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207220949.830352-8-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:09:45PM -0700, Yu Zhao wrote:
> Move scattered VM_BUG_ONs to two essential places that cover all
> lru list additions and deletions.

I'd like to see these converted into VM_BUG_ON_PGFLAGS so you have
to take that extra CONFIG step to enable checking them.

