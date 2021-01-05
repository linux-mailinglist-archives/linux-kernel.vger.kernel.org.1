Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44AA2EA819
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhAEKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbhAEKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609840731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jEtueBz8ZOvS21YvDXkoHLYxQlQJlmCqkVMoZHehj0=;
        b=KuUkVBHISS+POQ5/+rUP1N4ryxGI9s4wqL3JMSLsSxJbgLc0QmlzqcaqRcwshOtwdCCLiA
        +wUb5G9sK+3wPgz2Uf5KjDGaX6umeYEVXQZZ3Wf70QHhM2dZ3RpK4Pv3VeYrauQVs8pVUa
        WSKZueLQoHqXE6ltjHardapZV8Ys/jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-nLM0Vp2RMpScV7p3f5W1rA-1; Tue, 05 Jan 2021 04:58:49 -0500
X-MC-Unique: nLM0Vp2RMpScV7p3f5W1rA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DA00800D55;
        Tue,  5 Jan 2021 09:58:48 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3AFF60BE5;
        Tue,  5 Jan 2021 09:58:47 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
 <b5109800-a860-0f82-3e45-c0768cb1b038@redhat.com>
 <CAPcyv4jATooJTwXXGBvPrcCu57Ldt=6aBSEzaSqbwcHmczVaZg@mail.gmail.com>
 <dd49a67a-109e-b5c1-2010-572587fe4ed6@redhat.com>
 <CAPcyv4gMBvHwk6_QzpdKBwWZvRjaFYsN=0O8A9c39q2=CarqGA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fb87b533-d0b5-9b3a-8089-db81480b3e65@redhat.com>
Date:   Tue, 5 Jan 2021 10:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gMBvHwk6_QzpdKBwWZvRjaFYsN=0O8A9c39q2=CarqGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 10:56, Dan Williams wrote:
> On Tue, Jan 5, 2021 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> Yeah, obviously the first one. Being able to add+use PMEM is more
>>>> important than using each and every last MB of main memory.
>>>>
>>>> I wonder if we can just stop adding any system RAM like
>>>>
>>>> [     Memory Section    ]
>>>> [ RAM ] [      Hole     ]
>>>>
>>>> When there could be the possibility that the hole might actually be
>>>> PMEM. (e.g., with CONFIG_ZONE_DEVICE and it being the last section in a
>>>> sequence of sections, not just a tiny hole)
>>>
>>> I like the simplicity of it... I worry that the capacity loss
>>> regression is easy to notice by looking at the output of free(1) from
>>> one kernel to the next and someone screams.
>>
>> Well, you can always make it configurable and then simply fail to add
>> PMEM later if impossible (trying to sub-section hot-add into early
>> section). It's in the hands of the sysadmin then ("max out system ram"
>> vs. "support any PMEM device that could eventually be there at
>> runtime"). Distros would go for the second.
>>
>> I agree that it's not optimal, but sometimes simplicity has to win.
> 
> Here's where we left it last time, open to pfn_to_online_page hacks...
> 
> https://lore.kernel.org/linux-mm/CAPcyv4ivq=EPUePXiX2ErcVyF7+dV9Yv215Oue7X_Y2X_Jfw8Q@mail.gmail.com
> 

Yeah, I recall. That's why I favor simple approaches right now - less
brain power to waste ;)

> I don't think a slow-path flag in the mem-section is too onerous, but
> I'll withhold judgement until I have the patch I'm thinking of
> in-hand. Let me give it a shot, you can always nack the final result.

Sure!


-- 
Thanks,

David / dhildenb

