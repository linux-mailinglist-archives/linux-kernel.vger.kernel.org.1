Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5F1E99CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgEaSKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 14:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgEaSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:10:21 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AC1206E2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590948621;
        bh=coKg1dFR2wviMowGB6sRKtlm96WsZo+FklYL+j+PeIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TOGypFkaW4/TfPCmS5SCQN1GbSYnBKnbrtk9tQSbQxFXTueNA6ujFwr6IgLLlSdHd
         nRVOcsoGEoI1eCI+Ekj2x6FKelUwoTvohXc3NHx4FWn7gKGoNoy9COLNEbHWTzjgxF
         +EIHYGwov2gPdAta3vlWRq6LlNh06j/EAR5uZAqU=
Received: by mail-wm1-f48.google.com with SMTP id d128so9211214wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 11:10:20 -0700 (PDT)
X-Gm-Message-State: AOAM532eUy6R0ZLEvsh0Mo9TttQeLpIqn5Y0I5sp9IdbG7ORAtyDayg8
        d1j5r+57pfYJaZf0u1ltSCXEeYTUI/qlENyxIn7g5A==
X-Google-Smtp-Source: ABdhPJwfCL2ZvJtCsgkpFp5o3LMlfxxpc3pgXA1R6bHM7bTcP3sPGZVd2dsjD7jHA2iB11A5WGh7kPwW5LvJlm/uH04=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr17292708wma.36.1590948619546;
 Sun, 31 May 2020 11:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <85367hkl06.fsf@collabora.com> <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
In-Reply-To: <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 May 2020 11:10:08 -0700
X-Gmail-Original-Message-ID: <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
Message-ID: <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Paul Gofman <gofmanp@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 5:56 AM Paul Gofman <gofmanp@gmail.com> wrote:
>
> On 5/31/20 03:59, Andy Lutomirski wrote:
> >
> > I=E2=80=99m suggesting that the kernel learn how to help you, maybe lik=
e this:
> >
> > prctl(PR_SET_SYSCALL_THUNK, target, address_of_unredirected_syscall, 0,=
 0, 0, 0);
> >
> > This would be inherited on clone/fork and cleared on execve.
> >
> If we are talking about explicit specification of syscall addresses to
> be trapped by Wine, the problem here is that we don't have any way of
> knowing the exact addresses of syscalls to be redirected. We would need
> some way to find those syscalls in the highly obfuscated dynamically
> generated code, the whole purpose of which is to prevent  disassembling,
> debugging and finding things like that in it. What we do know is that if
> a syscall is executed from any memory which Wine allocates for Windows
> application then it should be treated as Windows syscall and routed to
> the Wine's dispatch function. Those code areas can be dynamically
> allocated and deallocated.

That's not what I meant.  I meant that you would set the kernel up to
redirect *all* syscalls from the thread with the sole exception of one
syscall instruction in the thunk.  This would catch Windows syscalls
and Linux syscalls.  The thunk would determine whether the original
syscall was Linux or Windows and handle it accordingly.

This may interact poorly with the DRM scheme.  The redzone might need
to be respected, or stack switching might be needed.
