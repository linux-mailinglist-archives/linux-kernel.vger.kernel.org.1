Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA49F290623
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407308AbgJPNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394872AbgJPNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602854236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppwECXXF9N8LusanMZ3Ph7brQG4uWGwjqD3v/E6A81c=;
        b=NSyBBHRBuPQt+ohyxJGepyaBFWRIMcyMXRCQ6+HaR2Q4ShJ09mWrZNotu3nihxpVDOclpf
        w7lnX6oJRu/DJHcXn2AsL9Tu8VGiohtoQ4lGS3UHHZIKlHS63PzU3F016+pE5cwbRteouw
        9Xel0rXMVXh2+jGg4S9CmJdQ+5YPy3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-vJtuXK49Osm8WkYjnAPuUw-1; Fri, 16 Oct 2020 09:17:13 -0400
X-MC-Unique: vJtuXK49Osm8WkYjnAPuUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0F008014D8;
        Fri, 16 Oct 2020 13:17:11 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 480E95D9D5;
        Fri, 16 Oct 2020 13:17:07 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7b55ffe1-95fc-1e71-ea6b-82bd0a98a6b4@redhat.com>
Date:   Fri, 16 Oct 2020 15:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016085319.GD44269@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.20 10:53, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:14PM +0200, David Hildenbrand wrote:
>> Let's rename to "sbs_per_mb" and "sb_size" and move accordingly.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> One trivial suggestion, could we move this patch close the data structure
> movement patch?
> 
> I know this would be some work, since you have changed some of the code logic.
> This would take you some time to rebase.

You mean after patch #17 ?

I guess I can move patch #18 (prereq) a little further up (e.g., after
patch #15). Guess moving it in front of #19 shouldn't be too hard.

Will give it a try - if it takes too much effort, I'll leave it like this.

Thanks!

-- 
Thanks,

David / dhildenb

