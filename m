Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEF2842D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJEXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:10:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB7FC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 16:10:50 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q1so9375389ilt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+19In+AF8vbe5roNkvtzXIzPIKxxJmAyqKvRnxYHxg=;
        b=BS6SH4XjD2E9BeMtV9Ry2peuJIXCcVp+SN4ASVt01msa0PaugSkbAwCspmEfvCmJKA
         6sC3wb5pIZFqhpAMtCaWe3siCscKGSI+iF8xTxKYh6eplHGmlYLnOzpB1rKk5kkJIR7y
         mQKmQdNJCwtMubZDEnmsEbsUmNAutr+Ox/RbL7cA/MrebykTkb+cLZ17ROha0JGOZC1M
         okkrKPlDmmLZoa/QstcF8VL04RXC1xCo6DWNBtu5Bq2XQwu7hjpq825VnbeDoozZbPTg
         VNvNyWgRF4YFufyFhRGWpcJAEqOo42v/k077GX4zdSGGnfV8IQ1nLyqiiG8OLD6KAkh4
         fYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+19In+AF8vbe5roNkvtzXIzPIKxxJmAyqKvRnxYHxg=;
        b=Y+Tec9DRm8txydA0UxbThv4N0oIzzv4wn9qW/bRbA8cUdvMmR6O4gGlvlXauWqg8AW
         Xtgr88t05A2aciojP2vyBR9zWb5wLWY6lWayD5D7VFCf66fQaHIst7WDB9UjCkhWJ7YM
         ubx2HzFZ+EzhPaaTBlUozLn+kb6xTYEwNFUcgE/lM6E0KhnXj+XG8yAmN9qp9bhicsUn
         R5QVSByO5iP3/TOS21TUETEAMLmfG5oiE5T2YgSXimZj4fvhs7+4+5aSY6tp6xonU1ut
         2PgRdOhnqlplZHC4C3kgoIU/Y/P9lZ6pAstuoeQt9ZSU8svp0Q/XdiElsQ7ISIO/XtKp
         7aHQ==
X-Gm-Message-State: AOAM531jylMsqFLobzjz+0CXk98ubjOtDh9n+iQO266LQLxp0oPQQw8u
        gD9m6bmEjzvzUcI4fZhrGn/pWzIjpNOFc0KPMA==
X-Google-Smtp-Source: ABdhPJwYOe9jPW3SMkdh5mYsVyRUN/Q79GKl/WUiTcYecraiKvSDabUBijfHHpJMbLX3H69f1UJ5nAI4FYzuCTNV0T8=
X-Received: by 2002:a92:b109:: with SMTP id t9mr1270322ilh.191.1601939450075;
 Mon, 05 Oct 2020 16:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601925251.git.luto@kernel.org>
In-Reply-To: <cover.1601925251.git.luto@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 5 Oct 2020 19:10:39 -0400
Message-ID: <CAMzpN2j9h7FjpG_s_a09vKTCV+CYafjsKgK-k2RH7TG59FWz-w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Clean up x86_32 stackprotector
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> x86_32 stackprotector is a maintenance nightmare.  Clean it up.  This
> disables stackprotector on x86_32 on GCC 8.1 and on all clang
> versions -- I'll file a bug for the latter.

This should be doable on 64-bit too.  All that would need to be done
is to remove the zero-base of the percpu segment (which would simplify
alot of other code).

--
Brian Gerst
