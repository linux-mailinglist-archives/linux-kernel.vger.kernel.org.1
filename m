Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F692CF7F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgLEAXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgLEAXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:23:12 -0500
Date:   Sat, 5 Dec 2020 09:22:27 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607127752;
        bh=fvvM57VimHlgWhhvg/wYV2Ot6coK7U8L/nEeVqSiGoc=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=IAvalkYEavOyonorgGTq7aWZRiz/OjuFS2KL2T5P75PWaR5ZHXIfRcae1ztglPQKz
         TNseLBhEphDDGePky2PC9F8GZmFHys4vZa43Hg3+Tn+BPP1DHIozndHDZcX+ZIZ0Ph
         HAgYiObJi/3t1rlLHUQ7zbudKGE0oA/I59WxArPZVM2wkA0EB47ygvA4xq/KIjnIlX
         4e/44A8FtM91StG/UFiFr7zHqmmrH3Bs7wj/fRf7pVFGhb8fKPc+J4GOfDSOaWWT9F
         bKixWJThxHOynRJGxtrCY+eolEvao0IUfiFlZgqpz7WpBI0+OKxY7iHZZylR87jAKv
         JhKtDXmcq1G2Q==
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
Subject: Re: [PATCH v3 0/3] x86/insn: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-Id: <20201205092227.7ea8d8af08c22ae219a8fbba@kernel.org>
In-Reply-To: <20201204150221.GF31534@zn.tnic>
References: <160707930875.3296595.12884856538916078988.stgit@devnote2>
        <20201204150221.GF31534@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 16:02:21 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Dec 04, 2020 at 07:55:09PM +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > Here are the 3rd version of patches to fix the wrong loop boundary
> > check on insn.prefixes.bytes[] array.
> 
> Ok, so I've committed the version with ARRAY_SIZE to keep it as small
> as possible for stable. Let's discuss the new changes here ontop, once
> those urgent fixes go up.

Agreed. BTW, please fix to keep the #include "inat.h" for tools build.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
