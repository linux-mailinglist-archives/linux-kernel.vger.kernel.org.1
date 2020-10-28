Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF47229D8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbgJ1Wg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:51268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbgJ1Wdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:33:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1030DB94D;
        Wed, 28 Oct 2020 13:29:56 +0000 (UTC)
Date:   Wed, 28 Oct 2020 14:29:54 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/ident_map: Check for errors from ident_pud_init()
Message-ID: <20201028132954.GK22179@suse.de>
References: <20201027230648.1885111-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027230648.1885111-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 07:06:48PM -0400, Arvind Sankar wrote:
> Commit
>   ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
> added ident_p4d_init() to support 5-level paging, but this function
> doesn't check and return errors from ident_pud_init().
> 
> For example, the decompressor stub uses this code to create an identity
> mapping. If it runs out of pages while trying to allocate a PMD
> pagetable, the error will be currently ignored.
> 
> Fix this to propagate errors.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Fixes: ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
> ---
>  arch/x86/mm/ident_map.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>

