Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0493026F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbhAYPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbhAYO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:59:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB0C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:59:13 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db0095810f165069682a.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:9581:f16:5069:682a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A2241EC0572;
        Mon, 25 Jan 2021 15:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611586752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H1lt6BqMznE4SchYbIuclVKLnxqPlbAP3RCfbMs7uhI=;
        b=qkQ95WmU512S2Kp3vzvVX+I6j4AOlTi4F+EKMdsp3Ox4mkTGc0uTIaG3oGNOfzBTrpLxbp
        HK0CUC54QGmIcz7qBJHP7sbkC7nlfrTRrx8P7CABfM5xOuIH4bkJvGwb7y6C9u82swJSUN
        rAt0uH8NiwP0Fyl9a5ONCsPv62rHziU=
Date:   Mon, 25 Jan 2021 15:59:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/setup: consolidate early memory reservations
Message-ID: <20210125145911.GF23070@zn.tnic>
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115083255.12744-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:32:54AM +0200, Mike Rapoport wrote:
> +	trim_low_memory_range();

Btw, you can get rid of that one too:

/*
 * Here we put platform-specific memory range workarounds, i.e.
 * memory known to be corrupt or otherwise in need to be reserved on
 * specific platforms.
 *
 * If this gets used more widely it could use a real dispatch mechanism.
 */
static void __init trim_platform_memory_ranges(void)
{
        trim_snb_memory();
}

yeah, yeah, we can do a real dispatch mechanism but we didn't need one
since 2012 so I guess we can get rid of trim_platform_memory_ranges()
and call trim_snb_memory() directly and simplify it even more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
