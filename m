Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4928BF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbgJLRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403847AbgJLRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:31:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001CEC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:31:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f06920038fd325cadbd10b1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:38fd:325c:adbd:10b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD8501EC01A8;
        Mon, 12 Oct 2020 19:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602523912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bdy1pg9LVAMjv4RO3g1JHBD2SkOs8SmWUeoiykTSBTQ=;
        b=C5afNOhmXMGzkF0hi3hJsbM79E2i/sxydVo/Wv7PGpWRDQ52JykSode1ONGWV9gCqj9zV1
        gJjquRvz5q4HZzLXE1F/9JcLfGYPpPBx688ZZTptnuKt8tyZ+qMGhbBOkR3RAdqy1c2mmY
        TdtCC5V4C98rGJmJOgSNYGw4HOe31P4=
Date:   Mon, 12 Oct 2020 19:31:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201012173142.GI22829@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
 <20201010105421.GA24674@zn.tnic>
 <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
 <20201010161112.GC24674@zn.tnic>
 <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
 <20201012142148.GA22829@zn.tnic>
 <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
 <20201012171544.GH22829@zn.tnic>
 <5590cd3df8b28cdd077230dda8c99e80436bdcf3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5590cd3df8b28cdd077230dda8c99e80436bdcf3.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:17:56AM -0700, Joe Perches wrote:
> Workie here.  This is against -next.

Nevermind - I had an old version in that branch.

What I mind to, however, is:

"adding a mechanism to only emit the message once per patched file (Joe)"

This needs to happen for every .byte line which doesn't have a comment
documenting the binutils version.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
