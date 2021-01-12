Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C62F37AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391780AbhALRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733158AbhALRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:52:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:51:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so3426562wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dc9D9kzGZ2ZA5/IGxy9YXdBrDfjCBmJRySfS8jH0QkE=;
        b=nxSORGEdGJuIC6RLk0S+VmYqG+YT4lluF3NVUR1z++pI98NKE+pXWwDACJZZ2nUvwI
         I67AS1SNRhL7719zYR/pF2yF3nzxBx6C0WeTJiQvh9HG6EIdZLrNnKow7p/6X7h+nFNC
         ZSApO2FLIy8W6GSdlvaR2xhcCEdxDfZAoLcRoDHjJZncFmLnv3rT4eqFZ5Y83tP1hmy1
         kTzVUAhUtJ0OtwbnMCYtSnzEBOOCDlpqqDtQsOF0Fd/nBPcjsm5jnUZOt4hKcOVXqyOw
         EadOO9S/jLj1qbBscMSW1rvOUp7/TejOZjuBAUnhsMHid0BQ8/wo+DRMxevlxEDfnF/e
         ishg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dc9D9kzGZ2ZA5/IGxy9YXdBrDfjCBmJRySfS8jH0QkE=;
        b=quaX+YHFXlEDdWPc5wbje//zVwV0z0TRqobW8R917sqzcpaI0t/qV+NRQ6Zl6oaevv
         n2ompxDqcYYCAP6/lKjl/JzAiLIWXAaZhRZiBdGT7R65dcDy+E0tOw9NVS3U/FwO1teE
         gb9+T1SiV97Fmwo9FuF36ErDbD8hGLNl4yLJNLCe2LZLelLjo8vxL3uMn158yhyBgWjz
         ikq4vanWLPqFlYNirv8N3GHbOQqMAOd+bOPAiuAxfGhBOuHnJ8yUM0g8QZSN0jkXh9sa
         rANWd0iE0EX9pUGej69nd1LFD8NeOZwR/D3v72ihQcQxQXcEjfXBWTeLaa/pW/KCcmn2
         QXWA==
X-Gm-Message-State: AOAM531iGDOHj0iLyM3aXp9S5eLHKxSgrW8i/YkYIlsK5zP9YSH8PZtz
        tr2Q1ZDMfrmtME2RPJIi2gifKUW+k6QrRXkB0MXkyg==
X-Google-Smtp-Source: ABdhPJzkme70rMBhPR9VaW82DTpFY95K7cDVRzDE3XVA/6rKYEEwL46QI1MREMV9yXBdxUBbkF5ZIioCwWcFrJ4vd8E=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr26097wru.334.1610473895539;
 Tue, 12 Jan 2021 09:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com>
In-Reply-To: <20210112174507.GA23780@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Jan 2021 09:51:24 -0800
Message-ID: <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/12, Michal Hocko wrote:
> >
> > On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> >
> > > What we want is the ability for one process to influence another process
> > > in order to optimize performance across the entire system while leaving
> > > the security boundary intact.
> > > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > > and CAP_SYS_NICE for influencing process performance.
> >
> > I have to say that ptrace modes are rather obscure to me. So I cannot
> > really judge whether MODE_READ is sufficient. My understanding has
> > always been that this is requred to RO access to the address space. But
> > this operation clearly has a visible side effect. Do we have any actual
> > documentation for the existing modes?
> >
> > I would be really curious to hear from Jann and Oleg (now Cced).
>
> Can't comment, sorry. I never understood these security checks and never tried.
> IIUC only selinux/etc can treat ATTACH/READ differently and I have no idea what
> is the difference.

I haven't seen a written explanation on ptrace modes but when I
consulted Jann his explanation was:

PTRACE_MODE_READ means you can inspect metadata about processes with
the specified domain, across UID boundaries.
PTRACE_MODE_ATTACH means you can fully impersonate processes with the
specified domain, across UID boundaries.

He did agree that in this case PTRACE_MODE_ATTACH seems too
restrictive (we do not try to gain full control or impersonate a
process) and PTRACE_MODE_READ is a better choice.

>
> Oleg.
>
