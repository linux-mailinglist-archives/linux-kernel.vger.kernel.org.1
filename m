Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3142FFF60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAVJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727425AbhAVJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611307108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bPNlYTRjqjFp32YO1EEUTJqDvtbUUivvSM0yNsU/3s=;
        b=RlEhcdj3RNMAeEZiVsCGl2z2KYtHKb9WhSPT8wKRGT3wKKI8QIv+PDYASFFWjiL349bNdo
        HIKIeglupM3F3XBEDjdfQ6xo78qlRoB9MuAaMBRIeKw1GxWdZamEDOh0Ik88nwZis4av5W
        W1cGMH5s41xPy5bx+yvQCdpuBQgCYFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-xErR3gUGMlq5d42b3Cpd3Q-1; Fri, 22 Jan 2021 04:18:26 -0500
X-MC-Unique: xErR3gUGMlq5d42b3Cpd3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C8FF190B2A1;
        Fri, 22 Jan 2021 09:18:24 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8B6010023B9;
        Fri, 22 Jan 2021 09:18:21 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9916f217-ec29-33ff-a260-7a26792d23a1@redhat.com>
Date:   Fri, 22 Jan 2021 10:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*
> + * Platforms should define arch_get_mappable_range() that provides
> + * maximum possible addressable physical memory range for which the
> + * linear mapping could be created. The platform returned address
> + * range must adhere to these following semantics.
> + *
> + * - range.start <= range.end
> + * - Range includes both end points [range.start..range.end]
> + *
> + * There is also a fallback definition provided here, allowing the
> + * entire possible physical address range in case any platform does
> + * not define arch_get_mappable_range().
> + */
> +struct range __weak arch_get_mappable_range(void)
> +{
> +	struct range memhp_range = {
> +		.start = 0UL,
> +		.end = -1ULL,
> +	};
> +	return memhp_range;
> +}
> +
> +struct range memhp_get_pluggable_range(bool need_mapping)
> +{
> +	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;

Sorry, thought about that line a bit more, and I think this is just
wrong (took me longer to realize as it should). The old code used this
calculation to print the limit only (in a wrong way), let's recap:

Assume MAX_PHYSMEM_BITS=32

	max_phys = (1ULL << (32 + 1)) - 1 = 0x1ffffffffull;

Ehm, these are 33 bit.

OTOH, old code checked for

	if (max_addr >> MAX_PHYSMEM_BITS) {

Which makes sense, because

	0x1ffffffffull >> 32 = 1

results in "true", meaning it's to big, while

	0xffffffffull >> 32 = 0

correctly results in "false", meaning the address is fine.



So, this should just be

const u64 max_phys = 1ULL << MAX_PHYSMEM_BITS;

(similarly as calculated in virito-mem code, or in kernel/resource.c)


> +	struct range memhp_range;
> +
> +	if (need_mapping) {
> +		memhp_range = arch_get_mappable_range();
> +		if (memhp_range.start > max_phys) {
> +			memhp_range.start = 0;
> +			memhp_range.end = 0;
> +		}
> +		memhp_range.end = min_t(u64, memhp_range.end, max_phys);
> +	} else {
> +		memhp_range.start = 0;
> +		memhp_range.end = max_phys;
> +	}
> +	return memhp_range;
> +}
> +EXPORT_SYMBOL_GPL(memhp_get_pluggable_range);


-- 
Thanks,

David / dhildenb

