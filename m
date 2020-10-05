Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B6E282ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgJECaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:30:03 -0400
Received: from foss.arm.com ([217.140.110.172]:35274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgJECaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:30:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FDFA101E;
        Sun,  4 Oct 2020 19:30:02 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9223F71F;
        Sun,  4 Oct 2020 19:29:58 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
 <20201002120422.GE4555@dhcp22.suse.cz>
Message-ID: <fa6a7ea8-df58-c692-0317-686227de54ca@arm.com>
Date:   Mon, 5 Oct 2020 07:59:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201002120422.GE4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2020 05:34 PM, Michal Hocko wrote:
> On Wed 30-09-20 11:30:49, Anshuman Khandual wrote:
>> Add following new vmstat events which will track HugeTLB page migration.
>>
>> 1. HUGETLB_MIGRATION_SUCCESS
>> 2. HUGETLB_MIGRATION_FAILURE
>>
>> It follows the existing semantics to accommodate HugeTLB subpages in total
>> page migration statistics. While here, this updates current trace event
>> 'mm_migrate_pages' to accommodate now available HugeTLB based statistics.
> What is the actual usecase? And how do you deal with the complexity
> introduced by many different hugetlb page sizes. Really, what is the
> point to having such a detailed view on hugetlb migration?
>

It helps differentiate various page migration events i.e normal, THP and
HugeTLB and gives us more reliable and accurate measurement. Current stats
as per PGMIGRATE_SUCCESS and PGMIGRATE_FAIL are misleading, as they contain
both normal and HugeTLB pages as single entities, which is not accurate.

After this change, PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will contain page
migration statistics in terms of normal pages irrespective of whether any
previous migrations until that point involved normal pages, THP or HugeTLB
(any size) pages. At the least, this fixes existing misleading stats with
PGMIGRATE_SUCCESS and PGMIGRATE_FAIL.

Besides, it helps us understand HugeTLB migrations in more detail. Even
though HugeTLB can be of various sizes on a given platform, these new
stats HUGETLB_MIGRATION_SUCCESS and HUGETLB_MIGRATION_FAILURE give enough
overall insight into HugeTLB migration events.

Though these new stats accumulate HugeTLB migration success and failure
irrespective of their size, it will still be helpful as HugeTLB is user
driven, who should be able to decipher these accumulated stats. But this
is a limitation, as it might be difficult to determine available HugeTLB
sizes at compile time.
