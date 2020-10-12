Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC81128AE53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgJLGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgJLGqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:46:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E23C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:46:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq12so15756408edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oV/+pj7Fnm5nZaRHqpOkjT78UAULW7d63AGoeM3lX8=;
        b=TeTWSCEsBYqyE/x1ZaeOkH0jWJEzqZ7ade7Tm1kFTgH31HzCcN0hNCHh62tJU51HXo
         oT1/7SjvVBjHHxKmo/6ioy411q0Lew2Z791SIXZMxKBXgleoTXwKqXOyNNnLsGMHo9d0
         +cTV7LNmhJPh1s7mUi2rqebsCXVI4yUVkSL/drzsPeODDm3sQVnnb5dbXYyhw3hhx/wm
         iS3jYetCXUTdyqg4zYSARhPFq28CXyB+zKkODklGDX6GJO4KkCIAFinOTcE+cmXsNi6Q
         4vs8+0YDkbjqMfOplYJWskfn3CRqo227oSBgHHSaMH6yj8m+JXb+qAeT40KP8PiAX0mW
         HpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oV/+pj7Fnm5nZaRHqpOkjT78UAULW7d63AGoeM3lX8=;
        b=ZKcOgigJnKmUKc24eDjfSyCIdSfWWJy55iFAgD0kitv+Dhv5Sw5gXqC3qjC2oeXH9n
         jNgX8rZM5uBlg2nriSXtpmhpELp177BkgCTh/v7iiPCa9MYHUW+IxH/8/Y5vwN1vwJ/b
         2w+LOgIZeknAvAto034R32EN8GvSQtCV/QS55LURv5XeqYLqz3pyqhNnUl3uCVVMBXwX
         CiZTg+f2FXbn/X7B0c0cni2aUnr22VEov2eB1jKUo2+IkoDInPqVQ3vqRGLQwzKq5PBL
         e3CXmHOAyci06H4UY1H9ruFVeZMYS3jL4NYe77XvxbuE1e/dmlxyBFHV6YBhEurKx5pt
         5WPA==
X-Gm-Message-State: AOAM532vylWJsrD/J7N30TglYKwWAaosxgCOLrF9eJWLxrBfvZBv/C2n
        9z6qiA/oWKEQrLFcKA1xQRNq1bYS27E43kgnPgjYkQ==
X-Google-Smtp-Source: ABdhPJwAYFpyF8+D8cV7oXd3QE1aJOiN6i4bqWNX+WYEUPOZPTqnJ6SQkcBzssolp/os/9ZENLm83qg/oBxbASgSqn4=
X-Received: by 2002:aa7:d349:: with SMTP id m9mr12421814edr.51.1602485201449;
 Sun, 11 Oct 2020 23:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <71c7be2db5ee08905f41c3be5c1ad6e2601ce88f.1602431034.git.yifeifz2@illinois.edu>
In-Reply-To: <71c7be2db5ee08905f41c3be5c1ad6e2601ce88f.1602431034.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 12 Oct 2020 08:46:15 +0200
Message-ID: <CAG48ez0waTA3+Bs9UWx4HSx3Pktq-6K-z67hmcTV0Fr-NYGdMw@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 5:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> SECCOMP_CACHE will only operate on syscalls that do not access
> any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> return allow regardless of syscall arguments for a given
> architecture number / syscall number pair. This is implemented
> here with a pseudo-emulator, and stored in a per-filter bitmap.
>
> In order to build this bitmap at filter attach time, each filter is
> emulated for every syscall (under each possible architecture), and
> checked for any accesses of struct seccomp_data that are not the "arch"
> nor "nr" (syscall) members. If only "arch" and "nr" are examined, and
> the program returns allow, then we can be sure that the filter must
> return allow independent from syscall arguments.
>
> Nearly all seccomp filters are built from these cBPF instructions:
>
> BPF_LD  | BPF_W    | BPF_ABS
> BPF_JMP | BPF_JEQ  | BPF_K
> BPF_JMP | BPF_JGE  | BPF_K
> BPF_JMP | BPF_JGT  | BPF_K
> BPF_JMP | BPF_JSET | BPF_K
> BPF_JMP | BPF_JA
> BPF_RET | BPF_K
> BPF_ALU | BPF_AND  | BPF_K
>
> Each of these instructions are emulated. Any weirdness or loading
> from a syscall argument will cause the emulator to bail.
>
> The emulation is also halted if it reaches a return. In that case,
> if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
>
> Emulator structure and comments are from Kees [1] and Jann [2].
>
> Emulation is done at attach time. If a filter depends on more
> filters, and if the dependee does not guarantee to allow the
> syscall, then we skip the emulation of this syscall.
>
> [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
>
> Suggested-by: Jann Horn <jannh@google.com>
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

Reviewed-by: Jann Horn <jannh@google.com>
