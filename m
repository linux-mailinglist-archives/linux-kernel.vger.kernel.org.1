Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145C5287149
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgJHJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJHJOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:14:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7253ACB8;
        Thu,  8 Oct 2020 09:14:13 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:14:12 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/64: Change add_identity_map() to take size
 for ease of use
Message-ID: <20201008091412.GF3209@suse.de>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-4-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:49PM -0400, Arvind Sankar wrote:
> Change back the arguments of add_identity_map() to (start, size) instead
> of (start, end). This reverts
> 
>   21cf2372618e ("x86/boot/compressed/64: Change add_identity_map() to take start and end")
> 
> since we will soon have more callers that know the size rather than the
> end address.
> 
> This also makes the #PF handler print the original CR2 value in case of
> error, instead of after aligning to PMD_SIZE.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index 063a60edcf99..070cda70aef3 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -90,8 +90,9 @@ static struct x86_mapping_info mapping_info;
>  /*
>   * Adds the specified range to the identity mappings.
>   */
> -static void add_identity_map(unsigned long start, unsigned long end)
> +static void add_identity_map(unsigned long start, unsigned long size)
>  {
> +	unsigned long end = start + size;

This has been discussed during the SEV-ES patch-review already and we
settled on making add_identity_map() take start and end as parameter, as
that is what kernel_ident_mapping_init() also takes as parameters.

So please keep it that way :)

Regards,

	Joerg
