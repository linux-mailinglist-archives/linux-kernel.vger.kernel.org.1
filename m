Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1A281754
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgJBQB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgJBQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601654484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Jor+fjjZlrkYFKsnf/j6ujMU3fQARqQ9kGgIywfWC4=;
        b=ibySHBnY9Qu3Qwz2LxjSS4A/USz2ju7TGV/jEzKJa87mvwolDUTjnoiMIzVD99Hn+TPIom
        h2llCy62IveFbzORsoQ4LDp6zl6tZVSlJPX4NUlhjmi7y60VOB1UU5L+1i9pq4JBcxxU5x
        8Bn0dCaQ5urE11+LUikjqbFzhx0SDkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-zisXQFNnM7ymFS_9xFuHoA-1; Fri, 02 Oct 2020 12:01:22 -0400
X-MC-Unique: zisXQFNnM7ymFS_9xFuHoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 157ED1054F8E;
        Fri,  2 Oct 2020 16:01:21 +0000 (UTC)
Received: from treble (ovpn-114-202.rdu2.redhat.com [10.10.114.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4275F73683;
        Fri,  2 Oct 2020 16:01:17 +0000 (UTC)
Date:   Fri, 2 Oct 2020 11:01:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/4] objtool: fix x86 orc generation on big endian
 cross compiles
Message-ID: <20201002160114.7yb7z7aeijhchpwl@treble>
References: <cover.thread-6ec90b.your-ad-here.call-01601502173-ext-7769@work.hours>
 <patch-4.thread-6ec90b.git-6ec90b880ce6.your-ad-here.call-01601502173-ext-7769@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch-4.thread-6ec90b.git-6ec90b880ce6.your-ad-here.call-01601502173-ext-7769@work.hours>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:17:32AM +0200, Vasily Gorbik wrote:
> +++ b/tools/objtool/arch/x86/special.c
> @@ -9,7 +9,7 @@
>  
>  void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
>  {
> -	switch (feature) {
> +	switch (le16_to_cpu(feature)) {

It might be cleaner for the endian conversion to be done when the
'feature' value is first read.

		feature = *(unsigned short *)(sec->data->d_buf + offset +
					      entry->feature);


>  	case X86_FEATURE_SMAP:
>  		/*
>  		 * If UACCESS validation is enabled; force that alternative;
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 2df9f769412e..f20a4be2fb22 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1370,7 +1370,7 @@ static int read_unwind_hints(struct objtool_file *file)
>  		cfa = &insn->cfi.cfa;
>  
>  		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
> -			insn->ret_offset = hint->sp_offset;
> +			insn->ret_offset = le16_to_cpu(hint->sp_offset);

Since this is common code, we might not always be able to assume the
value is little endian.  Could you make a more generic conversion macro
which -- when the target ELF file's endianness doesn't match the host
CPU's -- does a byte swap?  For example:

	insn->ret_offset = bswap_if_needed(hint->sp_offset);

The macro could detect the type size, and would also know the
host/target endianness, and could swap accordingly.  It could then be
called for all such multi-byte reads.

-- 
Josh

