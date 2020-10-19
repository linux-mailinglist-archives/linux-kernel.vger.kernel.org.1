Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B410292F93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgJSUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:39:38 -0400
Received: from 8bytes.org ([81.169.241.247]:34062 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgJSUji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:39:38 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AE03E52D; Mon, 19 Oct 2020 22:39:36 +0200 (CEST)
Date:   Mon, 19 Oct 2020 22:39:35 +0200
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
Message-ID: <20201019203935.GG3635@8bytes.org>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
 <20201019175447.GA2720155@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019175447.GA2720155@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:54:47PM -0400, Arvind Sankar wrote:
> Also, isn't it possible that the initial page tables we're running on
> have already been messed with and have the C-bit in the wrong location,
> so that this write happens decrypted?

The code assumes that the page-table it is running on has the correct C
bit position set and that the code which set it up verified that it is
correct. For the kernel itself this is true, at least, but when booting
via UEFI the check also needs to happen in the firmware.

Note that the possibilies are limited when the hypervisor reports the
wrong C bit position because code fetches always assume encryption, even
when the C bit is cleared in the page-table. So a wrong C bit position
in the decompression stub would write the kernel image to memory
unencrypted and executing it would not be possible.

Regards,

	Joerg

