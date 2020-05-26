Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0631AC0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635153AbgDPMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 08:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635124AbgDPMMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B824DAF19;
        Thu, 16 Apr 2020 12:12:40 +0000 (UTC)
Date:   Thu, 16 Apr 2020 14:12:40 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V3 3/9] objtool: Add support for intra-function calls
In-Reply-To: <20200414103618.12657-4-alexandre.chartre@oracle.com>
Message-ID: <alpine.LSU.2.21.2004161407340.10475@pobox.suse.cz>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com> <20200414103618.12657-4-alexandre.chartre@oracle.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int configure_call(struct objtool_file *file, struct instruction *insn)
> +{
> +	unsigned long dest_off;
> +
> +	dest_off = insn->offset + insn->len + insn->immediate;
> +	insn->call_dest = find_func_by_offset(insn->sec, dest_off);
> +	if (!insn->call_dest)
> +		insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
> +
> +	if (insn->call_dest) {
> +		/* regular call */
> +		if (insn->func && insn->call_dest->type != STT_FUNC) {
> +			WARN_FUNC("unsupported call to non-function",
> +				  insn->sec, insn->offset);
> +			return -1;
> +		}
> +		return 0;
> +	}
> +
> +	/* intra-function call */
> +	if (!insn->intra_function_call)
> +		WARN_FUNC("intra-function call", insn->sec, insn->offset);

"unsupported intra-function call" ?

Miroslav
