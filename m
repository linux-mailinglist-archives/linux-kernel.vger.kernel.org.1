Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7F2926D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgJSLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgJSLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603108495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syJyp0LZAACFoq8I2v22ukFUQBSHrf8TktVNFyazXaM=;
        b=NKc+eQg40hb5VyDZ0jACx6jOtv/LayqfyqvFHXpIGF/9GY0LvjpmcH2r/9Iz+tZ6h1CUb6
        zl1KuxGWVBgdkw1FS5xoPCOOhYgH2EKBQtaPDDC4/mY6w1sD9n0dWWKR6oUiwmCIZiljfp
        czWj0mUoT/jy/F0xUNe+jp8lQFcLeWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-PE9Of15rPs6GGKWQecEMog-1; Mon, 19 Oct 2020 07:54:51 -0400
X-MC-Unique: PE9Of15rPs6GGKWQecEMog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F3418A8220;
        Mon, 19 Oct 2020 11:54:50 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 185AD6EF41;
        Mon, 19 Oct 2020 11:54:46 +0000 (UTC)
Subject: Re: [PATCH v3] mm/compaction: Rename 'start_pfn' to
 'iteration_start_pfn' in compact_zone()
To:     yanfei.xu@windriver.com, akpm@linux-foundation.org, vbabka@suse.cz,
        pankaj.gupta.linux@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201019115044.1571-1-yanfei.xu@windriver.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2dfd5820-ca92-8a73-6dcb-00b6ce6c735a@redhat.com>
Date:   Mon, 19 Oct 2020 13:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019115044.1571-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.20 13:50, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> There are two 'start_pfn' declared in compact_zone() which have
> different meaning. Rename the second one to 'iteration_start_pfn'
> to prevent confusion.
> 
> BTW, remove an useless semicolon.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> Acked-by: David Hildenbrand <david@redhat.com>

^ huh, where does that come from? (you should only add acks in case they
were explicitly spelled out)

Anyhow, now you can keep it :)

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

