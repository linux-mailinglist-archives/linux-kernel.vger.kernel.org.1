Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A067628EB50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgJOCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 22:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJOCsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:48:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 19:48:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z2so1808560lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPmN39XMdhH/ZRzEWbdWRJa4YGst6YX4ITt4ggC9sgk=;
        b=H7wKZzmknLGSwJX8VVMAlFL2hjitpKjoF2M0l3LGbtFcQhq6fmjQGIu0Mb77YCa8qb
         bpr2OddXeAy1ASmwtlmu8twK2w5a/a1VchvtD/FmunIJolvudip8ACBxLYa7jJ06ix40
         ZpAiCTTlJ3OI59TEjqTICKyQyumqI82mBPYIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPmN39XMdhH/ZRzEWbdWRJa4YGst6YX4ITt4ggC9sgk=;
        b=nhSWbJWeVDrlc81uLX9NBQf+yBAScqVVIY9Sq2F308xbCQeR2gHunp8ih/B4V2igMV
         HfuQ6voWCVBM7gg+3H/el77CyT1d9TFYS4RSqxUR5m6x3ePaicLx78P5keHGQkEoNa8R
         l699ObqcfB17szMtY9wNg8MAllYhUlL7kKJUXR17SwcOmLyrqt/REFJTznLacED8RRKL
         7NNlyNazTUoddipjy7+sTndGoUzXdHjhFcv6tQeb5mDliodh1+HLGH64FhK7c8YgQfk0
         9HuwtPF9/GXak3nUZpn0tStrORsfeQU0C3wO2UEq8ighdWd+ZG8QEmpafT0LwPQ59xIx
         9fiA==
X-Gm-Message-State: AOAM532GKcUqGrkKe1od/e+2qg1HRvWg1coOW0QwHqPhdhWUo/QpOgni
        gFsEfi6xJYKwmx2qeYEJA68C4PRYqSS9aw==
X-Google-Smtp-Source: ABdhPJwoIZbOfYfUuQ9cd24uXkL/cacUQfvFmvMV5WwzbXlrtiO/pHMtY6AqM+LyzsJ/mdM7qWuv/Q==
X-Received: by 2002:a19:ee12:: with SMTP id g18mr338138lfb.515.1602730124339;
        Wed, 14 Oct 2020 19:48:44 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id p145sm456383lfa.256.2020.10.14.19.48.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 19:48:42 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c141so1783341lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 19:48:42 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr336886lfa.603.1602730121761;
 Wed, 14 Oct 2020 19:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
In-Reply-To: <160272187483.913987.4254237066433242737.stgit@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 19:48:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXt28aJAoW_8gD=g1jvNaAE8NZ9M9eb7EknCJkzWc4qw@mail.gmail.com>
Message-ID: <CAHk-=wiXt28aJAoW_8gD=g1jvNaAE8NZ9M9eb7EknCJkzWc4qw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs: move the clone/dedupe/remap helpers to a single file
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 5:31 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> So, I have a few questions, particularly for Al, Andrew, and Linus:
>
> (1) Do you find this reorganizing acceptable?

I don't see a problem.

> (3) Can I just grab the copyrights from mm/filemap.c?  Or fs/read_write.c?
> Or something entirely different?

Heh. Those copyright notices look pretty old, and I'm not sure how
much - if anything - I had to do with the remap helpers.

I suspect just a

   // SPDX-License-Identifier: GPL-2.0-only

is fine, with no need to try to drag along any other copyright notice
history from those two files.

               Linus
