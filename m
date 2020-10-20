Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23965293FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgJTPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:48:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgJTPsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:48:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF63CACD5;
        Tue, 20 Oct 2020 15:48:14 +0000 (UTC)
Date:   Tue, 20 Oct 2020 17:48:12 +0200
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
Subject: Re: [PATCH v2 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201020154812.GB22179@suse.de>
References: <20201020121856.19427-1-joro@8bytes.org>
 <20201020121856.19427-4-joro@8bytes.org>
 <20201020141259.GC2996696@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020141259.GC2996696@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:12:59AM -0400, Arvind Sankar wrote:
> On Tue, Oct 20, 2020 at 02:18:54PM +0200, Joerg Roedel wrote:
> Why use r10-r12 rather than the caller-save registers? Even for the head
> code where you need to perserve the cr3 value you can just return it in
> rax?

It can surely be optimized, but it makes the code less robust.  This
function is only called from assembly so the standard x86-64 calling
conventions might not be followed strictly. I think its better to make
as few assumptions as possible about the calling code to avoid
regressions. Changes to the head code are not necessarily tested with
SEV/SEV-ES guests by developers.

Regards,

	Joerg
