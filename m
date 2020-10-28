Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B632629D8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbgJ1Wgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388416AbgJ1Wg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:36:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39560C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:36:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 01FC73D9; Wed, 28 Oct 2020 09:31:05 +0100 (CET)
Date:   Wed, 28 Oct 2020 09:31:04 +0100
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
Subject: Re: [PATCH v3 2/5] x86/boot/compressed/64: Add CPUID sanity check to
 early #VC handler
Message-ID: <20201028083104.GB18723@8bytes.org>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-3-joro@8bytes.org>
 <20201027103846.GB15580@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027103846.GB15580@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:38:46AM +0100, Borislav Petkov wrote:
> So why are we doing those checks here at all then? I mean, the HV
> can tell us whatever it wants, i.e., make sure those checks pass but
> still report the C-bit at the wrong position. Which means that those
> checks are simply meh. So why are we doing them at all? To catch stupid
> hypervisors who can't even lie properly to the guest? :-)

To avoid that the HV tricks the kernel into the no_sev boot path, where
it would map memory unencrypted and possibly leak sensitive data. The HV
can do so by pretending SEV is disabled at all and by reporting the
wrond C-bit position. Both cases need to be checked.


Regards,

	Joerg
