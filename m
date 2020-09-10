Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90561265133
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIJUrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 16:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIJU2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:28:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:28:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n22so7701423edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOtT3N7XbGpRxpxc8ChGzc7KDQ9tSEwlVL00HtmCks8=;
        b=C/Nbbf4T5rPk5brkoe050E2pcKCOvUasKnRCCFebyKdoxklwvBx0WXCmqjsDrbtpQV
         jR6WiarrGjbLiEQkOEZuNuB/YvertASUjGXTd4haT9x7o9clqXR3JKVcu0UMmGqYZUmU
         VAsc6ulw4hGipMG2uE+lsgPcKmNCYpytB/IHs6Oxg8HuAoZWBCKBvclBqizD+4L+LwfK
         nsSI43tbcdKmURrSC9zJfS5oLkDHyWRaABxsMPLIICw+pxAgpBCM5dVXdO+OuZg2E//b
         2h5kExRMIJy0tPvpHdEeBK6feABcxtN2G01klGZ6ScnLzyaR3hPS/Of9tc91a739PUWU
         5RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOtT3N7XbGpRxpxc8ChGzc7KDQ9tSEwlVL00HtmCks8=;
        b=Sy099sNCgVDl/925BjbENNOGkADJ2zgPWVhaz5qoqzo575VgS9GZOnKydSYpFyMhAZ
         MmSSLVa7u1S3W7YnlrIHAqydb/LN1uvLGAjKPZiSxPwYVJm6/LRVHijzyDBVjpKhBTlI
         hNjgIXDCKvadE2CxCjUftc+VWTtyaN+0qgnyl4pUROG1owfUp/QLO2sOLedsXfs2i1OK
         uJxhsy+77dLTwbqh94ENYk8bM3KDb3EnUYgbw+HQE1R98+SJyWTOCEODLdz7gkHQ1XwM
         zrGvCK11z/xp/NrhnmIgIUjWVoXA568Ui2N8KyYnYAMftfElDG6TKjLOjMwJ7HL2rwVg
         tf/w==
X-Gm-Message-State: AOAM531QsREc2eGD++Aprh+m98uUyGYC6b+eU6uRAEoeoZBTKnHdhUlr
        ThJPWzuQ25qNec1UA7V89DDp1Xw5fVZqbEBadPos7A==
X-Google-Smtp-Source: ABdhPJw5R/5Ez4aDdMGu21cR5k0AUCPks8j2VqSHJM0t1OaVkhoHiaB7U2J+4k9K0u43oPA3YLYttkRf9QTiPALFrsk=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr11069998edt.223.1599769681295;
 Thu, 10 Sep 2020 13:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org> <20200910202107.3799376-4-keescook@chromium.org>
In-Reply-To: <20200910202107.3799376-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 22:27:35 +0200
Message-ID: <CAG48ez3om6tRSjZhq4RBtbRCZaupTPJewEYbtN9Q-NCUzDjkqA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] security/fbfam: Use the api to manage statistics
To:     Kees Cook <keescook@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:21 PM Kees Cook <keescook@chromium.org> wrote:
> Use the previous defined api to manage statistics calling it accordingly
> when a task forks, calls execve or exits.

You defined functions that return error codes in the previous patch,
but here you ignore the return values. That's a bad idea.

You should probably check the return value in execve() (and fail the
execution in the case where memory allocation fails), and make it so
that the other functions always succeed.
