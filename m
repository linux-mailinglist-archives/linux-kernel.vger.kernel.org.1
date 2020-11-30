Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49B2C8047
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgK3IvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:51:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:34404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgK3IvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:51:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21EE8AC95;
        Mon, 30 Nov 2020 08:50:25 +0000 (UTC)
Date:   Mon, 30 Nov 2020 09:50:22 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v2 3/4] mm,memory_hotplug: Add
 mhp_supports_memmap_on_memory
Message-ID: <20201130085018.GA3825@linux>
References: <20201125112048.8211-1-osalvador@suse.de>
 <20201125112048.8211-4-osalvador@suse.de>
 <20201127150253.GU31550@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127150253.GU31550@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 04:02:53PM +0100, Michal Hocko wrote:
> It should also require a tunable (kernel parameter for now but maybe we
> will need a more fine grained control later) to enable this explicitly.
> Earlier discussions have pointed out that allocating vmemmap from each
> section can lead to a sparse memory unsuitable for very large pages.
> So I believe this should be an opt in.

Yeah, I already had that in mind, just did not get to implement it in this RFC
yet as I was more focused on the implementation per se.
I thought about a tunable in /sys/device/system/memory/[file], but a kernel
command line boot option would also work and for the first implementation
would be less for a hassel.

> Also is there any reason why this cannot be a preparatory patch for the
> actual implementation? It would look more natural that way to me.

I guess you are right, will re-order it in a future submission.

-- 
Oscar Salvador
SUSE L3
