Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882A9293895
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404815AbgJTJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:55:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:40404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404577AbgJTJz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:55:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77965B02D;
        Tue, 20 Oct 2020 09:55:27 +0000 (UTC)
Date:   Tue, 20 Oct 2020 11:55:25 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201020095525.GH9328@suse.de>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-2-joro@8bytes.org>
 <20201020005925.GA24596@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020005925.GA24596@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 05:59:25PM -0700, Sean Christopherson wrote:
> On Mon, Oct 19, 2020 at 05:11:17PM +0200, Joerg Roedel wrote:
> > +	push	%rax
> > +	push	%rcx
> 
> There's no need to save/restore RAX and RCX, they are callee save.  This
> function is only called from C, so I doubt it's using a custom ABI.

Right, removed the save/restore of these registers from the function.

Thanks,

	Joerg

