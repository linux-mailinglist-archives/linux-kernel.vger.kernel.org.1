Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0E28FC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 03:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbgJPByy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389091AbgJPByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 21:54:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B904FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 18:54:53 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z2so963851lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKnsFQ//Lnit/5S9885OaTWlOt0Pscm5EoW1kjf5fqc=;
        b=g1JOh7Wc7WqjSRNetq9opmx3dTFmulVuvtDGgEPh21l+8IYIQMuvEQHOzDVSDLfLaW
         LJtdIHcKacSvZ7MNJ+3NzP2DxMYA97q9ClUSCc+y1xqtsVByqUExdr8XaMNyT5kAdFPQ
         QZkBocR2QofI0UyrjRawxkK9gx32mTS+wWPlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKnsFQ//Lnit/5S9885OaTWlOt0Pscm5EoW1kjf5fqc=;
        b=H1Pug/tUNz2ZWPvu0AsF9uvwnG34o5auxaVK3iBpAsid4kUb46gjvmA2QUwjqipQzg
         DX/7wn7GMeqVYbjGRvXTniiEKd7TgUQuzBAo8C0CTqtR7DHP9JD56f1utMw0aoSX4Zit
         x9qsONqBfcpnAdYu5HSpRwJTWccktVqDYGz2Xr0E54nk0Q6PoYa6K3TfeXPcrJM3F0Jk
         61Nup31tD2azOL2hVYfj3P+4VzXJyKMJsD239HY5tW8CaftnegGUi4yXt4FBlnI5fGR9
         A2EY7Hx5yZXMLcr/j0a3OLB60c+BPViAxCnsKaViZs2b+iI/iP4hh1q1C/g+VRLbF7y1
         YEHA==
X-Gm-Message-State: AOAM530M1n6TORLxiwd6Jdwyp6ai3kaA8A+MOleF7mXtX7xkrlv1TX/Z
        LwNW9gjThGAvOBZxh3IaEv3Xl839F3UXJQ==
X-Google-Smtp-Source: ABdhPJzqj/EAW8z5vkhdnoxujqmaxtKjRu9bnx7Cp8CahrYjFiG2ADX7OObrxLJxs7N+6NqwivlUuQ==
X-Received: by 2002:ac2:519a:: with SMTP id u26mr470835lfi.73.1602813291634;
        Thu, 15 Oct 2020 18:54:51 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o23sm347005lji.68.2020.10.15.18.54.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 18:54:50 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a4so770059lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 18:54:50 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr514291ljg.314.1602813290254;
 Thu, 15 Oct 2020 18:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201015135345.6b29e8c0@gandalf.local.home>
In-Reply-To: <20201015135345.6b29e8c0@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 18:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
Message-ID: <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.10
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Updates for tracing and bootconfig:

Hmm. I haven't verified that this came from you, but it seems likely..
Once again my clang build shows something that I don't see in my
allmodconfig gcc build:

   WARNING: modpost: vmlinux.o(.text+0x1e5b06): Section mismatch in
reference from the function __trace_early_add_events() to the function
.init.text:__trace_early_add_new_event()
   The function __trace_early_add_events() references
   the function __init __trace_early_add_new_event().
   This is often because __trace_early_add_events lacks a __init
   annotation or the annotation of __trace_early_add_new_event is wrong.

Hmm?

               Linus
