Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7201302FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbhAYXPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732510AbhAYXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611616409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q73pb59lnjywOM942tBV2OcvzhYq24ztCSrUSq0hjQs=;
        b=fXwldKbC/BskI879iiAfGTbQAqXOGILBJkKoZEqXekTGE0fulhIYAstU9up+vFaDKIAUD0
        9d5m9tPFIRPiaiK/EA0z9KeRt8VS8irVhMbNfjApti9xL535O5HbYT0tXwOBfte5VG5so6
        zyYZ6GD8alI1LOHgCj4vmvZhd/hFmo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-KbqhHvVZORSmwIKRNBSxMQ-1; Mon, 25 Jan 2021 18:13:26 -0500
X-MC-Unique: KbqhHvVZORSmwIKRNBSxMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 547DE190B2A3;
        Mon, 25 Jan 2021 23:13:24 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-163.rdu2.redhat.com [10.10.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D055F9B7;
        Mon, 25 Jan 2021 23:13:22 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
References: <20210125042441.20030-1-longman@redhat.com>
 <3b3f2b56-e66a-db5e-8d8e-95f3812c6838@huawei.com>
 <4367cc87-1ebf-6df2-d2d4-939c548ca790@redhat.com>
 <20210125151111.0da207db337a575e5346bd08@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1b643acd-920a-665e-5ebe-e7413be381da@redhat.com>
Date:   Mon, 25 Jan 2021 18:13:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125151111.0da207db337a575e5346bd08@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 6:11 PM, Andrew Morton wrote:
> On Mon, 25 Jan 2021 09:12:56 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> Yes, this patch should go to stable. I think the stable tree maintainers
>> will automatically pick up patches with the "Fixes" tag. That is why I
>> don't explicitly put a "cc:stable" line in the patch.
> No.  Both the Fixes: and the cc:stable are needed for the backport.
> Because sometimes we fix things but don't consider the fix important
> enough to risk the backport.
>
I see. Thanks for the clarification. I will keep that in mind next time.

Cheers,
Longman

