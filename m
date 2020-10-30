Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7099D2A0A37
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgJ3PsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgJ3PsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:48:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A561C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:48:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y184so6507497lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j9MvZAkv2TdlLOuFExl51d6NRInBubzjQm2bixjf9+o=;
        b=rxzca7Mj48CKK/QQLljwWpghniXvYG/RGO5+vvBYzc/9s4+mpm0fkR0dgk/DfzxYWP
         IqqYxx5NetaKo+Kj4QUbAY129RlDND5Jpjx002AGSO+tkMj4Zxy66J96kuqiVEauhCzB
         0jAqo0GgwtvsRp3QIcRtrJku33OqrN1ha6LH8sJkFoYKqIKAP9W6xREVUgyOe0cAIoZz
         l1HvbfK0EBuyJzdUydBS7uQjca69aFfZz9UTTOsacwMLyqijMErLPqB1bD40Ykc63/dz
         E70l71DDEtZs5IXWrcqEuJYgL1nbKuge2d7Axn0V8HHoBrE88iLw7OtcWY/bgTuYtKsx
         tz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j9MvZAkv2TdlLOuFExl51d6NRInBubzjQm2bixjf9+o=;
        b=ukpSQX90fMFxYIHkkfFwV8GNXsIybybp3E7cgGF7zlCFa19lX9CyUUUDiozve/z3nC
         ravNBB2j9XwngC4IJqRPu/V6K+Df9xC3ITqwElsOY0+QGt5D5k5H8V2VS9yM3kMohqLu
         hx4iYANj/JCaQs2tIqW2qyKokcxBsVaXg6uLHOZOWlIXtHJCmrhKaHvyLFcNHoszKEMy
         /L0feMGfgFJKf9o12MG5KWsFDCVs2pbhvFo672w8GI99UPI+lNsWstdnWZp36KJVK+S9
         La2P3UEVTTQso0pHbLmURQOhmWcOvZJyNgGLJF5irFitLwc0wL+A0h0dNisuVAj1MOi/
         VTkQ==
X-Gm-Message-State: AOAM531OZ0vMtfyerC0qpDTJPJVQL/v5cD9Yh55Y3GvNQbFjRmwQoeIh
        9YOcUERYsdjhaapuhGDt3EbcRhnpaORB5OkFEngJNA==
X-Google-Smtp-Source: ABdhPJzb/fuhiHNaRkHEFJu3oBYeUtAYlX2L3AZnVTS9zYsBAVeRmiA9g8smAyZlnBMtKPUXAnzCGfID1DLYdpZgi4M=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr1155386lfr.198.1604072893836;
 Fri, 30 Oct 2020 08:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201030123849.770769-1-mic@digikod.net> <20201030123849.770769-2-mic@digikod.net>
In-Reply-To: <20201030123849.770769-2-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 16:47:47 +0100
Message-ID: <CAG48ez1LFAKoi-nvipsar2SAH0eNhKkOzWj4Fuf9wNCtpWsH9A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ptrace: Set PF_SUPERPRIV when checking capability
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Drewry <wad@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 1:39 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> Commit 69f594a38967 ("ptrace: do not audit capability check when outputin=
g
> /proc/pid/stat") replaced the use of ns_capable() with
> has_ns_capability{,_noaudit}() which doesn't set PF_SUPERPRIV.
>
> Commit 6b3ad6649a4c ("ptrace: reintroduce usage of subjective credentials=
 in
> ptrace_has_cap()") replaced has_ns_capability{,_noaudit}() with
> security_capable(), which doesn't set PF_SUPERPRIV neither.
>
> Since commit 98f368e9e263 ("kernel: Add noaudit variant of ns_capable()")=
, a
> new ns_capable_noaudit() helper is available.  Let's use it!
>
> As a result, the signature of ptrace_has_cap() is restored to its origina=
l one.
>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Fixes: 6b3ad6649a4c ("ptrace: reintroduce usage of subjective credentials=
 in ptrace_has_cap()")
> Fixes: 69f594a38967 ("ptrace: do not audit capability check when outputin=
g /proc/pid/stat")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Yeah... I guess this makes sense. (We'd have to undo or change it if
we ever end up needing to use a different set of credentials, e.g.
from ->f_cred, but I guess that's really something we should avoid
anyway.)

Reviewed-by: Jann Horn <jannh@google.com>

with one nit:


[...]
>  /* Returns 0 on success, -errno on denial. */
>  static int __ptrace_may_access(struct task_struct *task, unsigned int mo=
de)
>  {
> -       const struct cred *cred =3D current_cred(), *tcred;
> +       const struct cred *const cred =3D current_cred(), *tcred;

This is an unrelated change, and almost no kernel code marks local
pointer variables as "const". I would drop this change from the patch.

>         struct mm_struct *mm;
>         kuid_t caller_uid;
>         kgid_t caller_gid;
