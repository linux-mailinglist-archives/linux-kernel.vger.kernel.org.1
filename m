Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6CF2EA7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbhAEJjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbhAEJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609839463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JB+GylXXOsFZLBr2+X54dETYWqMoYOjPzlJVxocFmj4=;
        b=ci5ly8OJFjKLEx/+EtTdaUJXIm8Am/QgtHAYqoaISOE/dFwnLU9v1q778yl+PyMu1KRW0J
        1HnuFI1dNJLhIm6luZsAVH6uWHAue1ya+4prVpQn2nsx5/bsHztrdRZcdvH9E2kPAy0oac
        QrDuZ/1/o9qbq1VWNvYNR2ltvCp5RKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-kFtvb3y5P3arydwG1Nq_Jw-1; Tue, 05 Jan 2021 04:37:41 -0500
X-MC-Unique: kFtvb3y5P3arydwG1Nq_Jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B1821966320;
        Tue,  5 Jan 2021 09:37:40 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A3A9722C1;
        Tue,  5 Jan 2021 09:37:39 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
 <b5109800-a860-0f82-3e45-c0768cb1b038@redhat.com>
 <CAPcyv4jATooJTwXXGBvPrcCu57Ldt=6aBSEzaSqbwcHmczVaZg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dd49a67a-109e-b5c1-2010-572587fe4ed6@redhat.com>
Date:   Tue, 5 Jan 2021 10:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jATooJTwXXGBvPrcCu57Ldt=6aBSEzaSqbwcHmczVaZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yeah, obviously the first one. Being able to add+use PMEM is more
>> important than using each and every last MB of main memory.
>>
>> I wonder if we can just stop adding any system RAM like
>>
>> [     Memory Section    ]
>> [ RAM ] [      Hole     ]
>>
>> When there could be the possibility that the hole might actually be
>> PMEM. (e.g., with CONFIG_ZONE_DEVICE and it being the last section in a
>> sequence of sections, not just a tiny hole)
> 
> I like the simplicity of it... I worry that the capacity loss
> regression is easy to notice by looking at the output of free(1) from
> one kernel to the next and someone screams.

Well, you can always make it configurable and then simply fail to add
PMEM later if impossible (trying to sub-section hot-add into early
section). It's in the hands of the sysadmin then ("max out system ram"
vs. "support any PMEM device that could eventually be there at
runtime"). Distros would go for the second.

I agree that it's not optimal, but sometimes simplicity has to win.

-- 
Thanks,

David / dhildenb

