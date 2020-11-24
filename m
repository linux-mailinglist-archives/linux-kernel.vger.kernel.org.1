Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687582C2F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404006AbgKXRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403935AbgKXRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:46:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:46:53 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e3600ab9d18fd60f9afc5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:ab9d:18fd:60f9:afc5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DE011EC04E0;
        Tue, 24 Nov 2020 18:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606240012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8dJpjvvWO5pfa4XyOgzVakFgWDSeoQj+BLatQT9JhCo=;
        b=SXY6MlUA2R+/wPdnOwzE9bL99ry2dvmEyLzM8UkcCVpjOYWzI8lNrIGfbTCZiiuwUVMCcO
        dcRbG3pLU0Uq5Xi9En5FzGyl3LQezVS5R5b7HJUtTjf8uRsbaLr6kyoqSVc+yLFm+gTruW
        U8+Y17RoDFYGG8nBIPTUF2VYvSi473I=
Date:   Tue, 24 Nov 2020 18:46:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-ID: <20201124174647.GI4009@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:19:33AM +0100, Borislav Petkov wrote:
> In any case, at least the case where I give it
> 
> 0x48 0xcf 0x48 0x83
> 
> and say that buf size is 4, should return an error because the second
> insn is incomplete. So I need to go look at that now.

Ok, got it:

./arch/x86/tools/insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x826fdf9c)
insn buffer:
0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
supplied buf size: 15, ret 0
supplied buf size: 2, ret 0
supplied buf size: 3, ret 0
supplied buf size: 4, ret 0
supplied buf size: 1, ret -22

the current decoder simply decodes the *first* insn in the buffer it
encounters and that's it.

When you give it a buffer of size smaller than the first instruction:

supplied buf size: 1, ret -22

while the first insn is 2 bytes long:

0x48 0xcf (IRETQ)

then it signals an error.

Andy, does that work for your use cases?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
