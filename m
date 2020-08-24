Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD124FC12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHXK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:56:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgHXK4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:56:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13496AC1D;
        Mon, 24 Aug 2020 10:56:32 +0000 (UTC)
Date:   Mon, 24 Aug 2020 12:55:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v2 07/10] mm/memory_hotplug: simplify page onlining
Message-ID: <20200824105559.GG6315@linux>
References: <20200819175957.28465-1-david@redhat.com>
 <20200819175957.28465-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819175957.28465-8-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:59:54PM +0200, David Hildenbrand wrote:
> We don't allow to offline memory with holes, all boot memory is online,
> and all hotplugged memory cannot have holes.
> 
> We can now simplify onlining of pages. As we only allow to online/offline
> full sections and sections always span full MAX_ORDER_NR_PAGES, we can just
> process MAX_ORDER - 1 pages without further special handling.
> 
> The number of onlined pages simply corresponds to the number of pages we
> were requested to online.
> 
> While at it, refine the comment regarding the callback not exposing all
> pages to the buddy.
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
