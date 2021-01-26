Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30EC304F40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405412AbhA0BqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:46:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:39176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389762AbhAZS6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:58:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A24B8ACC6;
        Tue, 26 Jan 2021 18:58:05 +0000 (UTC)
Subject: Re: [PATCH v2 02/10] mm: shuffle lru list addition and deletion
 functions
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-3-yuzhao@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aef7d3ab-50a3-be1e-ce65-4fe52c38e5bc@suse.cz>
Date:   Tue, 26 Jan 2021 19:58:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122220600.906146-3-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 11:05 PM, Yu Zhao wrote:
> These functions will call page_lru() in the following patches. Move
> them below page_lru() to avoid the forward declaration.
> 
> Link: https://lore.kernel.org/linux-mm/20201207220949.830352-3-yuzhao@google.com/
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
