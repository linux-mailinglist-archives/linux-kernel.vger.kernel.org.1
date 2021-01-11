Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14A92F0EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbhAKJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:05:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:35052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbhAKJFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:05:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89830AD26;
        Mon, 11 Jan 2021 09:05:11 +0000 (UTC)
Date:   Mon, 11 Jan 2021 10:05:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [PATCH 0/5] Allocate memmap from hotadded memory (per device)
Message-ID: <20210111090504.GA4102@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217130758.11565-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 02:07:53PM +0100, Oscar Salvador wrote:
> I figured I would send a new version before going on vacation, so I can
> work on it when I am back.
> 
> Changes from RFCv3 to Patchv1:
>  - Addressed feedback from David
>  - Re-order patches
> 
> Changes from v2 -> v3:
>  - Re-order patches (Michal)
>  - Fold "mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY" in patch#1
>  - Add kernel boot option to enable this feature (Michal)
> 
> Changes from v1 -> v2:
>  - Addressed feedback provided by David
>  - Add a arch_support_memmap_on_memory to be called
>    from mhp_supports_memmap_on_memory, as atm,
>    only ARM, powerpc and x86_64 have altmat support.

Now that Christmas holidays are gone, let us dig this up.

thanks

 
-- 
Oscar Salvador
SUSE L3
