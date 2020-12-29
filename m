Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC952E733F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 20:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2Ti7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 14:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2Ti7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 14:38:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0907CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 11:38:19 -0800 (PST)
Received: from zn.tnic (p2e584e83.dip0.t-ipconnect.de [46.88.78.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A25341EC0136;
        Tue, 29 Dec 2020 20:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609270696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7Pz07GirIU52TpC23V5QKChtq4Cbswp8winxSzi17kM=;
        b=pd14Adq5dlGTGQE4RzF2RuIOoUz9DqWfllGElCsLHeeH5mOi4e77j6DbNCTqwP7xurebpF
        iHOszV+V3/vJTj7izh0M7+mwi1lmwo+wuGCqa+7a1ppnBsq7lxxMahnOx6/W6znTenQwvv
        WV+JEwXAb5uOsDyDA0OjRqTehiynE3o=
Date:   Tue, 29 Dec 2020 20:36:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/19] x86/insn: Rename insn_decode() to
 insn_decode_regs()
Message-ID: <20201229193605.GE29947@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-2-bp@alien8.de>
 <X+oTAiMqfoDe1GBg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X+oTAiMqfoDe1GBg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:16:50AM -0800, Sean Christopherson wrote:
> Can we add a preposition in there, e.g. insn_decode_from_regs() or
> insn_decode_with_regs()?  For me, "decode_regs" means "decode the register
> operands of the instruction".

"...from_regs" it is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
