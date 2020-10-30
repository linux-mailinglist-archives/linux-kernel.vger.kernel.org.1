Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25D32A0634
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgJ3NH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3NH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:07:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68476C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:07:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c8000d91be9ab8def3715.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8000:d91b:e9ab:8def:3715])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5196A1EC0489;
        Fri, 30 Oct 2020 14:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604063242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VgvJcU+pd41uDgd6MEikLWeoDHldRBQaktu2xQKIa18=;
        b=RxVhDRgGXeE2PJvLCQ+6fb5x2574USaZQ67M4+ggOy6M/H9+MgbFewSZZ8xxrwtnOw7+WH
        ZRXazcJ5ue419ZaixYh32B7ynf74AhrWBZdqVJQB+BcVBTRBDeuSyDWaEH3nuPWw46skBq
        dxazMjVPeGV2ZyRRLvIbZH4fm1zlQCs=
Date:   Fri, 30 Oct 2020 14:07:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201030130713.GB6532@zn.tnic>
References: <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic>
 <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org>
 <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
 <20201023232741.GF23324@zn.tnic>
 <20201029124231.GB31903@zn.tnic>
 <20201030102453.73ed996eb4ec9b242d4138b2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030102453.73ed996eb4ec9b242d4138b2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:24:53AM +0900, Masami Hiramatsu wrote:
> What's the objdump say here?

The expected "bad":

   0:   c5 ec 95                (bad)
   3:   b2 02                   mov    $0x2,%dl
   5:   bd 4b c8 a8 36          mov    $0x36a8c84b,%ebp
   a:   b2 c5                   mov    $0xc5,%dl
   c:   c0 df 13                rcr    $0x13,%bh

> Yes, in this case, we would better to handle it as an undecodable input
> instead of access violation in insn_sanity.

Ok, good. I've got the hunk below now and it does the right thing. The
whole patch has become huuge now, lemme split it finally. :)

Thx.

---
diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index 185ceba9d289..f20765beec9c 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -222,8 +224,8 @@ static void parse_args(int argc, char **argv)
 
 int main(int argc, char **argv)
 {
+       int insns = 0, ret;
        struct insn insn;
-       int insns = 0;
        int errors = 0;
        unsigned long i;
        unsigned char insn_buff[MAX_INSN_SIZE * 2];
@@ -241,15 +243,15 @@ int main(int argc, char **argv)
                        continue;
 
                /* Decode an instruction */
-               insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-               insn_get_length(&insn);
+               ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+                                 x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 
                if (insn.next_byte <= insn.kaddr ||
                    insn.kaddr + MAX_INSN_SIZE < insn.next_byte) {
                        /* Access out-of-range memory */
                        dump_stream(stderr, "Error: Found an access violation", i, insn_buff, &insn);
                        errors++;
-               } else if (verbose && !insn_complete(&insn))
+               } else if (verbose && ret < 0)
                        dump_stream(stdout, "Info: Found an undecodable input", i, insn_buff, &insn);
                else if (verbose >= 2)
                        dump_insn(stdout, &insn);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
