Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A832732ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIUTff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:35:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D86C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:35:34 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e30076607a950172f225.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:7660:7a95:172:f225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DE6E1EC0328;
        Mon, 21 Sep 2020 21:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600716933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fScbz9wqHd33fI9LUntoRj5Fv18CV5ns+8IWtXmJEUg=;
        b=E4EqF/30RegUqKTQblKkkD3zU15Jqb3OAVpPxCYHNVKGX1B0X66KAC0kTeyGURH7YNbc0u
        6aI3HkERpIG7y8k24qEU1p4qF8CTCwu3MDe/vJI1YtVhEfV4HnhrJMa2C4hfmw8u5NNTcz
        PpybMEiFxDu69lgaCppSu4OBVBFsgoo=
Date:   Mon, 21 Sep 2020 21:35:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/vector: print_APIC_field - use print_hex_dump_debug
Message-ID: <20200921193527.GL5901@zn.tnic>
References: <aa7e8d27a46e3a54a7eb8854134849979bd1eaa0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa7e8d27a46e3a54a7eb8854134849979bd1eaa0.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:10:38PM -0700, Joe Perches wrote:
> Convert the printk(KERN_DEBUG) / pr_cont uses to print_hex_dump_debug.
> 
> Output is now single line with spaces between output u32s.
> 
> ---
>  arch/x86/kernel/apic/vector.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Forgot to use checkpatch on your patch:

$ ./scripts/checkpatch.pl /tmp/joe
ERROR: Missing Signed-off-by: line(s)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
