Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF72FBD98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbhASR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391390AbhASR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611077172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mAzpHVdlnMaDyvxGTKzMDyi59keeJ2kOytyejQDWyqg=;
        b=hyIy8isn2lizrPSy7PuszBneMy+rbbws+E75bcrkRIYc2rDQE0cjKlR2ZUDLR4bg0NYjvz
        zbKBVRGFv62/yu+S+21Q7AMaOm8cuP7FO8EMZ5ETNBreIepr1tqUzN/3NT9Wlxp2rsa7JT
        rlSM9hdjlaAs4x1KKGwyuuBDQ7EakDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-AXabtRcgOPCQB4xr3nWivg-1; Tue, 19 Jan 2021 12:26:10 -0500
X-MC-Unique: AXabtRcgOPCQB4xr3nWivg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3CF01936B8A;
        Tue, 19 Jan 2021 17:26:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C6A260C9C;
        Tue, 19 Jan 2021 17:26:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 19 Jan 2021 18:26:07 +0100 (CET)
Date:   Tue, 19 Jan 2021 18:26:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, rostedt@goodmis.org, paulus@samba.org,
        jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/uprobes: Don't allow probe on suffix of prefixed
 instruction
Message-ID: <20210119172603.GA16696@redhat.com>
References: <20210119091234.76317-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119091234.76317-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19, Ravi Bangoria wrote:
>
> Probe on 2nd word of a prefixed instruction is invalid scenario and
> should be restricted.

I don't understand this ppc-specific problem, but...

> +#ifdef CONFIG_PPC64
> +int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> +			      uprobe_opcode_t opcode)
> +{
> +	uprobe_opcode_t prefix;
> +	void *kaddr;
> +	struct ppc_inst inst;
> +
> +	/* Don't check if vaddr is pointing to the beginning of page */
> +	if (!(vaddr & ~PAGE_MASK))
> +		return 0;

So the fix is incomplete? Or insn at the start of page can't be prefixed?

> +int __weak arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> +				     uprobe_opcode_t opcode)
> +{
> +	return 0;
> +}
> +
>  static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
>  {
>  	uprobe_opcode_t old_opcode;
> @@ -275,6 +281,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>  	if (is_swbp_insn(new_opcode)) {
>  		if (is_swbp)		/* register: already installed? */
>  			return 0;
> +		if (arch_uprobe_verify_opcode(page, vaddr, old_opcode))
> +			return -EINVAL;

Well, this doesn't look good...

To me it would be better to change the prepare_uprobe() path to copy
the potential prefix into uprobe->arch and check ppc_inst_prefixed()
in arch_uprobe_analyze_insn(). What do you think?

Oleg.

