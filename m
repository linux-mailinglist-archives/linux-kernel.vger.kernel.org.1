Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C22D3EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgLIJlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgLIJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607506820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sgyJMwSASjTecZOGvZIf8VWeLeZrfxFjHje5O8XyFg4=;
        b=IV3Y80ncQoFHCOwAlIlxITON8IgJIQ+wOAWQnAxG+OGr63VgG30YUl12jnYf/onNoV40Fa
        /jbNyZQbAoDZrlt+dPG4RyPreG88VcFcHXQkgom/hgBUNmZzltcMFGEBU8XmuAKNfW9Ua5
        MjCjDkRVVWta06Ih5XsPhT45nrLJ75M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-yMXEqtdzP4uOn4f_1jyWWg-1; Wed, 09 Dec 2020 04:40:16 -0500
X-MC-Unique: yMXEqtdzP4uOn4f_1jyWWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0AD192D799;
        Wed,  9 Dec 2020 09:40:15 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D07585D6D5;
        Wed,  9 Dec 2020 09:40:13 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/4] mm,memory_hotplug: Add
 mhp_supports_memmap_on_memory
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-2-osalvador@suse.de>
 <c5b82d52-f1be-0701-e36b-49aae4bb5cdb@redhat.com>
 <20201209093608.GA30590@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5809e56e-363b-abe4-7b95-08768c6a4b32@redhat.com>
Date:   Wed, 9 Dec 2020 10:40:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209093608.GA30590@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.20 10:36, Oscar Salvador wrote:
> On Wed, Dec 02, 2020 at 10:36:54AM +0100, David Hildenbrand wrote:
>> Instead of adding these arch callbacks, what about a config option
>>
>> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>>
>> that gets selected by the archs with CONFIG_SPARSEMEM_VMEMMAP ?
>>
>> The mhp_supports_memmap_on_memory() becomes even more trivial.
> 
> I think that would not be enough.
> E.g: s390x supports CONFIG_SPARSEMEM_VMEMMAP but it does not support
> altmap (and maybe other arches I did not check too).
> That is why I was careful in choosing the ones that a) supports
> CONFIG_SPARSEMEM_VMEMMAP and b) support altmap

Sorry if I was unclear, s390x will simply not set
ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE.

-- 
Thanks,

David / dhildenb

