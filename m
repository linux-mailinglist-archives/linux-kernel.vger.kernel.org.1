Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9C2CECBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgLDLHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLDLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:07:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB3C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 03:06:51 -0800 (PST)
Received: from zn.tnic (p200300ec2f12b10051b9914976f7ce7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:b100:51b9:9149:76f7:ce7f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F9821EC03E4;
        Fri,  4 Dec 2020 12:06:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607080009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ob1+vVsNK6ggrVlFJRnYfrjPu0EHIhJSDo6NDRRpK1c=;
        b=doGb8t9N0hGYKbMewRreuGnp8+LlGUCdMcDZw+C8mkiCq+MCsrRVEaFz9qDdT7VltcJqh/
        P0tRXrmOx/qHN74fkO/Xcb9lKwnwjqIFq745Px33JKYxolPWvvUyJW2BrBwrwztj+3ys27
        /6VRLDHYAxGPswl0bfdYpD+B1+uwFNc=
Date:   Fri, 4 Dec 2020 12:06:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-ID: <20201204110644.GB31534@zn.tnic>
References: <20201203123757.GH3059@zn.tnic>
 <20201203124121.GI3059@zn.tnic>
 <20201203124820.GJ3059@zn.tnic>
 <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
 <20201203165420.GL3059@zn.tnic>
 <20201203170140.GM3059@zn.tnic>
 <d9b47fc6-6d9d-b966-30df-9ef8c83b46e3@amd.com>
 <20201203181712.GN3059@zn.tnic>
 <e7148653-0156-b895-714c-0d4cd580a2a8@amd.com>
 <20201204095653.c948106a294fd6e731df5594@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201204095653.c948106a294fd6e731df5594@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:56:53AM +0900, Masami Hiramatsu wrote:
> Hmm, there is a difference between Intel SDM and AMD APM.
> 
> Intel SDM vol.2
> 
> 2.1.1 Instruction Prefixes
> Instruction prefixes are divided into four groups, each with a set of allowable prefix codes. For each instruction, it
> is only useful to include up to one prefix code from each of the four groups (Groups 1, 2, 3, 4).
> 
> AMD APM vol.3
> 
> 1.2.1 Summary of Legacy Prefixes
> Table 1-1 on page 7 shows the legacy prefixes. The legacy prefixes are organized into five groups, as
> shown in the left-most column of Table 1-1. An instruction encoding may include a maximum of one
> prefix from each of the five groups.
> 
> So, Intel CPU doesn't accept LOCK-REP because those are in a same prefix
> group, but AMD says it is acceptable.

That would be a huge problem for code if both vendors would behave
differently wrt prefixes.

> Actually, insn.c only accepts the prefix up to 4, so if there is any
> instruction which has 5 prefixes, it will fail to parse.

Well, actually it looks more like a difference in how both vendors group
things:

AMD has 5 groups and Intel 4 by putting LOCK and REP together.

The most important aspect, however, is that you can have as many
prefixes as you want and there's no hardware limitation on the number -
I'm being told - just that you can overflow the instruction limit of 15
and then get a #GP for invalid insn. See here:

https://sandpile.org/x86/opc_enc.htm

note #1

with examples how you can overflow the 15 bytes limit even with a valid
insn.

> Note that anyway the same prefix can be repeated, we can see a good example
> in K8_NOP*.

Yap.

> In this case, insn.c just store the 1 osp in the prefixes.bytes[], and
> just increment prefixes.nbytes for the repeated prefixes.
> 
> Anyway, if there is LOCK-REP prefix combination, I have to introduce new
> insn_field for legacy prefix.

Well, the legacy prefixes field needs to be of 4 fields because REP and
LOCK really are two separate but mutually exclusive groups. Why?

They're used by a disjoint set of instructions, see the AMD doc for both
REP and LOCK prefixes.

Which means, you can either have a REP (exclusive or) LOCK but not both.

Which means, as a stable@ fix I can use Tom's ARRAY_SIZE() suggestion
and then later on we can make the legacy prefixes a separate struct.
Maybe even a struct with a bitfield:

struct legacy_prefixes {
        /* operand-size override: 0x66 */
        u8 os_over: 1,
        /* address-size override: 0x67 */
           as_over: 1,
        /*
         * segment override: 0x2e(CS), 0x3e(DS), 0x26(ES), 0x64(FS), 0x65(GS),
         * 0x36(SS)
         */
           s_over: 1,
        /* lock prefix: 0xf0 */
           lock:   1,
        /* repeat prefixes: 0xf2: REPNx, 0xf3: REPx */
           rep:    1,
	   __resv: 3;
};

or so which you can set to denote when you've seen the respective
prefixes.

But that we can discuss later.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
