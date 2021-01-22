Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405C93007AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbhAVPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728056AbhAVPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611330138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aoObqNZIQR4x9qRo1g8n85wBtUQqNCVQm7KP/81m/yM=;
        b=iegA1LvVwOzscymQw+88NP0PJn9qcv5JdIB/XTYux60sdYEHKfUIX6dT9hqyHX5xCEY15b
        f6KYsaoB2tL3rBo5InVxFZUOVg8Fi9Th1rFXG1U4XQ1UXR30p16KOfEXkLiGwp/88O0kNq
        q2xvFYQ+OAqADOM4rU0z5c4tSf1EmXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-dEXscmGnODyT6-JqNcDfDA-1; Fri, 22 Jan 2021 10:42:16 -0500
X-MC-Unique: dEXscmGnODyT6-JqNcDfDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 561E5801817;
        Fri, 22 Jan 2021 15:42:08 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0755119C59;
        Fri, 22 Jan 2021 15:42:05 +0000 (UTC)
Date:   Fri, 22 Jan 2021 09:41:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
Message-ID: <20210122154158.lylubqugmcxehugg@treble>
References: <cover.1611263461.git.jpoimboe@redhat.com>
 <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:38:54PM +0100, Sedat Dilek wrote:
> On Thu, Jan 21, 2021 at 10:29 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > v2:
> > - fix commit description for why xen hypervisor page contents don't
> >   matter [Juergen]
> > - annotate indirect jumps as safe instead of converting them to
> >   retpolines [Andrew, Juergen]
> > - drop patch 1 - fake jumps no longer exist
> > - add acks
> >
> > Based on tip/objtool/core.
> >
> >
> > Add support for proper vmlinux.o validation, which will be needed for
> > Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> > objtool anyway, for other reasons.)
> >
> > This isn't 100% done -- most notably, crypto still needs to be supported
> > -- but I think this gets us most of the way there.
> >
> > This can also be found at
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> >
> 
> Should this be s/objtool-vmlinux/objtool-vmlinux-v2 ?

Indeed:

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux-v2

-- 
Josh

