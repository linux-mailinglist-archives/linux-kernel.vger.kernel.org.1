Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF49426A32A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIOKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgIOKbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02318B0F2;
        Tue, 15 Sep 2020 10:32:04 +0000 (UTC)
Date:   Tue, 15 Sep 2020 12:31:45 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        mhocko@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: don't rely on system state to detect hot-plug
 operations
Message-ID: <20200915103145.GB30015@linux>
References: <20200915094143.79181-1-ldufour@linux.ibm.com>
 <20200915094143.79181-3-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915094143.79181-3-ldufour@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:41:42AM +0200, Laurent Dufour wrote:
> [1] According to Oscar Salvador, using this qemu command line, ACPI memory
> hotplug operations are raised at SYSTEM_SCHEDULING state:

I would like to stress that this is not the only way we can end up
hotplugging memor while state = SYSTEM_SCHEDULING.
According to David, we can end up doing this if we reboot a VM
with hotplugged memory.
(And I have seen other virtualization technologies do the same)

 
> Fixes: 4fbce633910e ("mm/memory_hotplug.c: make register_mem_sect_under_node() a callback of walk_memory_range()")
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
