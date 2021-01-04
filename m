Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC682E98E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhADPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:33:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:53894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbhADPdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:33:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609774381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9W6ynCBWCE9iblo+eEtY1owmDUUUf1gpZxO3U/daYs=;
        b=Cqr6pN1N5LRWD+oWfPTF3jBAm0F27KO3A3Dxb26G3iV9TtqwO7MknLSUgnuMSIFqbOJ/G/
        84e3FQ3e4vv60SQ+CaWGNfen91m0uKsWwuZ/cN+m9mAZAAKVCLbTIe834yGwGVxAfIhWZX
        THnpgAkC5xX0DNOOrYn0lmMuAueuQO8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 835F4B73F;
        Mon,  4 Jan 2021 15:33:01 +0000 (UTC)
Date:   Mon, 4 Jan 2021 16:33:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210104153300.GL13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
> On 04.01.21 16:10, Michal Hocko wrote:
[...]
> Do the physical addresses you see fall into the same section as boot
> memory? Or what's around these addresses?

Yes I am getting a garbage for the first struct page belonging to the
pmem section [1]
[    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
[    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile

The pfn without the initialized struct page is 0x6060000. This is a
first pfn in a section.

--- 
[1] it shares the same memory block with the regular memory as those
are in the same 2G range.
-- 
Michal Hocko
SUSE Labs
