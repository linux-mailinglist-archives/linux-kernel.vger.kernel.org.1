Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942672D0B14
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLGHZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:25:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:33738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgLGHZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:25:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD949AC9A;
        Mon,  7 Dec 2020 07:24:54 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 07 Dec 2020 08:24:54 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
         =?UTF-8?Q?=E4=B9=9F=29?= <naoya.horiguchi@nec.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
In-Reply-To: <20201207023429.GA8986@hori.linux.bs1.fc.nec.co.jp>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-4-osalvador@suse.de>
 <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz>
 <20201201113511.GA22242@linux>
 <840d4669-ae3f-b7c4-6132-e20d1bf9e952@suse.cz>
 <20201205153423.GA4108@localhost.localdomain>
 <20201207023429.GA8986@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Roundcube Webmail
Message-ID: <9e15f4980654717f52733c56c33a3bdd@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 03:34, HORIGUCHI NAOYA wrote:
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 869ece2a1de2..ba861169c9ae 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1269,6 +1269,12 @@ static int memory_failure_dev_pagemap(unsigned 
>> long pfn, int flags,
>>  	if (!cookie)
>>  		goto out;
>> 
>> +	if (flags & MF_COUNT_INCREASED)
>> +		/*
>> +		 * Drop the extra refcount in case we come from madvise().
>> +		 */
>> +		put_page(page);
>> +
> 
> Should this if-block come before dax_lock_page() block?

Yeah, it should go first thing since as you noticed we kept the refcount 
if we fail.
Saturday brain... I will fix it.

Thanks Naoya

-- 
Oscar Salvador
SUSE L3
