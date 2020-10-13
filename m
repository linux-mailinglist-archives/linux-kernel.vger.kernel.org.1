Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535F928CAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390996AbgJMI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:59:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:35112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbgJMI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:59:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A7EDAF87;
        Tue, 13 Oct 2020 08:59:07 +0000 (UTC)
Date:   Tue, 13 Oct 2020 10:59:05 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201013085905.GA9328@suse.de>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010191110.4060905-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

On Sat, Oct 10, 2020 at 03:11:10PM -0400, Arvind Sankar wrote:
> Commit
>   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> started using a new set of pagetables even without KASLR.
> 
> After that commit, initialize_identity_maps() is called before the
> 5-level paging variables are setup in choose_random_location(), which
> will not work if 5-level paging is actually enabled.
> 
> Fix this by moving the initialization of __pgtable_l5_enabled,
> pgdir_shift and ptrs_per_p4d into cleanup_trampoline(), which is called
> immediately after the finalization of whether the kernel is executing
> with 4- or 5-level paging. This will be earlier than anything that might
> require those variables, and keeps the 4- vs 5-level paging code all in
> one place.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/ident_map_64.c |  6 ------
>  arch/x86/boot/compressed/kaslr.c        |  8 --------
>  arch/x86/boot/compressed/pgtable_64.c   | 16 ++++++++++++++++
>  3 files changed, 16 insertions(+), 14 deletions(-)

Thanks for fixing this! It is not only a fix but also a nice cleanup of
the 5level-paging initialization code.

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Joerg Roedel <jroedel@suse.de>

