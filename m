Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A38294D01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442612AbgJUMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442605AbgJUMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:49:54 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C9C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:49:54 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 165ED249; Wed, 21 Oct 2020 14:49:53 +0200 (CEST)
Date:   Wed, 21 Oct 2020 14:49:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
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
Message-ID: <20201021124946.GA30514@8bytes.org>
References: <20201020121856.19427-1-joro@8bytes.org>
 <20201020121856.19427-4-joro@8bytes.org>
 <20201020141259.GC2996696@rani.riverdale.lan>
 <20201020154812.GB22179@suse.de>
 <20201020160428.GA3233355@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020160428.GA3233355@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:04:28PM -0400, Arvind Sankar wrote:
> This is called from both assembly and C, but anyway, you're already
> assuming r10 and r11 can be clobbered safely, and you just took out the
> save/restores in set_sev_encryption_mask, which is actually called only
> from assembly.

Alright, maybe I was a bit too caucious. I changed the CR4 handling to
use %r8 and %r9 instead, which are also clobbered.

Regards,

	Joerg
