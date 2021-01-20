Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4C2FCF90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbhATLjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387770AbhATKnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611139323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWzE1S6HXNzVdjyh7DmP7VYe4VGerymzd4mGWS9FWcU=;
        b=AlWIuuDQdEoKC+BDprVhw96M33lmt+GkcBWuyHNcPYPwm7lSk1aqC10p8aW3ZFaFB+7PkN
        nwh9gPw+jStDhHBHdosHd6Ao7wO2czgQ269NR4O7jYWDi4JbuHNRnc699cXNJ5k1JEgxmT
        47EyXLBAbZ8PRZN4STPs2ecl62X6IME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-B2hc1i0KOzOdQmQlesWZ8A-1; Wed, 20 Jan 2021 05:41:59 -0500
X-MC-Unique: B2hc1i0KOzOdQmQlesWZ8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050361800D42;
        Wed, 20 Jan 2021 10:41:57 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402905D74B;
        Wed, 20 Jan 2021 10:41:54 +0000 (UTC)
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
 <691872bb-b251-83e0-126e-afd54683c83e@redhat.com>
 <3d4f3b14-0715-b2b3-b015-04b8a77abfb8@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <30bbf862-06a4-bd1d-b902-61aa4183b819@redhat.com>
Date:   Wed, 20 Jan 2021 11:41:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <3d4f3b14-0715-b2b3-b015-04b8a77abfb8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 09:33, Anshuman Khandual wrote:
> 
> 
> On 1/19/21 5:51 PM, David Hildenbrand wrote:
>> On 18.01.21 14:12, Anshuman Khandual wrote:
>>> This introduces memhp_range_allowed() which can be called in various memory
>>> hotplug paths to prevalidate the address range which is being added, with
>>> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
>>> which provides applicable address range depending on whether linear mapping
>>> is required or not. For ranges that require linear mapping, it calls a new
>>> arch callback arch_get_mappable_range() which the platform can override. So
>>> the new callback, in turn provides the platform an opportunity to configure
>>> acceptable memory hotplug address ranges in case there are constraints.
>>>
>>> This mechanism will help prevent platform specific errors deep down during
>>> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
>>> check in __add_pages() but instead adds a VM_BUG_ON() check which would
>>
>> In this patch, you keep the __add_pages() checks. But as discussed, we
>> could perform it in mm/memremap.c:pagemap_range() insted and convert it
>> to a VM_BUG_ON().
> 
> Just to be sure, will the following change achieve what you are
> suggesting here. pagemap_range() after this change, will again
> be the same like the V1 series.

Yeah, as we used to have in v1. Maybe other reviewers (@Oscar?) have a
different opinion.

If you decide to leave as-is, please fixup the patch description. Thanks!

-- 
Thanks,

David / dhildenb

