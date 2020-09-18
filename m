Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3922707A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIRU44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgIRU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600462611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+JyKabsxJ3Nm9swpkvGUAC1THbgtwTk2m6inzHilA8A=;
        b=WkvhKBmDyUGwe1XMMAyBhXIELoVYNhnFbfNFgOxNKdk6N2/L0GWUPVyuC5tarcoTftw8Fc
        b1YAfp3uoFHoUpDso9rPgl9ZylfT0UWGIaoKSnJqHjAjgxwGKrm4k8GhuMoiu4KvJtI36P
        ebDLvK0tpCb8Chm9PsmKqYDSPeq9Aes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-bwABePACM8eJw37-xBA8ug-1; Fri, 18 Sep 2020 16:56:47 -0400
X-MC-Unique: bwABePACM8eJw37-xBA8ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B1E6416B;
        Fri, 18 Sep 2020 20:56:45 +0000 (UTC)
Received: from treble (ovpn-112-141.rdu2.redhat.com [10.10.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C50BF78822;
        Fri, 18 Sep 2020 20:56:43 +0000 (UTC)
Date:   Fri, 18 Sep 2020 15:56:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] objtool: check: Fully validate the stack frame
Message-ID: <20200918205641.6nvnsib2paqa6xyn@treble>
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-2-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915081204.9204-2-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:12:02AM +0100, Julien Thierry wrote:
> A valid stack frame should contain both the return address and the
> previous frame pointer value.
> 
> On x86, the return value is placed on the stack by the calling
> instructions. On other architectures, the callee need to explicitly
> save the return value on the stack.

s/return value/return address/g

> 
> Add the necessary checks to verify a function properly sets up the all

s/the all/all the/

> the elements of the stack frame.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/arch/x86/include/cfi_regs.h |  4 ++++
>  tools/objtool/check.c                     | 17 +++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
> index 79bc517efba8..19b75b8b8439 100644
> --- a/tools/objtool/arch/x86/include/cfi_regs.h
> +++ b/tools/objtool/arch/x86/include/cfi_regs.h
> @@ -22,4 +22,8 @@
>  #define CFI_RA			16
>  #define CFI_NUM_REGS		17
>  
> +#define CFA_SIZE	16

If I remember correctly, CFA (stolen from DWARF) is "Caller Frame
Address".  It's the stack address of the caller, before the call.

I get the feeling CFA_SIZE is the wrong name, because CFA is an address,
and its size isn't 16 bytes.  But I'm not quite sure what this is
supposed to represent.  Is it supposed to be the size of the frame
pointer + return address?  Isn't that always going to be 16 bytes for
both arches?

> +#define CFA_BP_OFFSET	-16
> +#define CFA_RA_OFFSET	-8
> +
>  #endif /* _OBJTOOL_CFI_REGS_H */
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 500f63b3dcff..7db6761d28c2 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1669,12 +1669,20 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
>  	return false;
>  }
>  
> +static bool check_reg_frame_pos(const struct cfi_reg *reg, int cfa_start,
> +				int expected_offset)
> +{
> +	return reg->base == CFI_CFA &&
> +	       reg->offset == cfa_start + expected_offset;
> +}
> +
>  static bool has_valid_stack_frame(struct insn_state *state)
>  {
>  	struct cfi_state *cfi = &state->cfi;
>  
> -	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
> -	    cfi->regs[CFI_BP].offset == -16)
> +	if (cfi->cfa.base == CFI_BP && cfi->cfa.offset >= CFA_SIZE &&

Why '>=' rather than '=='?

> +	    check_reg_frame_pos(&cfi->regs[CFI_BP], -cfi->cfa.offset + CFA_SIZE, CFA_BP_OFFSET) &&
> +	    check_reg_frame_pos(&cfi->regs[CFI_RA], -cfi->cfa.offset + CFA_SIZE, CFA_RA_OFFSET))

Isn't '-cfi->cfa.offset + CFA_SIZE' always going to be zero?

-- 
Josh

