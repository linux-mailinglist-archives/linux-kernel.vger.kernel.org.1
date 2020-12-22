Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B412E0733
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLVI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608625699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMn1z+3qEykzQHkIqp2VNssqA3PWvgFfJWR1Q6w9VTw=;
        b=Q6Ut4ZFm2CQuB77sAXJG+EA2HOgYvQC7takHL5cvUqUPX3Tbnm6ySEV4/by7xfqY/aSIHS
        mu8HBT/p3KNb/8vci/rBGaUB9tCIZxu+nD89enWjIMFLTjG2u9hK/5HLnr3mnFYm+LoJtB
        hhLrCxRStiTX0HW++vo6GoWDizJvmIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Q9G-OknUPU6OWsvwirBTBg-1; Tue, 22 Dec 2020 03:28:14 -0500
X-MC-Unique: Q9G-OknUPU6OWsvwirBTBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C301107ACE8;
        Tue, 22 Dec 2020 08:28:12 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDF0C5D9D3;
        Tue, 22 Dec 2020 08:28:05 +0000 (UTC)
Subject: Re: [RFC PATCH 2/3] virtio-balloon: add support for providing free
 huge page reports to host
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
References: <20201222074810.GA30047@open-light-1.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6846ff7a-b302-a0fd-1cd9-af0f2ee733ea@redhat.com>
Date:   Tue, 22 Dec 2020 09:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222074810.GA30047@open-light-1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.20 08:48, Liang Li wrote:
> Free page reporting only supports buddy pages, it can't report the
> free pages reserved for hugetlbfs case. On the other hand, hugetlbfs

The virtio-balloon free page reporting interface accepts a generic sg,
so it isn't glue to buddy pages. There is no need for a new interface.


-- 
Thanks,

David / dhildenb

