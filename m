Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B972E3235
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgL0RjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgL0RjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:39:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:38:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so19290745lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuN4T+GUGL/ZU+phVVPp/K4I5WBfD11Fdwa/PYomUhw=;
        b=AH2S4rTN09NY9qd0yqbjJD10iogIKesemAi68uBKDgP9wvFzwoR+StkvPY2Nn6QD96
         B948PsjO1vxVxiAMVSCpvg8JXGQQ3in3UvleX4agXFsCkEycTYJI1+7MTCotcNK2Neqg
         0SDE5aaoTjaxqgE5eXms4MtdrM08MNNkEYHAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuN4T+GUGL/ZU+phVVPp/K4I5WBfD11Fdwa/PYomUhw=;
        b=VwRQOicD+jc34U04orCY+Y6wCNNbPZitzZwXkLYcDGk7lGeATkBFkw7niLL42NjJMr
         3hx8KsdMiyKjMr4GFhPIrbNu0ayHisduZ3qb3nGQGtIZskkaiQK0DPfK7prvJ8cExjr1
         3JGSII+ZnnUHSjNe/Ieodther9/Qlnxu3UcWIP8OMms+SdHGqOd9w7/zRvVy8b4p0Cv1
         cMM7iBSgZfph4OrZGv9aR3dG8GBSHmDNPBUwM2DIa+1IsPegScMQ3Gw9ck7jUJpx55tM
         zc/9FHFLBFtbxjWs4tfZa9c2ParANi5Njq57QUxnYaLYPOuT2ZKVkrdOVfksFOnpRiCi
         Z5SA==
X-Gm-Message-State: AOAM5300m7/OVJi0o4941+/1I19vDK6S/xxlmV40BOA2RO4hJT+fIatO
        3wqQzHuQgNSd5kU8WlAhGvaAapdoZtl/og==
X-Google-Smtp-Source: ABdhPJzf5XqcQFwk+Xea6MuJyzALAy3jgtsBwOoWbhOTWH5CxK8e2vXqXY5nCzr0VeP9ok4ZCzomNQ==
X-Received: by 2002:ac2:4d4a:: with SMTP id 10mr16720682lfp.556.1609090720677;
        Sun, 27 Dec 2020 09:38:40 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h126sm5064932lfd.44.2020.12.27.09.38.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:38:40 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y19so19222778lfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:38:39 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr19471517ljm.507.1609090719546;
 Sun, 27 Dec 2020 09:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20201227141638.GA11393@athena.kudzu.us>
In-Reply-To: <20201227141638.GA11393@athena.kudzu.us>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 09:38:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
Message-ID: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
To:     Jon Mason <jdmason@kudzu.us>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 6:16 AM Jon Mason <jdmason@kudzu.us> wrote:
>
> Wang Qing (1):
>       ntb: idt: fix error check in ntb_hw_idt.c

So this patch seems to be at least partially triggered by a smatch
warning that is a bit questionable.

This part:

     if (IS_ERR_OR_NULL(dbgfs_topdir)) {
         dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
-        return PTR_ERR(dbgfs_topdir);
+        return PTR_ERR_OR_ZERO(dbgfs_topdir);
     }

works, but is very non-optimal and unnecessary.

The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
return random garbage for those. But if you've tested for
IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.

And PTR_ERR_OR_ZERO() potentially generates an extraneous pointless
tests against zero (to check for the ERR case).

A compiler may be able to notice that the PTR_ERR_OR_ZERO() is
unnecessary and remove it (because of the IS_ERR_OR_NULL() checks),
but in general we should assume compilers are "not stupid" rather than
"really smart".

So while this patch isn't _wrong_, and I've already pulled it, the
fact that apparently some smatch test triggers these pointless and
potentially expensive patches is not a good idea.

I'm not sure what the smatch tests should be (NULL turns to 0, which
may be confusing), but I'm cc'ing Dan in case he has ideas.

              Linus
