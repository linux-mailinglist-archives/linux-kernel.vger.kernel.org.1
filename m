Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A452E7356
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgL2UJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 15:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL2UJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 15:09:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754EDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:09:07 -0800 (PST)
Received: from zn.tnic (p2e584e83.dip0.t-ipconnect.de [46.88.78.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02F721EC0283;
        Tue, 29 Dec 2020 21:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609272546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kytpee8mXqHtNcQ2rK6Yms3E/y+vj/qEoJTyvA0gvg=;
        b=XClL5x8Dil7gqRqyHpNUzDYeHv7xufd1xfJXLe6YLDKAuarB/SlebJOFPgDWD5J4FjnEmk
        FUEoJuwemmVbivAQJ/Iez8TxG1vOpePR2SQkGK7wTeofqXQEKMlruPErWmsMuczs2d4/6q
        Adq3hv8I8VnzgZ0qayfb7tW9gl0+MDg=
Date:   Tue, 29 Dec 2020 21:06:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/19] x86/insn: Add an insn_decode() API
Message-ID: <20201229200654.GF29947@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-4-bp@alien8.de>
 <20201228101510.49082d470ed328d81486ef04@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228101510.49082d470ed328d81486ef04@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:15:10AM +0900, Masami Hiramatsu wrote:
> BTW, insn_decode() can return -EINVAL if !insn_complete(), is that OK?

It does with this change. Or are you asking whether it returning -EINVAL
in that case is ok?

I don't see why not - this way callers can differentiate where it failed
- at fetching bytes with -ENODATA or it wasn't decoded completely -
-EINVAL.

> I think tools clone code must not use INSN_MODE_KERN because the tools may
> not use kernel Kconfig.
> 
> Hmm, this may be better to make a different patch to introduce a NOSYNC tag
> for sync checker in the tools. Something like;

I'd actually prefer this:

diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index f8772b371452..545320c67855 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -98,8 +98,6 @@ extern int insn_get_length(struct insn *insn);
 enum insn_mode {
        INSN_MODE_32,
        INSN_MODE_64,
-       /* Mode is determined by the current kernel build. */
-       INSN_MODE_KERN,
        INSN_NUM_MODES,
 };
 

so that when a tool does use INSN_MODE_KERN, it would fail building:

In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
util/intel-pt-decoder/../../../arch/x86/lib/insn.c: In function ‘insn_decode’:
util/intel-pt-decoder/../../../arch/x86/lib/insn.c:751:11: error: ‘INSN_MODE_KERN’ undeclared (first use in this function); did you mean ‘INSN_MODE_64’?
  751 |  if (m == INSN_MODE_KERN)
      |           ^~~~~~~~~~~~~~
      |           INSN_MODE_64
util/intel-pt-decoder/../../../arch/x86/lib/insn.c:751:11: note: each undeclared identifier is reported only once for each function it appears in
  LD       arch/perf-in.o
util/intel-pt-decoder/intel-pt-insn-decoder.c: In function ‘intel_pt_get_insn’:
util/intel-pt-decoder/intel-pt-insn-decoder.c:163:37: error: ‘INSN_MODE_KERN’ undeclared (first use in this function); did you mean ‘INSN_MODE_64’?
  163 |  ret = insn_decode(&insn, buf, len, INSN_MODE_KERN);
      |                                     ^~~~~~~~~~~~~~
      |                                     INSN_MODE_64

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
