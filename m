Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9212C6A98
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbgK0R14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbgK0R1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:27:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB34C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:27:54 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ffb00878263292141260f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:fb00:8782:6329:2141:260f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 495301EC03EA;
        Fri, 27 Nov 2020 18:27:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606498072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LyNhbUhHmmRmZ2J7NLIbiLk8gD19KKbHGGUM+mvUJvE=;
        b=Db6cVXjyi7AxPGY4RwJJcG0+MrRYyOT2CsixwXdDhow4fW4taN7DxToTWsCl2Hu0ypwWHU
        v6WQVdgTvMNFVNC9sK1sQD4veh7KLXX67zDYA+Ue3u3iljom6FpqaZ9N+YhIwQIg/VU3i/
        vLSkD2/UpgvYI+9osAHIf0vV+qrNxTI=
Date:   Fri, 27 Nov 2020 18:27:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Message-ID: <20201127172747.GE13163@zn.tnic>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127171324.1846019-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 12:13:24PM -0500, Arvind Sankar wrote:
> Commit
>   26bfa5f89486 ("x86, amd: Cleanup init_amd")
> moved the code that remaps the TSEG region using 4k pages from
> init_amd() to bsp_init_amd().
> 
> However, bsp_init_amd() is executed well before the direct mapping is
> actually created:
> 
>   setup_arch()
>     -> early_cpu_init()
>       -> early_identify_cpu()
>         -> this_cpu->c_bsp_init()
> 	  -> bsp_init_amd()
>     ...
>     -> init_mem_mapping()
> 
> So the change effectively disabled the 4k remapping, because
> pfn_range_is_mapped() is always false at this point.
> 
> It has been over six years since the commit, and no-one seems to have
> noticed this, so just remove the code. The original code was also
> incomplete, since it doesn't check how large the TSEG address range
> actually is, so it might remap only part of it in any case.

Yah, and the patch which added this:

6c62aa4a3c12 ("x86: make amd.c have 64bit support code")

does not say what for (I'm not surprised, frankly).

So if AMD folks on Cc don't have any need for actually fixing this
properly, yap, we can zap it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
