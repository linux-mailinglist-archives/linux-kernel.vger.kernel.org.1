Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42022A1216
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 01:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgJaAmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 20:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaAmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 20:42:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F920C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 17:42:25 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g13so3647790qvu.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2nCYiEm+IbF/LFROQiqf37AUYYLUchursimxsEbcy9c=;
        b=j04Cfy1cVQYx0NZi2hs72JLDjXni0m9WMZcoybEUleKw7jARFx8UbuIgC+cZWD/MP6
         0UqBZSN7cpQmJxgM4NGymVX03rWjdvPbKqjGMA/3z7TIQXrYAwSsz5YQSR2TKDkmH/uK
         hgaUGegY3OKVWZhzIaQEKTMi+auOMdJVKXtT0V7AlbShCurG+QsSjj57wNoQpNB+DWjX
         ooOgs8JKzW0k7xb9AxgeuW2O9+aSRcEOIG/COlwH7UuRB1ehMdvotdCX2+JsKsFQcLZG
         1K06gCDfme1gfX69u9S3xqY08toRxGTdHsR5rbWnzQ1dWu3X5uIOBcoH3duQIw+IHhS/
         gl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nCYiEm+IbF/LFROQiqf37AUYYLUchursimxsEbcy9c=;
        b=RyBrbHcJVYBGD9YLfEUNWa98euMM4HSd8IuAof7B8ZKtfX9oE1JvpCeWjFnVr4mtA9
         dB5XfOXq+Oxn3lp1NS+E6H3vKoXHkOF2FDpuaQyTsV2edj1jFuF4YUvE1ePod/KsDXq1
         mFdYoNin+yw2lUeS66aSlV40M3JdxcxzBJmD1O/j1hhKiRjg6xheLDum1l4NJg5oJrUc
         diWTrBy0kk63tMEB+2RyUawI6oSPETM9lLyWbQLk04Lurmq6ZCaVm9BjacVbraccys3D
         n/jhyJfMQuDUSKiMBZDLT4FUaGZ0YrXag27IcIvKovA4S47+H4zJekq4C8+PyEXPXtda
         PstA==
X-Gm-Message-State: AOAM533+jJwc47HEIe1L0MuEKk91R66KPZRMSx5/9XtNjmTE0E1xRZXl
        aKenhEy4CIrdAcgNboXYbsRGSAOCkm777vJ/8bbCsg==
X-Google-Smtp-Source: ABdhPJyUatzz1tJlP9gPTZ715ieVksd+tixuLcVJe15V+uD7uLWN5QQkp6GhUyG5oOqcEQU60SezYhmrRM1WHuoziQE=
X-Received: by 2002:a0c:f181:: with SMTP id m1mr861957qvl.43.1604104943769;
 Fri, 30 Oct 2020 17:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201020014336.2076526-1-joel@joelfernandes.org> <20201020014336.2076526-20-joel@joelfernandes.org>
In-Reply-To: <20201020014336.2076526-20-joel@joelfernandes.org>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 30 Oct 2020 17:42:12 -0700
Message-ID: <CABk29NsgPcpOpDzixKtdkK85H1xq2XHXHUm6B96nS-4zKzpRwg@mail.gmail.com>
Subject: Re: [PATCH v8 -tip 19/26] sched: Add a second-level tag for nested
 CGroup usecase
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Benjamin Segall <bsegall@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 6:45 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> +static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
> +{
> +       unsigned long color = 0;
> +
> +       if (!tg)
> +               return 0;
> +
> +       for (; tg; tg = tg->parent) {
> +               if (tg->core_tag_color) {
> +                       WARN_ON_ONCE(color);
> +                       color = tg->core_tag_color;
> +               }
> +
> +               if (tg->core_tagged) {
> +                       unsigned long cookie = ((unsigned long)tg << 8) | color;
> +                       cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
> +                       return cookie;
> +               }
> +       }
> +
> +       return 0;
> +}

I'm a bit wary of how core_task_cookie and core_group_cookie are
truncated to the lower half of their bits and combined into the
overall core_cookie.  Now that core_group_cookie is further losing 8
bits to color, that leaves (in the case of 32 bit unsigned long) only
8 bits to uniquely identify the group contribution to the cookie.

Also, I agree that 256 colors is likely adequate, but it would be nice
to avoid this restriction.

I'd like to propose the following alternative, which involves creating
a new struct to represent the core cookie:

struct core_cookie {
  unsigned long task_cookie;
  unsigned long group_cookie;
  unsigned long color;
  /* can be further extended with arbitrary fields */

  struct rb_node node;
  refcount_t;
};

struct rb_root core_cookies; /* (sorted), all active core_cookies */
seqlock_t core_cookies_lock; /* protects against removal/addition to
core_cookies */

struct task_struct {
  ...
  unsigned long core_cookie; /* (struct core_cookie *) */
}

A given task stores the address of a core_cookie struct in its
core_cookie field.  When we reconfigure a task's
color/task_cookie/group_cookie, we can first look for an existing
core_cookie that matches those settings, or create a new one.
