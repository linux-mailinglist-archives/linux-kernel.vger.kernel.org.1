Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099A72796F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 06:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgIZEfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 00:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgIZEfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 00:35:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E7C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:35:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so4144911pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mRcwOzZAXRqD5t0WunR2xZRGQlJgJ5v6Cl490f6L2w4=;
        b=TWHocp6Xnlj+Fal/pEAcaz9wDHWf5v8XigHCHnEgYkDAlglQrvdlT3J1d4RmRbUM5G
         oWQjXg12yMjV+3i57IYSebyR+e7kdcE8TnPGHZXUJLngz9RYIkHXBP8k0L5y0iuLMbmS
         G8h+pUUY+GNQEWLdLBFvHdE3ncAEFTwNfZnkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mRcwOzZAXRqD5t0WunR2xZRGQlJgJ5v6Cl490f6L2w4=;
        b=lEHREl8EvyrhkuZn3D+s6jo/XmZgCOgMM/gyX3z0vS9LLv7G0R4TNkhX7B1wKuJRHX
         HK8U/Spqw+Tuh21bLLkhquuvyopQ7ZrN4O1Z7xaoZ3k9h6wDzANlX+SPJX9NHgSqYbnB
         7hyyXxeIpIjI0yerAnaCsJKVJRWwaWH5AVDSg+wbVFb/3GHouek3tGv+DhM6+zl3Ir8w
         +6ryN6eSVw8ooWeXfbl90qhpZtsY7gk8Bftreh8YZSWXGuX4DxPnEUtyvfoYG0axYmql
         apz6Cx26E7j5jvypgwe+Z64QgrCHbIe+rAQb0YV8AXGmoRA6ySnria2yGoYxf8FtcvDH
         +5Sg==
X-Gm-Message-State: AOAM532A41aEnEx84h4foIOr6Ki1aeXHOqBoT+LQkSg1bBHxyR+Sy5nP
        DB8jYfU87akII5W2jOvVH8uq9g==
X-Google-Smtp-Source: ABdhPJwZ8nK5Yal21qEXtJstQ1g6ry9hFYoph8xJ4equzc56hECGkz66N29kZWed4jPsUpReqJJ0YA==
X-Received: by 2002:a65:615a:: with SMTP id o26mr1648183pgv.54.1601094903117;
        Fri, 25 Sep 2020 21:35:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y202sm4057138pfc.179.2020.09.25.21.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 21:35:02 -0700 (PDT)
Date:   Fri, 25 Sep 2020 21:35:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
Message-ID: <202009252134.871EFAB61@keescook>
References: <CABqSeASR0bQ7Y302SkZ639NM=roSVRmd3ROGm0YDEFCTxxd63w@mail.gmail.com>
 <05109FF5-65C9-491E-9D9D-2FECE4F8B2B0@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05109FF5-65C9-491E-9D9D-2FECE4F8B2B0@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 07:47:47PM -0700, Andy Lutomirski wrote:
> 
> > On Sep 25, 2020, at 6:23 PM, YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > 
> > ﻿On Fri, Sep 25, 2020 at 4:07 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >> We'd need at least three states per syscall: unknown, always-allow,
> >> and need-to-run-filter.
> >> 
> >> The downsides are less determinism and a bit of an uglier
> >> implementation.  The upside is that we don't need to loop over all
> >> syscalls at load -- instead the time that each operation takes is
> >> independent of the total number of syscalls on the system.  And we can
> >> entirely avoid, say, evaluating the x32 case until the task tries an
> >> x32 syscall.
> > 
> > I was really afraid of multiple tasks writing to the bitmaps at once,
> > hence I used bitmap-per-task. Now I think about it, if this stays
> > lockless, the worst thing that can happen is that a write undo a bit
> > set by another task. In this case, if the "known" bit is cleared then
> > the worst would be the emulation is run many times. But if the "always
> > allow" is cleared but not "known" bit then we have an issue: the
> > syscall will always be executed in BPF.
> > 
> 
> If you interleave the bits, then you can read and write them atomically — both bits for any given syscall will be in the same word.

I think we can just hold the spinlock. :)

-- 
Kees Cook
