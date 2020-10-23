Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01CF297809
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbgJWUDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbgJWUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:03:36 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17776C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:03:35 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id d15so2165952ybl.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sL+bG1sqMHkQncq4Op9T7TZBeUfdZ7Ectn5rHvgjdY=;
        b=Xj60c/JJiEUDW/nQi3Zu+winDPCU+pFOwg1VSiH62tOwtrW0i290GH3JwGZoUHZtHx
         XEOVI9KFxHSDicwA4vd4noZJQ+so5tQXC0QJyXjTWr1ow/eTB4f5cmXelY1eRlb0gBIo
         ZqLoO4rDTAMJqkTWSgCrxVbJxNDPkMtHvkhAIP1XWzzJuOwZHWdLzg+QdmK5ya3OFtM+
         BwZIsRINJCFWoe+7Wa3TElK8sun3aT/up/nWATxpHQ76pVdK3tpxCiCJdUIhJpuBgzVT
         7YyoPAPskCWXzrVJvp3/+nZTacsRulzLpUSWSLojruskOlI8mKTl6TDU58lPZaIrYoxX
         q/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sL+bG1sqMHkQncq4Op9T7TZBeUfdZ7Ectn5rHvgjdY=;
        b=J68CxyP44Pg96hS8tcG/d3U4EJpLmm6P+KXgiEOov+CD+5w7PQG/i8k+TaRcgtlhud
         7bVgW2tqG9sn5auCMnOtMxTqic5xinhpfLN1Uhxl5D1yNdsLu2vlXxbDqjsSFhI5MUq9
         lRey7ARRNcrk1lYkVcFp5LTl/+8lzjORMiC+TS7sEi7ziwL5r4XL0e0pxqxeRj2R1D3h
         ZhqA2H1s+wAF5S7GrYM2Hw2w5MFd5IHctSTYwoUnnkn5MpNuzcMMxFEl4Ugc49K2OlJJ
         4UdvPN1jroqmkpObQwKLu2LVTMwcORPl7QKp4NiWLqAjkocC6sQ4KQnGthYF5XGVCS0r
         zLNg==
X-Gm-Message-State: AOAM532JyJ193IPkFjNYWWlh01u9zaD5xeeF972bZOwR6q+5WNMwl2et
        ETUmk4UxXqlmGC++c1CaTnnmJbBBCeA9Jyp4HI0=
X-Google-Smtp-Source: ABdhPJz5KsCW+JmSszBCoUsaIbeELOddhzELtCYLQyx0ud6rdY/6qViPIMKZAHt7zz9Jqh/2BWGpqAnhIQcbfduu2Uc=
X-Received: by 2002:a25:ae97:: with SMTP id b23mr6341309ybj.26.1603483414252;
 Fri, 23 Oct 2020 13:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com> <64b49cd3680f45808dad286b408e7b196c31ec79.camel@perches.com>
In-Reply-To: <64b49cd3680f45808dad286b408e7b196c31ec79.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 23 Oct 2020 22:03:23 +0200
Message-ID: <CANiq72=AneP9=NBFpE2eFzqsYnQxEVjxHQQYSybBCeh6_vWHMg@mail.gmail.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 10:03 AM Joe Perches <joe@perches.com> wrote:
>
> Thanks Miguel, but IMO it doesn't need time in next.

You're welcome! It never hurts to keep things for a bit there.

> Applying it just before an rc1 minimizes conflicts.

There shouldn't be many conflicts after -rc1. The amount of changes is
reasonable too, so no need to apply the script directly. In any case,
if you prefer that Linus picks it up himself right away for this -rc1,
it looks good to me (with the caveat that it isn't tested):

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
