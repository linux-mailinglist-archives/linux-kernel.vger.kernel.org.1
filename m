Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2D2F1B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbhAKQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbhAKQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610383945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TT5nmDWi6LkHgnWEhMxL8P9sU/ossqA0nVC3Jti0BDE=;
        b=apfshiNMxc0gfCIjtcDl3lSaXoTdl8CHekzty9p4Gw4xpk8a7/xP7lf+ECXa7yJ7U1Yizs
        j3Tu+Bt7e21WzvS0IOsLriZAxpDiR9sXdlB/v90sEjSFKu0c5V0b0k8Vy1wzGMp9+fUN6O
        Hz2d7onIOdR6ufQvRI/f0BP9BmWJMt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-6bMbofalNa2CmOJ9E8mIOw-1; Mon, 11 Jan 2021 11:52:23 -0500
X-MC-Unique: 6bMbofalNa2CmOJ9E8mIOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F158418C89C4;
        Mon, 11 Jan 2021 16:52:21 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76E651899A;
        Mon, 11 Jan 2021 16:52:20 +0000 (UTC)
Subject: Re: [PATCH 1/5] mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <21932014-3027-8ad9-2140-f63500c641d7@redhat.com>
Date:   Mon, 11 Jan 2021 17:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217130758.11565-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.20 14:07, Oscar Salvador wrote:
> In order to use self-hosted memmap array, the platform needs to have
> support for CONFIG_SPARSEMEM_VMEMMAP and altmap.
> Currently, only arm64, PPC and x86_64 have the support, so enable those
> platforms with ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE.

"In the first version, only .... will support it".

I'd probably split off enabling it per architecture in separate patches
and the end of the series.

Apart from that looks good.

> 
> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE will be checked later on to see whether
> we can enable this feature or not.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>


-- 
Thanks,

David / dhildenb

