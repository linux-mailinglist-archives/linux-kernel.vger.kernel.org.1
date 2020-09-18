Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94156270876
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRVn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgIRVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600465406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibBVe9XWamlvD+LShn+aQH8WeaCxGv/MaF5KwAhNyIk=;
        b=DhtBHG1jdGFxvFlrH/9//kbjfgxaPAW85Gk51e6iaPvfevwuZz/F9bP65uKmd8B70N+bE2
        yZ1y+GgziJO3mf5vFgJRfLVJf086B8W+HjX41yawMO2ZPn38KSu3jfEfelLY2TCj+gn1Zn
        XmYYNCQBLh3QuyaeIRzfNqLwIBX/Op8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-MOPrzJKDOrW9DmZulLAmhQ-1; Fri, 18 Sep 2020 17:43:22 -0400
X-MC-Unique: MOPrzJKDOrW9DmZulLAmhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DE41882FB5;
        Fri, 18 Sep 2020 21:43:21 +0000 (UTC)
Received: from treble (ovpn-112-141.rdu2.redhat.com [10.10.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9842E10016DA;
        Fri, 18 Sep 2020 21:43:20 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:43:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 3/3] objtool: check: Make SP memory operation match
 PUSH/POP semantics
Message-ID: <20200918214318.2d7msla53ysxkbaz@treble>
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-4-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915081204.9204-4-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:12:04AM +0100, Julien Thierry wrote:
> Architectures without PUSH/POP instructions will always access the stack
> though memory operations (SRC/DEST_INDIRECT). Make those operations have
> the same effect on the CFA as PUSH/POP, with no stack pointer
> modification.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/check.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f45991c2db41..7ff87fa3caec 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2005,6 +2005,13 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
>  			break;
>  
>  		case OP_SRC_REG_INDIRECT:
> +			if (!cfi->drap && op->dest.reg == cfa->base) {

&& op->dest.reg == CFI_BP ?

> +
> +				/* mov disp(%rsp), %rbp */
> +				cfa->base = CFI_SP;
> +				cfa->offset = cfi->stack_size;
> +			}
> +
>  			if (cfi->drap && op->src.reg == CFI_BP &&
>  			    op->src.offset == cfi->drap_offset) {
>  
> @@ -2026,6 +2033,11 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
>  				/* mov disp(%rbp), %reg */
>  				/* mov disp(%rsp), %reg */
>  				restore_reg(cfi, op->dest.reg);
> +			} else if (op->src.reg == CFI_SP &&

An empty line above the else would help readability.

> +				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
> +
> +				/* mov disp(%rsp), %reg */
> +				restore_reg(cfi, op->dest.reg);

>  			}
>  
>  			break;
> @@ -2103,6 +2115,11 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
>  			/* mov reg, disp(%rsp) */
>  			save_reg(cfi, op->src.reg, CFI_CFA,
>  				 op->dest.offset - cfi->cfa.offset);
> +		} else if (op->dest.reg == CFI_SP) {

Same here.

> +
> +			/* mov reg, disp(%rsp) */
> +			save_reg(cfi, op->src.reg, CFI_CFA,
> +				 op->dest.offset - cfi->stack_size);
>  		}
>  
>  		break;
> -- 
> 2.21.3
> 

-- 
Josh

