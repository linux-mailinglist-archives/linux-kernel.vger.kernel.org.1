Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441C929DDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbgJ2AkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729273AbgJ2AkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603932010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KF3dZpaKBz60wjyXLMIZR7CSufQKGq5TkHGNntqeXuk=;
        b=b03p4lj0n9Sxlhknq5F1qSa3NZsXBCJtkuwREnM2lrREqUME/S9LFmck9pq/unFfCB5LbW
        aiYc7JrVeow5LaSyTSjiPDPSeoE7bABM+Px1aP4Eigrx/tD2riKY+OL9Kn0wRDVz0EB881
        wYCBXY0ncYRUVx0HBfmLG0QJyLGLsEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-QA3PlxqyPS-IH2Msm5Gj_A-1; Wed, 28 Oct 2020 04:38:29 -0400
X-MC-Unique: QA3PlxqyPS-IH2Msm5Gj_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE211084CA1;
        Wed, 28 Oct 2020 08:38:27 +0000 (UTC)
Received: from [10.36.114.138] (ovpn-114-138.ams2.redhat.com [10.36.114.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAF5A5C1D7;
        Wed, 28 Oct 2020 08:38:25 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm, page_alloc: reduce static keys in prep_new_page()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-4-vbabka@suse.cz>
 <93ab79df-cf8c-294b-3ed1-8a563e4a452b@redhat.com>
 <1fc7ec3a-367c-eb9f-1cb4-b9e015fea87c@suse.cz>
 <81faf3d6-9536-ff00-447d-e964a010492d@suse.cz>
 <38de5bb0-5559-d069-0ce0-daec66ef2746@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1d131524-6383-fb37-00e7-ba52ae6de66b@redhat.com>
Date:   Wed, 28 Oct 2020 09:38:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <38de5bb0-5559-d069-0ce0-daec66ef2746@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.20 18:41, Vlastimil Babka wrote:
> On 10/27/20 2:32 PM, Vlastimil Babka wrote:
>> So my conclusion:
>> - We can remove PAGE_POISONING_NO_SANITY because it only makes sense with
>> PAGE_POISONING_ZERO, and we can use init_on_free instead
> 
> Note for this we first have to make sanity checking compatible with
> hibernation, but that should be easy as the zeroing variants already
> paved the way. The patch below will be added to the next version of
> the series:
> 
>   From 44474ee27c4f5248061ea2e5bbc2aeefc91bcdfc Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 27 Oct 2020 18:25:17 +0100
> Subject: [PATCH] kernel/power: allow hibernation with page_poison sanity
>    checking
> 
> Page poisoning used to be incompatible with hibernation, as the state of
> poisoned pages was lost after resume, thus enabling CONFIG_HIBERNATION forces
> CONFIG_PAGE_POISONING_NO_SANITY. For the same reason, the poisoning with zeroes
> variant CONFIG_PAGE_POISONING_ZERO used to disable hibernation. The latter
> restriction was removed by commit 1ad1410f632d ("PM / Hibernate: allow
> hibernation with PAGE_POISONING_ZERO") and similarly for init_on_free by commit
> 18451f9f9e58 ("PM: hibernate: fix crashes with init_on_free=1") by making sure
> free pages are cleared after resume.
> 
> We can use the same mechanism to instead poison free pages with PAGE_POISON
> after resume. This covers both zero and 0xAA patterns. Thus we can remove the
> Kconfig restriction that disables page poison sanity checking when hibernation
> is enabled.

I haven't fully dived into the details, but the idea it sounds sane to me.


-- 
Thanks,

David / dhildenb

