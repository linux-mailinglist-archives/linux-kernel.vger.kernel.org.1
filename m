Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C861E0408
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 01:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbgEXX5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbgEXX5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:57:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C930CC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:57:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so10731358qkn.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KnCrzlEjsfoAQJ2vuCQBZGIyVUirCRVTyeXStV4i7EM=;
        b=F6VsXuGETgOOczOvg8Bquay04RDy5umxA029YtYcNF8N1gsu2sYTb+vXBZBSjcLqxK
         nbl/VKMNWQiRLWmtkUcY0KW4Ak+gVsQaFIqvvdrwIytV8lNHpfF5IXfj7hIwvEwdd+s6
         NzmN5eFFOD8iyN3Jwsdgst77v7KTXXZsCIpJiK9lhXql3Hm9F/B+pL3NkMr73bC3eKM2
         +rF5D0jHIGjq0KsTO/abWrF4n1mXupO349H2NZfCqk4/IY9wdrH8JrlHyz6VZYAxzQlK
         hhMLhQi0/KThSgJ/Xh/aMxK6PV1klX7uqIM6UmIAVzn6kC1YqXdnpZuhfBoTsvcQJiH3
         IUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KnCrzlEjsfoAQJ2vuCQBZGIyVUirCRVTyeXStV4i7EM=;
        b=R/6TDE5sCLqZJD9Q1J3tE23Qd63Abz1avZtkp0+hICgldMwA4qG0E4rkvBLIGgYrAT
         V1ZIMb0zQFgROsVY4JpAWA/jV3iVdvXBDhJvLyPiBa6X/QGmclo0tWX3tMzHEHwuvbRv
         h+hNYYT5vdxBjzKst5WiIRdjUnDZIKzSMcSzrQ83Rwb/39WM6GpjFU88NR6gzaUK+/Lc
         JDx5D+d2zY2m49SLk9PbcStGuRuRXf+8KdJrNhRJQK7ICBbgWg4D2yvpxcptMSz378Qr
         kGtfBM6sVXKEjPGed55iavLu51lHl5xCjIkrrC7/63dwW7/+YbrbcabHp8LASwZvqrbd
         MEAw==
X-Gm-Message-State: AOAM530VVFVEKFezV52DSG95qOYXc2KIMN5jJtN4O2b2x4b+TgbNg47R
        Xs2Mvd4OcgMGCjAdQJfBLlukmqhS
X-Google-Smtp-Source: ABdhPJxA9vLvok4PN5lryMEBHopQyJbZb7/MIf6m6QJV3mBpm020WxHSSmIiSKtg8ccrDfBijFy44A==
X-Received: by 2002:a37:84c5:: with SMTP id g188mr23223696qkd.344.1590364671056;
        Sun, 24 May 2020 16:57:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f33sm15093959qta.44.2020.05.24.16.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:57:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 24 May 2020 19:57:48 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/boot: Check that there are no runtime relocations
Message-ID: <20200524235748.GC280334@rani.riverdale.lan>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-5-nivedita@alum.mit.edu>
 <20200524233607.cihnsmxuaqoy7xi4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200524233607.cihnsmxuaqoy7xi4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 04:36:07PM -0700, Fangrui Song wrote:
> 
> `grep -qF .rel.local` from 98f78525371b55ccd1c480207ce10296c72fa340
> may be incorrect.. None of these synthesized dynamic relocation sections is
> called *.rel.local* ...
> (it probably wanted to name .rel.data.rel.ro or .rel.data)
> 
> 
> Reviewed-by: Fangrui Song <maskray@google.com>

At least from gcc you get .data.rel.local sections if you have, for eg:
	struct { void *p; } foo = { .p = &bar };
where bar is defined in the same file. These aren't relocation sections,
foo is actually placed in the .data.rel.local section instead of .data.

But yeah, it's incomplete, you wouldn't catch it if bar was external
(foo goes in .data.rel) or foo was const (foo goes in .data.rel.ro*).
