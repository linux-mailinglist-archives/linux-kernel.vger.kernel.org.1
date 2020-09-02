Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF525B312
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIBRlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 13:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:41:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0764C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:41:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so25720pfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znhEfk0qTGWBjhVRC5OGNZnEjwpfUwpiOjd2s/MZEpw=;
        b=d39r+fQ+ZKppU6xr06OXOhgfj4QOu9x/V4/qeLwYIEZowrhfMPnCGYnHc8e2rr5bNg
         hosNhQIfLCa9gHNfwq9djzCOomM8TSBsmIpLr5aGCorfhi23KtVPw7VuKXDHHC7m64pD
         9mczWXHGWHWDj7GO254W0OS6GgkG9+dOQ/nCsMp8iS1gQ373tNOGry74xYrh+Dx+4IUC
         iiTJ8cs40ETrMJOsdGnbPi3rBY1LZzlobMcJn7nSKWvau2Z6kLl5r7uLTisVL9AIOB6x
         BPUiCO4CwmY0SqXbmR3gOtM2FX13w+TlllYsaf1NYA2afjf2L4DQPLlOqsCHgxXFJBg1
         c49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znhEfk0qTGWBjhVRC5OGNZnEjwpfUwpiOjd2s/MZEpw=;
        b=pjj+9nLpyHwF8/psf1O181F7c5G/A38u6ATu8JY4+r/C680T3Wri0mPi5cT3c0a0Ca
         W402GoQAy1lZ+I66sXhVRkGD2WMrUH9ln7+RBxzZQ5lGApqWULpGN2KGG6M790I40RqR
         AYvd/9Xi7ysXRV98n6NeDMHVKXjvsoeccJ9dzifWjCcfkoQJj38kquI9f3vs1Cl7pCq+
         fAu73LyQm/wSIAPmxS8dfLffjKqLvYqGREekzPbuYju52DbLfeL0eC2sKz4vpMSgRjCg
         MJHE3RUulaKO/J4cemFpds0yhs9nDeySMMvJJvgKjveuHWcKcgw38WIey8HuPlwlszau
         OPIQ==
X-Gm-Message-State: AOAM532MXn/sJQFMJmGspNVk1bWhvpCLyMMAFcYJvQUaQG9/tfWEVqPB
        sn+1yT7xXP7wTu7cRNa7/DL8vyy7E5ns+qQEj9WTsw==
X-Google-Smtp-Source: ABdhPJzC5f9FwVt7oqUVenernnCrhELQIg8r9QLPwTdiiB+Q0kv2dXLebNbp/nRBqFOm3g52zmuOiErLfVTe7yrOsPI=
X-Received: by 2002:a63:9d09:: with SMTP id i9mr2625820pgd.381.1599068495912;
 Wed, 02 Sep 2020 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-2-ndesaulniers@google.com> <87blio1ilu.fsf@mpe.ellerman.id.au>
In-Reply-To: <87blio1ilu.fsf@mpe.ellerman.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Sep 2020 10:41:24 -0700
Message-ID: <CAKwvOd=ZeJU+vLUk2P7FpX35haj7AC50B9Yps4pyoGCpd7ueTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/vdso64: link vdso64 with linker
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:14 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Nick Desaulniers <ndesaulniers@google.com> writes:
> > Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
>
> I think I'll just revert that for v5.9 ?

SGTM; you'll probably still want these changes with some modifications
at some point; vdso32 did have at least one orphaned section, and will
be important for hermetic builds.  Seeing crashes in supported
versions of the tools ties our hands at the moment.
-- 
Thanks,
~Nick Desaulniers
