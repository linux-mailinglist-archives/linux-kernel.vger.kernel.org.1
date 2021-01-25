Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA61F30234D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAYJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbhAYJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611566761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6/jswR4CrTh5ueSvtZICDpwwRzG5pTUpdO+X4Pf0v0=;
        b=iJIKXGsfpTav+j5a5+dlkt5iXniWLsgBfvcTxpzJHX2Ilfugu4xzB/crO5/6LBLxV9ybJK
        1CGyYzKeYkuGyWWw5nGdpANIEv+FTERBK2ZTS8RbLGsGSJcwILlmEV/0Ir8moLnTzXqi3O
        uqsZCYoipUrNbIUr01rdn8omgFrKDSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-CGWrMwHjOmOEk2K_2ZricQ-1; Mon, 25 Jan 2021 04:25:56 -0500
X-MC-Unique: CGWrMwHjOmOEk2K_2ZricQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49693BBEE1;
        Mon, 25 Jan 2021 09:25:54 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1228704DA;
        Mon, 25 Jan 2021 09:25:51 +0000 (UTC)
Subject: Re: [PATCH V4 0/4] mm/memory_hotplug: Pre-validate the address range
 with platform
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
References: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c60ecbed-9073-83f9-e9e2-1f79a80cfe44@redhat.com>
Date:   Mon, 25 Jan 2021 10:25:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 03:58, Anshuman Khandual wrote:
> This series adds a mechanism allowing platforms to weigh in and prevalidate
> incoming address range before proceeding further with the memory hotplug.
> This helps prevent potential platform errors for the given address range,
> down the hotplug call chain, which inevitably fails the hotplug itself.
> 
> This mechanism was suggested by David Hildenbrand during another discussion
> with respect to a memory hotplug fix on arm64 platform.
> 
> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> This mechanism focuses on the addressibility aspect and not [sub] section
> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
> have been left unchanged. Wondering if all these can still be unified in
> an expanded memhp_range_allowed() check, that can be called from multiple
> memory hot add and remove paths.
> 
> This series applies on v5.11-rc5 and has been tested on arm64. But only
> build tested on s390.
> 

Note that this fails to apply right now to both, -next and Linus' tree.
Do you have a branch with he patches on top I can use for a quick test?
Thanks

-- 
Thanks,

David / dhildenb

