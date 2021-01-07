Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291E92ED5A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbhAGR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:29:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:60010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:29:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37078AD26;
        Thu,  7 Jan 2021 17:28:30 +0000 (UTC)
To:     Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
 <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
 <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
 <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
 <X/YY+mjpq15nmryI@redhat.com>
 <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-ID: <bd10e2dc-7a5e-835d-9a1f-9fff36cc22b5@suse.cz>
Date:   Thu, 7 Jan 2021 18:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 9:18 PM, Hugh Dickins wrote:
> On Wed, 6 Jan 2021, Andrea Arcangeli wrote:
>> 
>> I'd be surprised if the kernel can boot with BUG_ON() defined as "do
>> {}while(0)" so I guess it doesn't make any difference.
> 
> I had been afraid of that too, when CONFIG_BUG is not set:
> but I think it's actually "if (cond) do {} while (0)".

It's a maze of configs and arch-specific vs generic headers, but I do see this
in include/asm-generic/bug.h:

#else /* !CONFIG_BUG */
#ifndef HAVE_ARCH_BUG
#define BUG() do {} while (1)
#endif

So seems to me there *are* configurations possible where side-effects are indeed
thrown away, right?

WARN_ON is different as the result of the "inner" condition should be further
usable for constructing "outer" conditions:

(still in !CONFIG_BUG section)
#ifndef HAVE_ARCH_WARN_ON
#define WARN_ON(condition) ({
        int __ret_warn_on = !!(condition);
        unlikely(__ret_warn_on);
})
#endif

For completeness let's look at our own extensions when VM_DEBUG is disabled,
which is quite analogical to disabling CONFIG_BUG and thus it should better be
consistent with the generic stuff.

#define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)

where BUILD_BUG_ON_INVALID generates no code, so it's consistent with BUG_ON()
and !CONFIG_BUG.

#define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)

... well that's not consistent with WARN_ON. Hmm if you have asked me before I
checked, I would have said that it is, that I checked it already in the past
and/or there was some discussion already about it. Memory is failing me it
seems. We should better fix this?
