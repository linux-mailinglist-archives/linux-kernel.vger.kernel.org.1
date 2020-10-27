Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33D29A88B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896559AbgJ0J63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:58:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896563AbgJ0J6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:58:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03F31B2BE;
        Tue, 27 Oct 2020 09:58:17 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm, page_alloc: do not rely on the order of
 page_poison and init_on_alloc/free parameters
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-2-vbabka@suse.cz>
 <3784dac7-49cb-006b-7b9d-1244d5c59935@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9a2b88de-3c01-21d0-69ff-08643f7c4b68@suse.cz>
Date:   Tue, 27 Oct 2020 10:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <3784dac7-49cb-006b-7b9d-1244d5c59935@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 10:03 AM, David Hildenbrand wrote:
> On 26.10.20 18:33, Vlastimil Babka wrote:
>> Enabling page_poison=1 together with init_on_alloc=1 or init_on_free=1 produces
>> a warning in dmesg that page_poison takes precendence. However, as these
>> warnings are printed in early_param handlers for init_on_alloc/free, they are
>> not printed if page_poison is enabled later on the command line (handlers are
>> called in the order of their parameters), or when init_on_alloc/free is always
>> enabled by the respective config option - before the page_poison early param
>> handler is called, it is not considered to be enabled. This is inconsistent.
>> 
>> We can remove the dependency on order by making the init_on_* parameters only
>> set a boolean variable, and postponing the evaluation after all early params
>> have been processed. Introduce a new init_mem_debugging() function for that,
>> and move the related debug_pagealloc processing there as well.
> 
> init_mem_debugging() is somewhat sub-optimal - init_on_alloc=1 or
> init_on_free=1 are rather security hardening mechanisms.

Well yeah, init_mem_debugging_and_hardening()?

> ... I wondered if this could be the place to initialize any kind of mm
> parameters in the future. Like init_mem_params() or so.

Maybe. In practice you often find out that different things have to be hooked in 
different points of the init process, and a single function might not be enough. 
I tried to group stuff that's really inter-related and can be initialized at the 
same time.

>> 
>> As a result init_mem_debugging() knows always accurately if init_on_* and/or
>> page_poison options were enabled. Thus we can also optimize want_init_on_alloc()
>> and want_init_on_free(). We don't need to check page_poisoning_enabled() there,
>> we can instead not enable the init_on_* tracepoint at all, if page poisoning is
>> enabled. This results in a simpler and more effective code.
> 
> LGTM
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!
