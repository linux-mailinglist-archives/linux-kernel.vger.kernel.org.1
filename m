Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB2524932F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHSDEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 23:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgHSDEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:04:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590DC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:04:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s23so16782379qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nOKL9LH+LsUrk/QCDVM6daNP5A1QGjvzKuwMZ1mFQmI=;
        b=jRBORFL4vQo6tVHwJO8+wy8FcXHmgo1bLYPR3zb+9eVl9BqUjqv15DSlvR6B6JXnKw
         b0gLEc29OnLVFQtTf4dGgoR5Rt1akRUZynKxVLq2VsVSUtANBhmn/tgXacAYCW8wM2Yx
         ej0p26DGqtwjlKwKO8yy73LdskM3v3MrXT/lKhFeaQOmBH26pE/jh5T9V0cKcRnFRuu6
         sq+FnIyl/83pZeByuAZAcloJq1HbeOfPjGDlxdWk7py2POVw5U1qGQ5E9gnt5GdcZrCS
         ktNDTi+HVSnZmIr78RLchnYiOJAPAcMueoxquDjQNRpLwjib7Mq4fIUz6pA3Z216rdtl
         Sb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nOKL9LH+LsUrk/QCDVM6daNP5A1QGjvzKuwMZ1mFQmI=;
        b=pQKxvx0TrWeZTWSv7wGpqId8TKC/RQg73kaoH4M1vN4Zj7OpQcjsb9hGT4rNc/QrbZ
         N/W7xGc647uU2xdjai0wj3E1UnLVHoC1hOh0FhE9vHwrYzq/rhY2pxarIDl/LiSpfuQ+
         tHnjQ0operYF85K2KLMwOdtvKwdwa6QZdU0m3Riu/hZC4XH7XBt4B+F7kO925dq1u0di
         OEnSlawLOzQxdD7lYNgDPGBFe96j0UqGsS17J+RS3AIvAD2FtVee9s47xyir57vNGo5o
         6lTTL3NZj+pHW12bn/jQD1awAXVVKanRi4CoAmQx8bYUlR+c/F4lOMCytiwMpmJJEHZx
         KSmg==
X-Gm-Message-State: AOAM530ztmJnkg0g5WrMEYXnxJNY6NDgrgbcwWhmqlZLZ2xgLBdDdlmP
        DipFBemPjbDPkfFYAaCDktI=
X-Google-Smtp-Source: ABdhPJx6StHhPerJh0eSgppy0tWGh6NINW7XYojb1dJMobTK8WIx0CVTckaNZ2+7mw0AjDLxbErFYQ==
X-Received: by 2002:ac8:188:: with SMTP id x8mr20855686qtf.372.1597806284575;
        Tue, 18 Aug 2020 20:04:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t25sm25136296qtp.22.2020.08.18.20.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:04:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 18 Aug 2020 23:04:42 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] lib/string.c: Disable tree-loop-distribute-patterns
Message-ID: <20200819030442.GA3396810@rani.riverdale.lan>
References: <20200818234307.3382306-1-nivedita@alum.mit.edu>
 <CAHk-=wik-oXnUpfZ6Hw37uLykc-_P0Apyn2XuX-odh-3Nzop8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wik-oXnUpfZ6Hw37uLykc-_P0Apyn2XuX-odh-3Nzop8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 05:44:03PM -0700, Linus Torvalds wrote:
> On Tue, Aug 18, 2020 at 4:43 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > This by itself is insufficient for gcc if the optimization was
> > explicitly enabled by CFLAGS, so also add a flag to explicitly disable
> > it.
> 
> Using -fno-tree-loop-distribute-patterns seems to really be a bit too
> incestuous with internal compiler knowledge.

Fair enough -- you ok with just the -ffreestanding? That's what protects
the memset in arch/x86/boot/compressed/string.c.

I think this is worthwhile to be safe.

> 
> That generic memcpy implementation is horrible anyway. It should never be used.
> 
> So I'd rather see this either removed entirely, ot possibly rewritten
> to be a somewhat proper memcpy implementation, and in the process made
> to not be recognizable by the compiler (possibly by adding a dummy
> barrier() or something like that).
> 
> Looking at the implementation of "strscpy()" in the same file, and
> then comparing that to the ludicrously simplisting "memcpy()", I
> really get the feeling that that memcpy() is not worth having.
> 
>               Linus

I don't think anything actually uses the generic memcpy, and I think
only c6x uses the generic memset. Might be worth optimizing strnlen etc
with the word-at-a-time thing though.
