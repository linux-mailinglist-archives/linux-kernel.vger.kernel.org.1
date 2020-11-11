Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C92AF554
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKKPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbgKKPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605109562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFd0xnL5a+IZvN8ji1/QqsjNX1XRBq54vvQbTwdL5a4=;
        b=fNeK85q3M3QraFYE3ITZySrbxEwx3BdoQXJokI9QKA88syChQHqJB/lZZjqWWYZi2musIk
        7o5NJrviUqQrDkeyugqJAFoLGrmqJYjNySHzcR2yi8DhkZOZq6v3xUtx9xrSwGj6F3qqAZ
        FktHaSv5Ow7EVDZEkv2W7HsAIFqVhKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-SBjbbip8Pl2g2vpd0yvKcQ-1; Wed, 11 Nov 2020 10:45:58 -0500
X-MC-Unique: SBjbbip8Pl2g2vpd0yvKcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 992158049F5;
        Wed, 11 Nov 2020 15:45:56 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2E0A1002F13;
        Wed, 11 Nov 2020 15:45:54 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>
References: <20201103152237.9853-1-vbabka@suse.cz>
 <20201103152237.9853-6-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <74868d3b-1435-08be-a01e-00bf69099064@redhat.com>
Date:   Wed, 11 Nov 2020 16:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201103152237.9853-6-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.20 16:22, Vlastimil Babka wrote:
> CONFIG_PAGE_POISONING_ZERO uses the zero pattern instead of 0xAA. It was
> introduced by commit 1414c7f4f7d7 ("mm/page_poisoning.c: allow for zero
> poisoning"), noting that using zeroes retains the benefit of sanitizing content
> of freed pages, with the benefit of not having to zero them again on alloc, and
> the downside of making some forms of corruption (stray writes of NULLs) harder
> to detect than with the 0xAA pattern. Together with
> CONFIG_PAGE_POISONING_NO_SANITY it made possible to sanitize the contents on
> free without checking it back on alloc.
> 
> These days we have the init_on_free() option to achieve sanitization with
> zeroes and to save clearing on alloc (and without checking on alloc). Arguably
> if someone does choose to check the poison for corruption on alloc, the savings
> of not clearing the page are secondary, and it makes sense to always use the
> 0xAA poison pattern. Thus, remove the CONFIG_PAGE_POISONING_ZERO option for
> being redundant.

I agree, this simplifies things ... and I don't see a need to complicate 
things to speed up corner-case debug mechanisms. Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

