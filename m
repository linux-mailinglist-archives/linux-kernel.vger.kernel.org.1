Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23BB2E776F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 10:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgL3J3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 04:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgL3J3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 04:29:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCABC061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 01:28:40 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ae9002293c057202a1917.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e900:2293:c057:202a:1917])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04C391EC01A2;
        Wed, 30 Dec 2020 10:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609320516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nKgeKVqU8mgDOBuMQbvh+ddBpLTb7o0A4tFaInFknVM=;
        b=rY/mi3thZ4rOzp5knQ3XNjGCQtAvt0fAVaAp3olBksq/avDTVwkMdCPaxIFzMyHvwCwSOH
        ZQxgU4RTBynJgh0cvoa/YVL5HENnGzGXfw0VIAqaoqs9+3CQP3GnyVDbJTQKLIpmL0Kr86
        vDe5B7X9Eq0DkI6qwprj1V0qy3IBX8w=
Date:   Wed, 30 Dec 2020 10:28:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/19] x86/insn: Add an insn_decode() API
Message-ID: <20201230092833.GE22022@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-4-bp@alien8.de>
 <20201228101510.49082d470ed328d81486ef04@kernel.org>
 <20201229200654.GF29947@zn.tnic>
 <20201230180052.7e1931b4e1b17079023b65b7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201230180052.7e1931b4e1b17079023b65b7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 06:00:52PM +0900, Masami Hiramatsu wrote:
> Maybe I need to replace it with dummy lines but it is possible.

Dummy lines like "IGNORE DURING CHECK" or something like that?

> But in [17/19], your patch seems not using INSN_MODE_KERN there.

I replaced it only locally just so that I can cause the build error and
show you what mean.

I still haven't thought about what do to exactly there wrt making
sync-check.sh happy but the aspect of failing the build is a nice one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
