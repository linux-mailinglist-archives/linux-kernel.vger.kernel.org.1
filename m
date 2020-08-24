Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABB24FBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHXKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgHXKof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C61A5AC98;
        Mon, 24 Aug 2020 10:45:03 +0000 (UTC)
Date:   Mon, 24 Aug 2020 12:44:31 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v2 03/10] mm/memory_hotplug: simplify page offlining
Message-ID: <20200824104431.GC6315@linux>
References: <20200819175957.28465-1-david@redhat.com>
 <20200819175957.28465-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819175957.28465-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:59:50PM +0200, David Hildenbrand wrote:
> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages(). We no longer need walk_system_ram_range() and can
> call test_pages_isolated() and __offline_isolated_pages() directly.
> 
> offlined_pages always corresponds to nr_pages, so we can simplify that.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
