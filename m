Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170292D7441
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbgLKKyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393762AbgLKKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:53:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90121C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:52:49 -0800 (PST)
Received: from zn.tnic (p200300ec2f124300842c3ac7434c2bbe.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4300:842c:3ac7:434c:2bbe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F3601EC054C;
        Fri, 11 Dec 2020 11:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607683964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r6SbIby0tCi5n3+lBTtrIfB2uWYI+C8Vf+ID5lGli7w=;
        b=rbOXbDIb5Cl+3hk09P5FLvGQSJVPvQC68sx0xVVgxxGkMnOI+cZghJo/EirzWM9nEMTGQH
        m0OE8LADOiw56Uc6EclLwpLKqMNlIh3RnLtTV3LQDs8P+PLQy2ALwYENr6z6qFJBwefXi4
        NQAzW5ehVpryr9pAm5oKsiUmzHz8H4M=
Date:   Fri, 11 Dec 2020 11:52:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ying-Tsun Huang <ying-tsun.huang@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Toshi Kani <toshi.kani@hp.com>, linux-kernel@vger.kernel.org,
        Dmitry Lapik <dmitry.kolyadintsev@nyriad.com>,
        James Lee <James.Lee@amd.com>
Subject: Re: [PATCH] x86/mtrr: Correct the returned MTRR type of
 mtrr_type_lookup.
Message-ID: <20201211105239.GA25974@zn.tnic>
References: <20201207061227.131580-1-ying-tsun.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207061227.131580-1-ying-tsun.huang@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:12:26PM +0800, Ying-Tsun Huang wrote:
> In mtrr_type_lookup, if the input memory address region is not in the
> MTRR, over 4GB, and not over the top of memory, write-back attribute
> is returned. These condition checks are for ensuring the input memory
> address region is mapped to the physical memory actually.
> 
> However, if the end address is just aligned with the top of memory,
> the condition check treats the address is over the top of memory, and
> write-back attribute is not returned.

Oh fun. So to make sure I understand this correctly end ends up equal to
TOM2?

> There is a real case of NVDIMM. The nd_pmem module tries to map
> NVDIMMs as cacheable memories when NVDIMMs are connected. If a NVDIMM
> is the last of the DIMMs, the performance of this NVDIMM becomes very
> low since it aligned with the top of memory and its memory type is
> uncached-minus.
> 
> To check the top of memory should use "<=" instead of "<" since both the
> input end address and the value of top of memory are actually the start
> of next region.

Right, so looking at that function, it calls
mtrr_type_lookup_variable(), among others, and that does:

        /* Make end inclusive instead of exclusive */
        end--;

which sounds to me like it expects ranges with exclusive end.

So maybe it would be better to do something like:

	/*
	 * Blurb about end address being == tom2, perhaps give your example
	 */
	end--;

above the check so that it is absolutely obvious why this is done.

But but, looking at this more, the PPR says about TOM2:

"This value is normally placed above 4G. From 4G to TOM2 - 1 is DRAM;
TOM2 and above is MMIO."

So the check is *actually* correct - TOM2 - 1 is DRAM so you need '<'.

Unless you do end-- before, which would make sense and suggest the end
decrement to be the proper fix.

Hmm?

> Fixes: b73522e0c1be ("x86/mm/mtrr: Enhance MTRR checks in kernel mapping
> helpers")

I think you mean:

35605a1027ac ("x86: enable PAT for amd k8 and fam10h")

which first added that check.

Btw, while doing git archeology, I saw that mtrr_type_lookup() used to do end--
on function entry, see

2e5d9c857d4e ("x86: PAT infrastructure patch")

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
