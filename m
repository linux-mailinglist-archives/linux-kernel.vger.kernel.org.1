Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6727C29DCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbgJ1Wbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:31:32 -0400
Received: from 8bytes.org ([81.169.241.247]:36978 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387889AbgJ1WbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 091143C3; Wed, 28 Oct 2020 09:23:57 +0100 (CET)
Date:   Wed, 28 Oct 2020 09:23:52 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201028082352.GA18723@8bytes.org>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-2-joro@8bytes.org>
 <20201026182706.GG22116@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026182706.GG22116@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 07:27:06PM +0100, Borislav Petkov wrote:
> A couple of lines above you call get_sev_encryption_bit() which already
> reads MSR_AMD64_SEV. Why not set sev_status there too instead of reading
> that MSR again here?
> 
> It can read that MSR once and use sev_status(%rip) from then on to avoid
> reading that MSR multiple times...

Right, makes sense. I updated the patch.
