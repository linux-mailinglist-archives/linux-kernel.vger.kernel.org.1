Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24B9283741
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJEOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgJEOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601906639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FiubZDjnEvbMrof1WsbVv3DYVP1R+np4/DBi1Pvea4=;
        b=AuKPEKYIzqsd92fooobbwPV2m//mIS/Nd88GZcBmElcg9RAcw9pLdttkpJGaS4yRPJjXTc
        5c9b/DzWpDnUpd5ooTI+eEP34pUStwdWVx1bO9OUC5lgAnld6fQcaUl5aRGHjVQ9byuwnf
        UPswJ07vnNXSU56xVN2v6AeFvex1EY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4--71tJyiMOjmzBkmiMdQs5g-1; Mon, 05 Oct 2020 10:03:58 -0400
X-MC-Unique: -71tJyiMOjmzBkmiMdQs5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2C21101FFA0;
        Mon,  5 Oct 2020 14:03:55 +0000 (UTC)
Received: from treble (ovpn-119-43.rdu2.redhat.com [10.10.119.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C06C378824;
        Mon,  5 Oct 2020 14:03:36 +0000 (UTC)
Date:   Mon, 5 Oct 2020 09:03:28 -0500
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
Subject: Re: [RFC PATCH v4 4/4] objtool: fix x86 orc generation on big endian
 cross compiles
Message-ID: <20201005140328.hpbpkfpx3hmpuapt@treble>
References: <20201002160114.7yb7z7aeijhchpwl@treble>
 <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
 <patch-4.thread-a8def4.git-a8def4f04016.your-ad-here.call-01601818410-ext-7687@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch-4.thread-a8def4.git-a8def4f04016.your-ad-here.call-01601818410-ext-7687@work.hours>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 04:30:54PM +0200, Vasily Gorbik wrote:
> @@ -77,8 +78,9 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
>  	if (entry->feature) {
>  		unsigned short feature;
> 
> -		feature = *(unsigned short *)(sec->data->d_buf + offset +
> -					      entry->feature);
> +		feature = bswap_if_needed(*(unsigned short *)(sec->data->d_buf +
> +							      offset +
> +							      entry->feature));
>  		arch_handle_alternative(feature, alt);
>  	}
> ---
>  arch/x86/include/asm/orc_types.h              | 10 +++++
>  tools/arch/x86/include/asm/orc_types.h        | 10 +++++
>  .../arch/x86/include/arch_endianness.h        |  9 +++++
>  tools/objtool/check.c                         |  5 ++-
>  tools/objtool/endianness.h                    | 38 +++++++++++++++++++
>  tools/objtool/orc_dump.c                      |  5 ++-
>  tools/objtool/orc_gen.c                       |  3 ++
>  tools/objtool/special.c                       |  6 ++-
>  8 files changed, 80 insertions(+), 6 deletions(-)
>  create mode 100644 tools/objtool/arch/x86/include/arch_endianness.h
>  create mode 100644 tools/objtool/endianness.h
> 
> diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
> index fdbffec4cfde..5a2baf28a1dc 100644

This patch is misformatted.  Almost like it was concatenated with
itself?

-- 
Josh

