Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BA2FDDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbhAUASy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbhATXQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611184459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Om7VwHKhcnxl7GarBDwRVzXmPEeOP48pbHGghTabBUQ=;
        b=GIRK0qnvFF/7JldCdDrP0Y9OPDyeCkiDkQpXi4wB5GfYSbvz4GUFqk3rA/AguMptq9QEEE
        cIv9AGZopCMzUgTtuuACs4On3SWO9lri21F9ikbpwAGZ4d5WZJH3J4znRD9dKYaxNEuoJ0
        MIS0UZPI+QLyI+nUUkGmH+RzYCqzjrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-SHMIIL66OSu14XH1DwGo3w-1; Wed, 20 Jan 2021 17:59:53 -0500
X-MC-Unique: SHMIIL66OSu14XH1DwGo3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96227107ACE3;
        Wed, 20 Jan 2021 22:59:51 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89D5060C6D;
        Wed, 20 Jan 2021 22:59:50 +0000 (UTC)
Date:   Wed, 20 Jan 2021 16:59:48 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Aditya <yashsri421@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        dwaipayanray1@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols
 in assembly files
Message-ID: <20210120225948.lgbfhy5s265we6jn@treble>
References: <20210120072547.10221-1-yashsri421@gmail.com>
 <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
 <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com>
 <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
 <CAKwvOd=HNuB8bqJvXEjvYWorika99QX=jKSfHy2hf0NOKrrc8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=HNuB8bqJvXEjvYWorika99QX=jKSfHy2hf0NOKrrc8w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:57:03AM -0800, Nick Desaulniers wrote:
> > $ git grep -P '^\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L' -- '*.S'
> > arch/x86/boot/compressed/head_32.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> > arch/x86/boot/compressed/head_32.S:SYM_FUNC_END(.Lrelocated)
> > arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> > arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lrelocated)
> > arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
> > arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lpaging_enabled)
> > arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
> > arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lno_longmode)
> > arch/x86/boot/pmjump.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
> > arch/x86/boot/pmjump.S:SYM_FUNC_END(.Lin_pm32)
> > arch/x86/entry/entry_64.S:SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
> > arch/x86/entry/entry_64.S:SYM_CODE_END(.Lbad_gs)
> > arch/x86/lib/copy_user_64.S:SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> > arch/x86/lib/copy_user_64.S:SYM_CODE_END(.Lcopy_user_handle_tail)
> > arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
> > arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_clac)
> > arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
> > arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_8_clac)
> > arch/x86/lib/putuser.S:SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
> > arch/x86/lib/putuser.S:SYM_CODE_END(.Lbad_put_user_clac)
> > arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_START_LOCAL(.Lwakeup_idt)
> > arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_END(.Lwakeup_idt)
> 
> Josh, I assume objtool does not annotate code under:
> arch/x86/boot/
> arch/x86/entry/
> arch/x86/realmode/
> ?
> 
> The rest, ie
> arch/x86/lib/
> seem potentially relevant?

Both arch/x86/entry/* and arch/x86/lib/* are read by objtool and should
probably be fixed up.

-- 
Josh

