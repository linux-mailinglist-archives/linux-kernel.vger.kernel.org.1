Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E692D3F08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgLIJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:43:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:56122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgLIJn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:43:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 349B6AB63;
        Wed,  9 Dec 2020 09:43:18 +0000 (UTC)
Date:   Wed, 9 Dec 2020 10:43:15 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v3 1/4] mm,memory_hotplug: Add
 mhp_supports_memmap_on_memory
Message-ID: <20201209094315.GC30590@linux>
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-2-osalvador@suse.de>
 <c5b82d52-f1be-0701-e36b-49aae4bb5cdb@redhat.com>
 <20201209093608.GA30590@linux>
 <5809e56e-363b-abe4-7b95-08768c6a4b32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5809e56e-363b-abe4-7b95-08768c6a4b32@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:40:13AM +0100, David Hildenbrand wrote:
> Sorry if I was unclear, s390x will simply not set
> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE.

Bleh, that makes sense now.
I'm in a monday.. 

Thanks David

-- 
Oscar Salvador
SUSE L3
