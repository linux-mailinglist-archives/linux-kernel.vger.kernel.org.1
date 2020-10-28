Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16F29E31D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgJ2Cp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgJ1Vdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D271AAB2;
        Wed, 28 Oct 2020 16:55:46 +0000 (UTC)
Date:   Wed, 28 Oct 2020 17:55:43 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201028165543.GL22179@suse.de>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-2-joro@8bytes.org>
 <20201026182706.GG22116@zn.tnic>
 <20201028082352.GA18723@8bytes.org>
 <20201028165007.GB1989568@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028165007.GB1989568@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:50:07PM -0400, Arvind Sankar wrote:
> On Wed, Oct 28, 2020 at 09:23:52AM +0100, Joerg Roedel wrote:
> > On Mon, Oct 26, 2020 at 07:27:06PM +0100, Borislav Petkov wrote:
> > > A couple of lines above you call get_sev_encryption_bit() which already
> > > reads MSR_AMD64_SEV. Why not set sev_status there too instead of reading
> > > that MSR again here?
> > > 
> > > It can read that MSR once and use sev_status(%rip) from then on to avoid
> > > reading that MSR multiple times...
> > 
> > Right, makes sense. I updated the patch.
> 
> Hang on, get_sev_encryption_bit() is also called from startup_32(),
> so it can't contain any 64-bit instructions to set sev_status.

Yeah, figured that out too and discussed it with Boris. Decided to leave
it as-is and add a comment why the MSR is re-read.

Thanks,

	Joerg
