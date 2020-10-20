Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49395293757
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbgJTJAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:00:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392231AbgJTJAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:00:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0325B2D6;
        Tue, 20 Oct 2020 09:00:00 +0000 (UTC)
Date:   Tue, 20 Oct 2020 10:59:57 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
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
Message-ID: <20201020085957.GF9328@suse.de>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
 <20201019175447.GA2720155@rani.riverdale.lan>
 <20201019203935.GG3635@8bytes.org>
 <20201019213106.GB2815942@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019213106.GB2815942@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 05:31:06PM -0400, Arvind Sankar wrote:
> Is it possible to take advantage of this to make the check independent
> of the original page tables? i.e. switch to the new pagetables, then
> write into .data or .bss the opcodes for a function that does
> 	movabs	$imm64, %rax
> 	jmp	*%rdi	// avoid using stack for the return
> filling in the imm64 with the RDRAND value, and then try to execute it.
> If the C-bit value is wrong, this will probably crash, and at any rate
> shouldn't return with the correct value in %rax.

That could work, but is not reliable. When the C bit is wrong the CPU
would essentially execute random data, which could also be a valid
instruction stream. A crash is not guaranteed.

Regards,

	Joerg
