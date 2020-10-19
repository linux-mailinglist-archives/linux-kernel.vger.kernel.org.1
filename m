Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD4292F73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgJSUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:33:48 -0400
Received: from 8bytes.org ([81.169.241.247]:34022 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgJSUds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:33:48 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4770E52D; Mon, 19 Oct 2020 22:33:47 +0200 (CEST)
Date:   Mon, 19 Oct 2020 22:33:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201019203345.GF3635@8bytes.org>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019170008.GA2701355@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

On Mon, Oct 19, 2020 at 01:00:08PM -0400, Arvind Sankar wrote:
> On Mon, Oct 19, 2020 at 05:11:19PM +0200, Joerg Roedel wrote:
> > +
> > +	/* Store value to memory and keep it in %r10 */
> > +	movq	%r10, sev_check_data(%rip)
> > +
> 
> Does there need to be a cache flush/invalidation between this and the
> read below to avoid just reading back from cache, or will the hardware
> take care of that?

No, a cache flush is not needed. When the C bit position is correct,
then the data will be mapped encrypted with the old and the new
page-table. If the C bit position is wrong, the access goes to a
different physical address.

> > +	/* Backup current %cr3 value to restore it later */
> > +	movq	%cr3, %r11
> > +
> > +	/* Switch to new %cr3 - This might unmap the stack */
> > +	movq	%rdi, %cr3
> 
> Does there need to be a TLB flush after this? When executed from the
> main kernel's head code, CR4.PGE is enabled, and if the original page
> mapping had the global bit set (the decompressor stub sets that in the
> identity mapping), won't the read below still use the original encrypted
> mapping if we don't explicitly flush it?

The check only really matters for the boot CPU, not for the secondary
CPUs. IIRC at this point in boot CR4.PGE is still off.

Regards,

	Joerg

