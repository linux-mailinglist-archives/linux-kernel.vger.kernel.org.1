Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5531E2C204F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgKXInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:43:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:58420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730492AbgKXInw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:43:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606207431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YLobq2Kgfx6O6DNcBUNrxUYsXG3j5iSZLKWRmFWVAHA=;
        b=bkzNqMpXgfNtJzNRTF9vcCxUnWHHoEhoJXkgs6C081As/BL/OcQeAGTcUtO+v2a/UJJvp6
        Fl/iezJQ8/f0JiJ+Di2fU8oVkkBdLMz0O8+GJbtXnFzvaQQmZJFfdm1qoMVAtotBqz6H9v
        4WSbE0TdYjOa0fIQ0bQv22AogEEgJAk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C49BCAC2D;
        Tue, 24 Nov 2020 08:43:51 +0000 (UTC)
Date:   Tue, 24 Nov 2020 09:43:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <20201124084350.GU27488@dhcp22.suse.cz>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <d668b0f2-2644-0f5e-a8c1-a6b8f515e9ab@suse.cz>
 <CA+CK2bBuEhH7cSEZUKTYE_g9mw_rwEG-v1Jk4BL6WuLWK824Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBuEhH7cSEZUKTYE_g9mw_rwEG-v1Jk4BL6WuLWK824Aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-11-20 11:31:59, Pavel Tatashin wrote:
[...]
> Also, we still need to take care of the fault scenario.

Forgot to reply to this part. I believe you mean this to be fault at gup
time, right? Then the easiest way forward would be to either add yet
another scoped flag or (maybe) better to generalize memalloc_nocma_* to
imply that the allocated memory is going to be unmovable so drop
__GFP_MOVABLE and also forbid CMA. I have to admit that I do not
remember why long term pin on CMA pages is ok to go to movable but I
strongly suspect this is just shifting problem around.
-- 
Michal Hocko
SUSE Labs
