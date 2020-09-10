Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DC264313
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgIJJ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 05:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:33540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbgIJJ5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:57:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 224FCAD2F;
        Thu, 10 Sep 2020 09:57:38 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:57:17 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC 3/5] mm, page_alloc(): remove setup_pageset()
Message-ID: <20200910095716.GE2285@linux>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-4-vbabka@suse.cz>
 <20200910092307.GD2285@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910092307.GD2285@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:23:07AM +0200, Oscar Salvador wrote:
> On Mon, Sep 07, 2020 at 06:36:26PM +0200, Vlastimil Babka wrote:
> > We initialize boot-time pagesets with setup_pageset(), which sets high and
> > batch values that effectively disable pcplists.
> > 
> > We can remove this wrapper if we just set these values for all pagesets in
> > pageset_init(). Non-boot pagesets then subsequently update them to specific
> > values.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

You would need to squash here the remove of setup_pageset's declaration.
And then remove it from patch#4.

-- 
Oscar Salvador
SUSE L3
