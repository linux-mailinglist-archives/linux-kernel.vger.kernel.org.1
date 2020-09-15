Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583DE26ABF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgIOSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgIOSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:14:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EFC06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:14:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so2419370pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT0mHORaxDdMUqWTyM6bXKGpvP94IwQFIcwyyHppM00=;
        b=oVqB6rH1ygmPOlbcsDJp6t662dBAL0svgY6P3cB7gO5IGclx2mJ+Z6xGpYEV4vEQPr
         LX2mUDMFXjOVeISFJ7TPgUVOht+9qtshJd/mT0A7SdFPO7Z6w1R+FqWQkrhwN2gBPQTw
         /rdvct36NLscqnrIcjwf0sw6JpQUXCtnSTGzNpExiH3WGrHQQqKdoul+9UFlmt7bXIa5
         xkPzSduP739AjHnT2BQ38h0ikswSlVjsKQB4xhBfntXqYk34YcnVMT+gjUvWtXwCuwMj
         0wGytZo5pm5njm9KhvpTLAgP2CsTXj0ZsZCwdBnQMDrVEcmmQu1bz2VyikB87JcU9cIK
         ZqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT0mHORaxDdMUqWTyM6bXKGpvP94IwQFIcwyyHppM00=;
        b=CEIrjEK1O3ypFz31JSU22dY8pn2TLeA9ZHk56D37gmCvDRH/gIStnsTgoJPm1kD63k
         kserudNX8LsNsmkFUlCRFLjR16eFhAuyz2nIy5IRKU1b54PBqA1xycynbbWnmsHyAfOu
         bAKb4GVHYxV6NUxuK9hkLYOjuIw/7pthhuy3LGD9naofzgxXH2DiYZiVxsVL3DV/Jl8f
         l6T46+ZDw+H0+l5plRj6gxoRpkRQshdr6XLmstvep4/YbBa+KWMEP9LuI9tWkmU7BBox
         FvNCvN3SJgcCxK9RyUxclBufpTyXqqHf8rBvAF9Kz9k5RLyc1gPn6AzDY7XpG/Wqp9BL
         qf5g==
X-Gm-Message-State: AOAM5304fp9clkYxQaiOuvGeDXFl3k4dRF9sGtSmZpZuDUM/pOUZrYLn
        h39pC/dlK5669qa5yYNCp5FrbcHBw1lY+n3ujiEnSA==
X-Google-Smtp-Source: ABdhPJxoYdf1sOG5PfqHKd6wvML9dc6l14Gv1d+/SBAyITIcWM+XQeuVX/wpBYCd2oG0inFIsnktJSMCGDsZtIFVRZY=
X-Received: by 2002:a63:31d2:: with SMTP id x201mr16100266pgx.263.1600193645755;
 Tue, 15 Sep 2020 11:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200914160958.889694-1-ndesaulniers@google.com>
 <20200914161643.938408-1-ndesaulniers@google.com> <20200915042233.GA816510@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200915042233.GA816510@ubuntu-n2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 11:13:54 -0700
Message-ID: <CAKwvOdkg6MNBDfEH_A8=HRstAWFA+OcLkMkHsOLjuvSOWF9dxQ@mail.gmail.com>
Subject: Re: [PATCH v5] lib/string.c: implement stpcpy
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lavr <andy.lavr@gmail.com>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 9:22 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> It would be nice to get this into mainline sooner rather than later so
> that it can start filtering into the stable trees. ToT LLVM builds have
> been broken for a month now.

Hi Andrew, I appreciate your help getting this submitted to mainline.

Noting that other folks are hitting this frequently:
https://lore.kernel.org/lkml/CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com/

CrOS folks are already shipping v3 downstream since this is blocking
the release of their toolchain.

(Also, I appreciate folks' thoughts on the comments in the patch, but
please stop delaying this patch from hitting mainline.  You can
rewrite the commit message to whatever you want, delete it for all I
care, please for god's sake please unbreak the build first).
-- 
Thanks,
~Nick Desaulniers
