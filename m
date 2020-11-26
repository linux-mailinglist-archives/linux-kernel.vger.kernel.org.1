Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09572C5B10
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391717AbgKZRuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:50:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55248 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391703AbgKZRuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:50:12 -0500
Received: from zn.tnic (p200300ec2f0c9000558d893f9f23e622.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9000:558d:893f:9f23:e622])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 903171EC052C;
        Thu, 26 Nov 2020 18:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606413011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TFBaPE/59PUisuP5Jr1xOLhHgIQreYrv3I3FFX6vBu4=;
        b=SbEwPl78HwEcsNV/D28/O89ukV82vxanhmjDGfL+6xlIf/UG7plRasp7j0W9kpUJceBQKl
        QVpGKJRfZpa3/kMJboAV419OSc8/0d8PAQI2qkxTt1j0HQQXtI0032oc7+3AvFgwN5rER2
        chYGVI3WlEdMSZxzPpGMJvfzIPRpIdI=
Date:   Thu, 26 Nov 2020 18:50:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 03/19] x86/insn: Add an insn_decode() API
Message-ID: <20201126175011.GE31565@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
 <20201124101952.7909-4-bp@alien8.de>
 <20201126015333.fb0fb2b548013073ce72f19f@kernel.org>
 <20201125192553.GD9996@zn.tnic>
 <20201126103709.23d581fe2320f14a272a7dc5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201126103709.23d581fe2320f14a272a7dc5@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:37:09AM +0900, Masami Hiramatsu wrote:
> BTW, the instruction validation depends on who needs it, because to
> check the all invalid ops, we need more information in the x86-opcode-map.txt
> and it will bloat up the table size and consumes more time to analysis.

Yes, the decoder is supposed to serve the kernel's needs, not be a
general purpose one.

> (Moreover, it depends on the processor generation -- older processor will
> not support VEX prefix, those are invalid)

Why does the processor VEX support matter? Isn't the decoder supposed to
decode any instruction it knows about, regardless of the CPU it runs on?

> OK, then could you use -1 instead of 1? It may allow us to expand it
> to return error code in the future.

Ok, sure.

> I think insn_get_prefixes() can be used independently, because x86
> perfix bytes is very complex.

Yah, it all depends on what API interfaces we want to give to users and
make those other helpers internal. Time and usecases will tell.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
