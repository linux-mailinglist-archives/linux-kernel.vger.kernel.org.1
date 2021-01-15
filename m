Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10002F8576
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbhAOTaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387501AbhAOTaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610738922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9L8f/VSlWhMvWlsqTvqtVSbWxu6uLg0mO+eInY55OoY=;
        b=BeA8Q/BlMSHqAHQFIIqUJXzmzLq9QGsYG9V8rA8nCe5sR8rDaz4yhePnHuxvxiqpGEdcdC
        Bfvdcy4n7JPI3tYNWCqeCNIWs5J6BuMBrX2wcPyFRi59VyGcTaQp36Ba+ZZ7muIN1nxznj
        8CRwsGn504GgNLn3F32dXV+a/i6WQA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-C_VcrnmtOYC_tEVxj5nSKA-1; Fri, 15 Jan 2021 14:28:38 -0500
X-MC-Unique: C_VcrnmtOYC_tEVxj5nSKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82D561842142;
        Fri, 15 Jan 2021 19:28:36 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FF0D19C71;
        Fri, 15 Jan 2021 19:28:31 +0000 (UTC)
Date:   Fri, 15 Jan 2021 13:28:27 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
Message-ID: <20210115192827.d6qsfgegp7fsfn7j@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <CA+icZUV1a-DEf-dTm8MyyBbp_VYmW5WwJPF9DQb=yJHPykJASQ@mail.gmail.com>
 <CA+icZUVc0M3Ydf=SKSV2MhDmdb49nGSrN-9TjYvjL25vmDHaeQ@mail.gmail.com>
 <CA+icZUUzN96qSudFCJETNAu6-cq1NKfgngh1PM7nxv=FUPuVBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUUzN96qSudFCJETNAu6-cq1NKfgngh1PM7nxv=FUPuVBQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 07:54:29PM +0100, Sedat Dilek wrote:
> > > I tried this series on top of clang-cfi and it segfaults here.
> > >
> > > + info OBJTOOL vmlinux.o
> > > + [  != silent_ ]
> > > + printf   %-7s %s\n OBJTOOL vmlinux.o
> > >  OBJTOOL vmlinux.o
> > > + tools/objtool/objtool orc generate --duplicate --mcount --vmlinux
> > > --no-fp --no-unreachable --retpoline --uaccess vmlinux.o
> > > Segmentation fault
> > > + on_exit
> > > + [ 139 -ne 0 ]
> > > + cleanup
> > > + rm -f .btf.*
> > > + rm -f .tmp_System.map
> > > + rm -f .tmp_initcalls.lds
> > > + rm -f .tmp_symversions.lds
> > > + rm -f .tmp_vmlinux*
> > > + rm -f System.map
> > > + rm -f vmlinux
> > > + rm -f vmlinux.o
> > > make[3]: *** [Makefile:1213: vmlinux] Error 139
> > >
> >
> > I re-tried with the latest clang-lto Git and switched to Debian's LLVM-11.0.1.
> > This build was successful.
> > No objtool-vmlinux warnings observed.
> >
> > In the next step I try with my selfmade LLVM-11.1.0-rc1 (to see if it's broken).
> >
> 
> Good, my selfmade LLVM-11.1.0-rc1 is not broken with clang-lto.
> 
> + info OBJTOOL vmlinux.o
> + [  != silent_ ]
> + printf   %-7s %s\n OBJTOOL vmlinux.o
>  OBJTOOL vmlinux.o
> + tools/objtool/objtool orc generate --duplicate --mcount --vmlinux
> --no-fp --no-unreachable --retpoline --uaccess vmlinux.o
> + make -f ./scripts/Makefile.modpost MODPOST_VMLINUX=1
>  scripts/mod/modpost -m    -o vmlinux.symvers vmlinux.o
> + info MODINFO modules.builtin.modinfo
> 
> Josh and Sami, any idea what's going on with clang-cfi an this patchset?

No idea, I haven't seen this.  Are you still able to recreate?

-- 
Josh

