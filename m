Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB102CD1BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbgLCIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:49:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbgLCItn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:49:43 -0500
Received: from zn.tnic (p200300ec2f0dc500e3882204d739572d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:e388:2204:d739:572d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 300571EC026D;
        Thu,  3 Dec 2020 09:49:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606985342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wciX2sqmkKnCFIOTGue0UOfTrzEeO6CrdHGcxftFpKM=;
        b=j11g2Z8Or2M6b1uWfWb8AbiQakzKP535DOz05VnUYk+/Feac3q8UMnbE/+kdl2ZCY4VUC7
        SwTZ4l7eEa+IHWapp/vw4hMKqn1BskzuXxppqvOy4iQe6CAf0wWQUubZ3QliLMvn3+xfjK
        ihEsCdsJXyt0iUHoo86kXrBOcIOM5VE=
Date:   Thu, 3 Dec 2020 09:48:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Pu Wen <puwen@hygon.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Message-ID: <20201203084857.GD3059@zn.tnic>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
 <20201127172747.GE13163@zn.tnic>
 <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
 <X8gWAJ+Pc6KxfYEB@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8gWAJ+Pc6KxfYEB@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:32:32PM -0500, Arvind Sankar wrote:
> The pfn_range_is_mapped() call just checks whether it is mapped at all
> in the direct mapping. Is the TSEG range supposed to be marked as
> non-RAM in the E820 map? AFAICS, the only case when a direct mapping is
> created for non-RAM is for the 0-1Mb real-mode range, and that will
> always use 4k pages. Above that anything not marked as RAM will create
> an unmapped hole in the direct map, so in this case the memory just
> below the TSEG base would already use smaller pages if needed.
> 
> If it's possible that the E820 mapping says this range is RAM, then
> should we also break up the direct map just after the end of the TSEG
> range for the same reason?

So I have a machine where TSEG is not 2M aligned and somewhere in the 1G
range:

[    1.135094] tseg: 003bf00000

It is not in the E820 map either:

[    0.019784] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.020014] init_memory_mapping: [mem 0x3bc00000-0x3bdfffff]
[    0.020166] init_memory_mapping: [mem 0x20000000-0x3bbfffff]
[    0.020327] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.020677] init_memory_mapping: [mem 0x3be00000-0x3be8ffff]

That doesn't mean that it can happen that there might be some
configuration where it ends up being mapped.

So looking at what the code does, it kinda makes sense: you want the 2M
range between 0x3be00000 and 0x3c000000 to be split into 4K mappings,
*if* it is mapped.

I need to find a box where it is mapped *and* not 2M aligned, though,
for testing. Which appears kinda hard to do as all the new ones are
aligned.

The above is from a K8 box which should already be dead, as a matter of
fact.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
