Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B42CF7D4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgLEALS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLEALS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:11:18 -0500
Date:   Sat, 5 Dec 2020 09:10:32 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607127037;
        bh=2wSRtYZDbtGCyQ9huil5YetNxok4BY09bhOihMf0qA0=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=XrrvQcBtmyeEORcVzepD0jkQWU37YJEyPy1TUtO20lU/E1iwSS4aVxOm3IKxFy0tP
         Gf7v9h8hrloHFCasa6LyFpT+56RMQygHRUeDxAUi+BazDqGOt9iq30zXxidzQL5rj7
         ofYD4QoT6CeOGDV1kZzH5Mg6tgDMSaiKBqZuOcafvIOADArnZKfwBblPBTiBsNYTqa
         F+LI87urKSs+IqOJ6MyclVBYSS4UVXDSxgDgqS0QNrPVEYIFjD3jGamta6UOOvzs7d
         A49Twv2sQ2y/1V3q5nOABdTcS+K7Wq588Ih/+6+nyiCoORcqsAvExvX+6GTu4Cg1FG
         l0uSmJWiWl1Gg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-Id: <20201205091032.6956a5bad9330ec7b9b84dc5@kernel.org>
In-Reply-To: <20201204150522.GG31534@zn.tnic>
References: <160707930875.3296595.12884856538916078988.stgit@devnote2>
        <160707931985.3296595.4852247459424743502.stgit@devnote2>
        <20201204150522.GG31534@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 16:05:22 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Dec 04, 2020 at 07:55:20PM +0900, Masami Hiramatsu wrote:
> > +/**
> > + * for_each_insn_prefix() -- Iterate prefixes in the instruction
> > + * @insn: Pointer to struct insn.
> > + * @idx:  Index storage.
> > + * @prefix: Prefix byte.
> > + *
> > + * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
> > + * and the index is stored in @idx (note that this @idx is just for a cursor,
> > + * do not change it.)
> > + * Since prefixes.nbytes can be bigger than NUM_INSN_FIELD_BYTES when some
> > + * prefixes are repeated, it can not be used for looping over the prefixes.
> > + */
> > +#define for_each_insn_prefix(insn, idx, prefix)				\
> > +	for (idx = 0;							\
> > +	     idx < MAX_LEGACY_PREFIX_GROUPS &&				\
> 
> The problem I see here is that you check for the index limit to be
> < MAX_LEGACY_PREFIX_GROUPS but the array itself is defined using
> NUM_INSN_FIELD_BYTES, and that is confusing.

Yeah, I considered that once. If I know the number of legacy prefix
groups never exceed the size of prefixes.bytes, then we would better
use the max number of legacy prefix here (because we are looping on
the bytes from the prefix groups).
That is why I added #error check in this patch.

> I guess this should be:
> 
> #define MAX_LEGACY_PREFIX_GROUPS	4
> #define NUM_INSN_FIELD_BYTES		MAX_LEGACY_PREFIX_GROUPS
> 
> and later, iff the legacy prefixes array size needs separating from the
> insn field array size, then the defines would need to change too.

No, those have different meaning. NUM_INSN_FIELD_BYTES means
sizeof(s32) / sizeof(u8), which comes from the definition of
insn_field data structure. But MAX_LEGACY_PREFIX_GROUPS comes
from the x86 ISA.

In the future, if x86 ISA is expanded and add a legacy prefix
groups, then we have to add new insn_prefix_field data structure,
which size will not depend on NUM_INSN_FIELD_BYTES, but still
depend on MAX_LEGACY_PREFIX_GROUPS (and that will be 5).

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
