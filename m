Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3232CE45E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgLDAR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgLDAR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:17:28 -0500
Date:   Fri, 4 Dec 2020 09:16:41 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607041007;
        bh=HevEu4R8agICOpgq5o9rXhv39h0KbBlFXkjeQdeXot4=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjcIpaZLMe4K4yvWCYdx4+U/jPqXmnx8PH3G6+3C16jvz0/+YwSs7WYJVEhOyWJzE
         YQ1K76wBLthBEwzJy9KhGOwk2ZVTMw+XY5HdwBI7XVFUh6rhGc1bsnp0Y1rJ9Rd78w
         ogRG3qdX46JmwHaorU48nJJA35kOGlK9UtOoFeJ4WJivaFcNL9wyzgBB2emOH6k1Yl
         Mgw4JxiGLfOrERdavHh/mntXRwyY0JB7v45nL/J5Ui6F9zHbMFOcp4RfG/oQYXzzev
         XMa4xdI+bUftZ9yPuItOrXug1atqjZfXeY5cicoaymRsvEXcpJlUB1ZTg2twzsu9lp
         6gF9Bc7HU6d8g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
Message-Id: <20201204091641.afcb7db30c87a33cc76ea716@kernel.org>
In-Reply-To: <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
        <160697103739.3146288.7437620795200799020.stgit@devnote2>
        <20201203123757.GH3059@zn.tnic>
        <20201203124121.GI3059@zn.tnic>
        <20201203124820.GJ3059@zn.tnic>
        <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 10:45:48 -0600
Tom Lendacky <thomas.lendacky@amd.com> wrote:

> On 12/3/20 6:48 AM, Borislav Petkov wrote:
> > So it ended up like this:
> > 
> > ---
> >  From 5014e4e902778d63ce392f864b3654baa4b72384 Mon Sep 17 00:00:00 2001
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Thu, 3 Dec 2020 13:50:37 +0900
> > Subject: [PATCH] x86/uprobes: Do not use prefixes.nbytes when looping over
> >   prefixes.bytes
> > 
> > Since insn.prefixes.nbytes can be bigger than the size of
> > insn.prefixes.bytes[] when a prefix is repeated, the proper check must
> > be
> > 
> >    insn.prefixes.bytes[i] != 0 and i < 4
> > 
> > instead of using insn.prefixes.nbytes.
> > 
> > Introduce a for_each_insn_prefix() macro for this purpose. Debugged by
> > Kees Cook <keescook@chromium.org>.
> > 
> >   [ bp: Massage commit message, add NUM_LEGACY_PREFIXES, sync with the
> >     respective header in tools/ and drop "we". ]
> > 
> > Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> > Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Cc: stable@vger.kernel.org
> > Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F160697103739.3146288.7437620795200799020.stgit%40devnote2&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Ce8ec706c564245542b4408d89789b727%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637425965056484231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=csaC0C2cszr45mKES42CHeZjC4TnEJtKrMa0gSmHjn8%3D&amp;reserved=0
> > ---
> >   arch/x86/include/asm/insn.h       | 16 ++++++++++++++++
> >   arch/x86/kernel/uprobes.c         | 10 ++++++----
> >   tools/arch/x86/include/asm/insn.h | 18 +++++++++++++++++-
> >   3 files changed, 39 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> > index 5c1ae3eff9d4..fe8e862004d3 100644
> > --- a/arch/x86/include/asm/insn.h
> > +++ b/arch/x86/include/asm/insn.h
> > @@ -58,6 +58,7 @@ struct insn {
> >   };
> >   
> >   #define MAX_INSN_SIZE	15
> > +#define NUM_LEGACY_PREFIXES 4
> >   
> >   #define X86_MODRM_MOD(modrm) (((modrm) & 0xc0) >> 6)
> >   #define X86_MODRM_REG(modrm) (((modrm) & 0x38) >> 3)
> > @@ -201,6 +202,21 @@ static inline int insn_offset_immediate(struct insn *insn)
> >   	return insn_offset_displacement(insn) + insn->displacement.nbytes;
> >   }
> >   
> > +/**
> > + * for_each_insn_prefix() -- Iterate prefixes in the instruction
> > + * @insn: Pointer to struct insn.
> > + * @idx:  Index storage.
> > + * @prefix: Prefix byte.
> > + *
> > + * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
> > + * and the index is stored in @idx (note that this @idx is just for a cursor,
> > + * do not change it.)
> > + * Since prefixes.nbytes can be bigger than NUM_LEGACY_PREFIXES if some prefixes
> > + * are repeated, it cannot be used for looping over the prefixes.
> > + */
> > +#define for_each_insn_prefix(insn, idx, prefix)	\
> > +	for (idx = 0; idx < NUM_LEGACY_PREFIXES && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
> 
> Since this is based on the array size, can
> 
> 	idx < NUM_LEGACY_PREFIXES
> 
> be replaced with:
> 
> 	idx < ARRAY_SIZE(insn->prefixes.bytes)

You're right.
There are 2 issues are mixed in this solution.

- 4 bytes limitation comes from the prefixes.bytes size, because
  it is mapped to insn_value_t.
  
struct insn_field {
        union {
                insn_value_t value;
                insn_byte_t bytes[4];
        };

- The restriction that one instruction can have up to four types
  of prefixes comes from Intel's specification.

Intel SDM Vol.2 
----
2.1.1 Instruction Prefixes
Instruction prefixes are divided into four groups, each with a set of allowable prefix codes. For each instruction, it
is only useful to include up to one prefix code from each of the four groups (Groups 1, 2, 3, 4).
----

So, we need 2 macros to fix this.

#define NUM_INSN_FIELD_BYTES	(sizeof(insn_value_t) / sizeof(insn_byte_t))
#define NUM_LEGACY_PREFIX_GROUPS	4	/* See Intel SDM Vol.2 2.2.1 Instruction Prefixes */

Thank you,

> 
> ?
> 
> Thanks,
> Tom
> 
> > +
> >   #define POP_SS_OPCODE 0x1f
> >   #define MOV_SREG_OPCODE 0x8e
> >   


-- 
Masami Hiramatsu <mhiramat@kernel.org>
