Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F112E9918
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbhADPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:45:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbhADPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609775036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F64o4iIcbY4ifKBh0Jo3J+CYfbSeoigrg9hqqLOwqkU=;
        b=dODK93bDmhDbC6RAwL+kOkoDNE3/DIUPsWZWtzz2PpDdA6Y5kQofVbQYgteAeohVMtDfkV
        or+Rrx9Auyhzc/Nqsi9g2UQFzvA3eUd305NoW+D0h4c/Vn60TWO9kGQOEyGVHbHfuvccg+
        6qb/Y34DJkT1zD44snc/JsqkZdXET24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-pAlaefTrMouQlR9f8BSXzw-1; Mon, 04 Jan 2021 10:43:52 -0500
X-MC-Unique: pAlaefTrMouQlR9f8BSXzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 553FAC281;
        Mon,  4 Jan 2021 15:43:51 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E95960BFA;
        Mon,  4 Jan 2021 15:43:50 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
Date:   Mon, 4 Jan 2021 16:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210104153300.GL13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.21 16:33, Michal Hocko wrote:
> On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
>> On 04.01.21 16:10, Michal Hocko wrote:
> [...]
>> Do the physical addresses you see fall into the same section as boot
>> memory? Or what's around these addresses?
> 
> Yes I am getting a garbage for the first struct page belonging to the
> pmem section [1]
> [    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
> [    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile
> 
> The pfn without the initialized struct page is 0x6060000. This is a
> first pfn in a section.

Okay, so we're not dealing with the "early section" mess I described,
different story.

Due to [1], is_mem_section_removable() called
pfn_to_page(PHYS_PFN(0x6060000)). page_zone(page) made it crash, as not
initialized.

Let's assume this is indeed a reserved pfn in the altmap. What's the
actual address of the memmap?

I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?

If it's not self-hosted, initializing the relevant memmaps should work
just fine I guess. Otherwise things get more complicated.


-- 
Thanks,

David / dhildenb

