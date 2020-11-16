Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1332B520D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgKPUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgKPUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:10:23 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFC4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:10:23 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id v6so3369237vsd.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oj9Np7wFSXZtmlDe8YVuBVitxmC2wNGTs6qn6itE8VE=;
        b=TVlIaOtsygMBxhH3iiih661HeZ5mh+WjdFZhgA/0POf+XIpQ1yDE+XEtjKYUIoZ0gr
         TQHu9GlFsz901/suOvAiML1ZqeKjijou+N5lp2PGoGcGNoDeBK9njsiJIR3G2HpFN526
         kCoasjdqoi8bP70aEE6TTdjLfzVMxDf0LXyl55pgfhZeNeEpuXZJNjIUrKXE8dyqJAMd
         R6TeHgN27XD51WQBjEP7llUa7OyPAFafy5dWxgm20czTBpnK99CysZ4KuCmen1Mx4FD9
         x9sgaHQVHPjIfklT3NQpnyDTW8qX5XAIDTklzc8K8JLzlpPj5u1lyCQ2TPwHlhI/wnfo
         xpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oj9Np7wFSXZtmlDe8YVuBVitxmC2wNGTs6qn6itE8VE=;
        b=Q8FB7YRn8PkfyCZsc1DhX71MosBzQCZGGHufJjZ0mFqn9pRpd8KGEk8QBr3QI8BDEK
         XZpMQhbyF/oRDtDNMjFV78Z5q0S9FQYlb97vXebCUoXlVbJdbEsrXkIEo9eY/4oH00YE
         mraDTdtVYWsFvqJ90VTTygtCcqs9mOi+fulE+ZaG+pL0NQtRX6UfWWVAyH6LlL2m2/H1
         hpbPoeq7LGOXJu97KuMIobesrhB/Mr0sOG5cx7pCWANeZ0V4nsn8XD4Q52bGClRTwk9D
         sm+6TeTACbD9yQ5f2I1EkWl6yHtgMJWzQYjMCEy8mxl4K23wG/M6fjc3dWcKg7+SkPDO
         BDaQ==
X-Gm-Message-State: AOAM533lOQwmPmHOOH/O6OgeQbRlxaZzpOnJJQNhONZL+3Hh8kr/2YQc
        SmAVINbomlGf6HrplmMkCRoVMmlS4Wjl6AoWB3mHew==
X-Google-Smtp-Source: ABdhPJwBNQqIK3MFY/vODxAzgxSI8zGt+qofeuVhJLjUFYDfSXpmTXD4amyICp5C26KTShYzG57WPQHEWlwb1567K/c=
X-Received: by 2002:a05:6102:448:: with SMTP id e8mr9454410vsq.14.1605557421958;
 Mon, 16 Nov 2020 12:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20201113183414.1446671-1-samitolvanen@google.com> <20201116113931.2b60a191@gandalf.local.home>
In-Reply-To: <20201116113931.2b60a191@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 Nov 2020 12:10:10 -0800
Message-ID: <CABCJKudNGa2=65vATJMqo--8guvWHZ6-wMWHZQy-ZaH32dXdnA@mail.gmail.com>
Subject: Re: [PATCH] samples/ftrace: mark my_tramp[12]? global
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:39 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 13 Nov 2020 10:34:14 -0800
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > my_tramp[12]? are declared as global functions in C, but they are not
> > marked global in the inline assembly definition. This mismatch confuses
> > Clang's Control-Flow Integrity checking. Fix the definitions by adding
> > .globl.
> >
>
> Actually, since that function is not really global, would it work if you
> removed the "extern" from the my_tramp declaration?

Unfortunately not, removing the "extern" doesn't seem to change anything.

> In other words, is there a way to tell C that a function is declared in an
> inline assembly block?

I'm not sure if there's a way to tell C that a static function is
declared in inline assembly. At least I couldn't find a way that would
make the compiler happy.

Sami
