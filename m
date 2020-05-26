Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09901B5B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 14:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDWMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 08:22:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47478 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgDWMWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:22:13 -0400
Received: from zn.tnic (p200300EC2F0D2E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B57AA1EC0D27;
        Thu, 23 Apr 2020 14:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587644531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S2N8P4pdalpon6U3pQ+glPhfHT9z58j7kBQKbXloCSY=;
        b=h36WYByYIOJ4xDEyeDi1RqHv7Y+KRWL7wp4w4oQS0ODftttoCu9m1S6M/7mBgt+xaUbbb4
        t1V0G/crpOjyrO2XqqHk/zzvGlWcyH7vW6MeFI6uage67v8DmFAM/wFYPeW5GObakGy2HL
        pTe2dZffzrBdcmu7VvE5hOE5hv/+DaY=
Date:   Thu, 23 Apr 2020 14:22:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200423122208.GB26021@zn.tnic>
References: <72CCEEC2-FF21-437C-873C-4C31640B2913@alien8.de>
 <DD433C5F-2A08-4730-B039-8E0C25911D10@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DD433C5F-2A08-4730-B039-8E0C25911D10@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 07:21:50AM -0400, Qian Cai wrote:
> Cool. I can only advocate to take another closer look at this patchset
> (it looks like going to break PAE without the pgprotval_t fix),
> because bugs do cluster.

So, I took the pgprotval_t fix and tested it on two boxes. I'd
appreciate it if you ran tip:x86/mm on your machine too. tip-bot
notifications coming up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
