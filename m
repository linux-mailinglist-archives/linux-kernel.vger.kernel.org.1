Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3427E27E621
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgI3KCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:02:48 -0400
Received: from foss.arm.com ([217.140.110.172]:33156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbgI3KCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:02:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5F9D6E;
        Wed, 30 Sep 2020 03:02:46 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05AF33F70D;
        Wed, 30 Sep 2020 03:02:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
 <20200930074639.GA26786@linux>
Message-ID: <5f8a390c-8280-9b04-bf4a-3454d5984bf1@arm.com>
Date:   Wed, 30 Sep 2020 15:32:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200930074639.GA26786@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/2020 01:16 PM, Oscar Salvador wrote:
> On Wed, Sep 30, 2020 at 11:30:49AM +0530, Anshuman Khandual wrote:
>> -			is_thp = PageTransHuge(page) && !PageHuge(page);
>> -			nr_subpages = thp_nr_pages(page);
>> +			is_thp = false;
>> +			is_hugetlb = false;
>> +			if (PageTransHuge(page)) {
>> +				if (PageHuge(page))
>> +					is_hugetlb = true;
>> +				else
>> +					is_thp = true;
>> +			}
> 
> Since PageHuge only returns true for hugetlb pages, I think the following is
> more simple?
> 
> 	if (PageHuge(page))
> 		is_hugetlb = true;
> 	else if (PageTransHuge(page))
> 		is_thp = true

Right, it would be simple. But as Mike had mentioned before PageHuge()
check is more expensive than PageTransHuge(). This proposal just tries
not to call PageHuge() unless the page first clears PageTransHuge(),
saving some potential CPU cycles on normal pages.

> 
> 
> Besides that, it looks good to me:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
