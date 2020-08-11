Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542BE241D96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgHKPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgHKPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:51:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15080C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:51:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h8so6925378lfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIwKc0Pf5DTDi2LxUBmmYZLh8vGovo5mHhsVAPJpcZA=;
        b=YxevrWSp+E+voSCnY74qs4J0R19cGPtLQOWtpl0z3c/DeSKSVtKrcCYK4LtRCDEhzQ
         5GZSNB+smjJYraoq6/L+LxnG4nkTbP+YB6UJNHcN403pCwshZu+pA1E/B04ljW5vFXuy
         13rBaEkWTjDHlLSwzQ1CE3YuaBdfpidKv/Mu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIwKc0Pf5DTDi2LxUBmmYZLh8vGovo5mHhsVAPJpcZA=;
        b=KTjjpT1+xIUOcCbu1u/3U8E6w4IedyEMZP3Z7lKDj1OIXDkHDD5SSAWA8CoHJAWwUH
         R1j3w3gvqZcyITdHdMZ0BlDuH86yxNAGvd+HztowiLauGF4pNBUvfxhIvwzaovne7X7J
         MZ2gzNsURcVmJy0OvfoP2AhT8CU0+iqFk5QaFYbjOIteM1KoVg6JjScmviphErd1nXoB
         oDcERHRGufjMGghN0fOVb+CMhW/Qt5VNRLsyNcc5RiVagdIpWxIc7GfYe34d3WShi9DL
         0uvi9emz5KBBhEcDq1dVraWY88r+JiHRhYimwbVzC7LQKRa4eFj46ResvX/v0TiHAg+S
         +/ew==
X-Gm-Message-State: AOAM531gAiAlF8RgPo+RXkaJ+hXJTdYDYJSv4aAD85AIQfhU09XokE0N
        0/ZKOB8fw2gr735iV1MrYw4VqVoG3d4=
X-Google-Smtp-Source: ABdhPJyqp+9DtrysdX9l7LMaBwwB6IrKP5Tkmp4EY6Uh1YlDq9T/NXKQBPzb2WxD40oPA0c+Q/5z9Q==
X-Received: by 2002:a19:f808:: with SMTP id a8mr3507566lff.62.1597161095163;
        Tue, 11 Aug 2020 08:51:35 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a7sm10125382ljk.2.2020.08.11.08.51.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:51:34 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t23so14095535ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:51:34 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3421035ljf.285.1597161093904;
 Tue, 11 Aug 2020 08:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200811083315.GB7488@shao2-debian>
In-Reply-To: <20200811083315.GB7488@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 08:51:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg36CfqcBr8ucE_xcqCaPWeL8LmkAuYMsY4yW74F9=ZOA@mail.gmail.com>
Message-ID: <CAHk-=wg36CfqcBr8ucE_xcqCaPWeL8LmkAuYMsY4yW74F9=ZOA@mail.gmail.com>
Subject: Re: [mm] 2a9127fcf2: hackbench.throughput -69.2% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 1:34 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a -69.2% regression of hackbench.throughput due to commit:
>
> commit: 2a9127fcf2296674d58024f83981f40b128fffea ("mm: rewrite wait_on_page_bit_common() logic")
>
> in testcase: hackbench
>
> In addition to that, the commit also has significant impact on the following tests:

You can say that again. It's all over the map. with some benchmarks
showing huge improvement and some showing a lot of downside.

Which is not surprising, I guess. Waking things up earlier can cause
more of a thundering herd effect, and it looks like some path ends up
just going right back to sleep again, with voluntary_context_switches
growing by a factor of 25x, and involuntary_context_switches growing
by 110x if I read that right.

And the reason really does seem to be due to having a _lot_ more
runnable active threads:nr_running.avg increases by 2x, and
runnable_avg.min is 4x what it used to be.

I think this is more of a "Hugh load" - it was likely already scaling
the load past the machine limits, and the more aggressive wakeups just
made it go even further past what resources there were available.

The odd thing is that in the profile, wakup_up_common does show up,
but it has nothing to do with the page lock. It's the
unix_stream_sendmsg() waking up readers.

I wonder if it used to be synchronized more on the page lock, and now
it's past that, and we end up having a lot of readers on the same unix
domain socket, and we get a thundering herd there when the writer
comes along. Or something.

              Linus
