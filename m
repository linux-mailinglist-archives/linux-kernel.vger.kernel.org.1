Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0E2926D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgJSL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgJSL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603108661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SlL4Q5SbHMhStfWfVjsxTibC0dKmqUQeioCU1eaaZw=;
        b=aM66he/J1IO02gxKdZxxMn2uk0d2fV32xL/qdKtx4h4U1cZc49eBnycU1LhLCZf2d2Z/9C
        hOCoJEVTQEnTV01b+vyymThJxn+NbsJwuQpgcpSZFHLI5LDMgLpHwisqibXvxnih2vfp+m
        p+tjZAA57NtsWaawlp+RjZEG2ZQ1wHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-6W0ZzrGiPiWqR5E7wegN8w-1; Mon, 19 Oct 2020 07:57:39 -0400
X-MC-Unique: 6W0ZzrGiPiWqR5E7wegN8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2D257088;
        Mon, 19 Oct 2020 11:57:37 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 959A56EF44;
        Mon, 19 Oct 2020 11:57:30 +0000 (UTC)
Subject: Re: [PATCH v1 20/29] virtio-mem: nb_sb_per_mb and subblock_size are
 specific to Sub Block Mode (SBM)
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-21-david@redhat.com>
 <20201016085319.GD44269@L-31X9LVDL-1304.local>
 <7b55ffe1-95fc-1e71-ea6b-82bd0a98a6b4@redhat.com>
 <20201018124104.GD50506@L-31X9LVDL-1304>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c5a22f50-210d-a4ab-90b0-ba3d454c1882@redhat.com>
Date:   Mon, 19 Oct 2020 13:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018124104.GD50506@L-31X9LVDL-1304>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.20 14:41, Wei Yang wrote:
> On Fri, Oct 16, 2020 at 03:17:06PM +0200, David Hildenbrand wrote:
>> On 16.10.20 10:53, Wei Yang wrote:
>>> On Mon, Oct 12, 2020 at 02:53:14PM +0200, David Hildenbrand wrote:
>>>> Let's rename to "sbs_per_mb" and "sb_size" and move accordingly.
>>>>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> One trivial suggestion, could we move this patch close the data structure
>>> movement patch?
>>>
>>> I know this would be some work, since you have changed some of the code logic.
>>> This would take you some time to rebase.
>>
>> You mean after patch #17 ?
> 
> Yes
> 
>>
>> I guess I can move patch #18 (prereq) a little further up (e.g., after
>> patch #15). Guess moving it in front of #19 shouldn't be too hard.
>>
>> Will give it a try - if it takes too much effort, I'll leave it like this.
>>
> 
> Not a big deal, while it will make the change more intact to me.
> 
> This is a big patch set to me. In case it could be split into two parts, like
> bug fix/logic improvement and BBM implementation, that would be more friendly
> to review.

I'll most probably keep it as a single series, but reshuffle the patches
into

1. cleanups
2. preparations
3. BBM

That should make things easier to digest. Thanks!

-- 
Thanks,

David / dhildenb

