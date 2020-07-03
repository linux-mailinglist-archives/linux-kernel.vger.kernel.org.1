Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183BC213C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGCP0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 11:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:46374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgGCP0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65145AC22;
        Fri,  3 Jul 2020 15:26:01 +0000 (UTC)
Subject: Re: [PATCH v3 5/8] mm/migrate: make a standard migration target
 allocation function
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8713b28d-880e-ffdc-6dd0-bfc65c1b7219@suse.cz>
Date:   Fri, 3 Jul 2020 17:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 8:13 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There are some similar functions for migration target allocation. Since
> there is no fundamental difference, it's better to keep just one rather
> than keeping all variants. This patch implements base migration target
> allocation function. In the following patches, variants will be converted
> to use this function.
> 
> Note that PageHighmem() call in previous function is changed to open-code
> "is_highmem_idx()" since it provides more readability.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Provided that the "&= ~__GFP_RECLAIM" line is separated patch as you discussed,

Acked-by: Vlastimil Babka <vbabka@suse.cz>
