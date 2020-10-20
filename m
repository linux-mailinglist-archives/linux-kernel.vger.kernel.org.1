Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34F2937AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392492AbgJTJJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730377AbgJTJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603184960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+L5ayBozlzNpAak89evI7ILSk5FhLqkqrPeP6jroHY=;
        b=XxCu3jOn8FGpVDNzwu4tkP8YgX+6TeQ1+DrHuah0CNnXN6OljGo0HSn7ls/AK2dw2PCcID
        Iy50jvPXMbOQNNpo+YBUqNZSK99r3d8QPZxo0xc+gPgglSsUIEJioUh24NDek85V8+SU8R
        go+e/Wj0y74x/0B8Ph4XUCTHj5jAPeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-OY9JcMAINeeDFDFSRZhq8Q-1; Tue, 20 Oct 2020 05:09:16 -0400
X-MC-Unique: OY9JcMAINeeDFDFSRZhq8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E79A56B55;
        Tue, 20 Oct 2020 09:09:15 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99D6C5B4A3;
        Tue, 20 Oct 2020 09:09:10 +0000 (UTC)
Subject: Re: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue
 when offlining memory
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
 <20201016040301.GJ86495@L-31X9LVDL-1304.local>
 <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
 <20201018035725.GA50506@L-31X9LVDL-1304>
 <5103e899-0ca2-0804-dee8-772b5737d34d@redhat.com>
 <20201020004130.GB61232@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b5f8164e-9441-a74c-778b-7a2b08eb6b90@redhat.com>
Date:   Tue, 20 Oct 2020 11:09:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020004130.GB61232@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> So, you'll keep retrying forever. Found while debugging that exact issue :)
>>
> 
> If this is the case, my suggestion is to record it in the changelog.
> Otherwise, we may lose this corner case which is important to this change.

Yes, already added it - thanks!


-- 
Thanks,

David / dhildenb

