Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41650249F36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHSNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:08:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:42180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgHSNIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:08:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 758CEB0B7;
        Wed, 19 Aug 2020 13:09:02 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:08:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH v1 10/11] mm: pass migratetype into memmap_init_zone()
 and move_pfn_range_to_zone()
Message-ID: <20200819130835.GO5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-11-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:56, David Hildenbrand wrote:
> On the memory hotplug path, we want to start with MIGRATE_ISOLATE, to
> un-isolate the pages after memory onlining is complete. Let's allow
> passing in the migratetype.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: linux-ia64@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
