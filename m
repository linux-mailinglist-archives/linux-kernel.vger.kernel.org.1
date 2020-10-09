Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4303E288312
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgJIG51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:57:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:57:26 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so11571913ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOegIKAoFGpB3vfc8+JRask2/1430nKMGo1jpydR3AY=;
        b=X49UIyq4cvy1anNdBJ7Ru0ERAdmgMFZVkebAFi9N0Ww30QBVOclXyUOCzW8cusvuPm
         fUQhVVD7ho2QFZj2F9EBE/SOrAKX6p1rLXDpLpHl4l/nG1LLcXPFkBz9iFEgmaQzEoDv
         BE6TnpoyIsXqe1nC5nu3a113p8TaTuNIBi6oAV3IH5vE+B4rEpQuY5odeWyiBvKFcmCq
         gA4h1u0fZGUhXTc0kAb5/yoHKnea4mZI1Goq7K+nugOidwTgM0Qob18g/zQsuBC8AZho
         MY+zZwoL1YHmgdVDE0x18edQhYH3UbqgEx0IQwg7+K3fcF+nxyFh19sI6U0gZzUKZbSg
         8NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bOegIKAoFGpB3vfc8+JRask2/1430nKMGo1jpydR3AY=;
        b=DjmhN3jUsi6rrdtEAN//vzy89IgPZXdueXcPNe83FT0rnLou5lMn8yXxbhNR2VNcsi
         9h4yagqCP0N5VPQd28yk0lRndsLqiEAaQnccESrJd+rmQJHfkaa5yEUFDd0vSMBNh7yN
         Wpe8t3ssHXj3l6/vzmTnzaYMzCYaiV+TbuY76k3mh5wvEKAvhCa8LGgWnvD2y/LiJh8Z
         SByomN3Qma0QI1REUtHYwBjnHvlYQP1GHKCHaWwEbuxuHGoCVdjI6I0yIYQSfk0y/K+u
         QS8YseqZihcx24QQHDvdiM5MMrTGvRReJU4HFc+MntIZl9Qbhfz2E+aCxmLDOIetjuoG
         4EIQ==
X-Gm-Message-State: AOAM532iuq8z1wSGtHpz6y2tE8ZUVi/lE/bW/Ftkh/h+RFX48fuWnH4o
        cebVfDFYp1yW/RM1i8rnCIW/ZV1WlpQ=
X-Google-Smtp-Source: ABdhPJzkIgU3mo/0q3Vc35Bt/7uxEEHLiupNPZjxMxXb4No1P00Aor6AgXVgwvdn6nNIJyD3HOpcYQ==
X-Received: by 2002:a17:906:280a:: with SMTP id r10mr10770914ejc.58.1602226644839;
        Thu, 08 Oct 2020 23:57:24 -0700 (PDT)
Received: from gmail.com (563BAB65.dsl.pool.telekom.hu. [86.59.171.101])
        by smtp.gmail.com with ESMTPSA id q27sm5917012ejd.74.2020.10.08.23.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 23:57:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 9 Oct 2020 08:57:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, grandmaster@al2klimov.de,
        kernel-team@fb.com, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [GIT PULL memory-model] LKMM commits for v5.10
Message-ID: <20201009065722.GD9972@gmail.com>
References: <20200914175609.GA14435@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914175609.GA14435@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains Linux-Kernel Memory-Model commits for v5.10.
> These have been subjected to LKML review:
> 
> 	https://lore.kernel.org/lkml/20200831182012.GA1965@paulmck-ThinkPad-P72
> 
> All of these have also been subjected to the kbuild test robot and
> -next testing.  The following changes since v5.9-rc1 are available in
> the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm
> 
> for you to fetch changes up to 0ce0c78eff7d22c8a261de6c4305a5abb638c200:
> 
>   tools/memory-model: Expand the cheatsheet.txt notion of relaxed (2020-09-04 11:58:15 -0700)
> 
> ----------------------------------------------------------------
> Alexander A. Klimov (1):
>       Replace HTTP links with HTTPS ones: LKMM
> 
> Paul E. McKenney (4):
>       tools/memory-model: Update recipes.txt prime_numbers.c path
>       tools/memory-model: Improve litmus-test documentation
>       tools/memory-model: Add a simple entry point document
>       tools/memory-model: Expand the cheatsheet.txt notion of relaxed
> 
>  tools/memory-model/Documentation/cheatsheet.txt   |   33 +-
>  tools/memory-model/Documentation/litmus-tests.txt | 1074 +++++++++++++++++++++
>  tools/memory-model/Documentation/recipes.txt      |    4 +-
>  tools/memory-model/Documentation/references.txt   |    2 +-
>  tools/memory-model/Documentation/simple.txt       |  271 ++++++
>  tools/memory-model/README                         |  160 +--
>  6 files changed, 1410 insertions(+), 134 deletions(-)
>  create mode 100644 tools/memory-model/Documentation/litmus-tests.txt
>  create mode 100644 tools/memory-model/Documentation/simple.txt

Pulled, thanks a lot Paul!

	Ingo
