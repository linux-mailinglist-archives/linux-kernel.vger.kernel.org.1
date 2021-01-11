Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E062F1872
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbhAKOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbhAKOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:40:23 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BABC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:39:42 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u21so3818268lja.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+vkcHsiAqswgM9MUlspMKBKOzyC4WpGMlRs5sRsV94=;
        b=gtfDv0DTmxcgQyGM5dFRLwMQ1L1sDYTjaAYhwgMBTRaKAVMZcno6eWHnO9cNrkSaae
         wi7zBfHEqacEAvTQKockZxaIu1bdRZ32ao8z3j1TYi05DGOKGBlTCpdJ6iYwpdEbwSn+
         eV9uEXYLylQo19h0lNSDaYxupYbAD8HBK3mpactKaU4uFRlT4Srj3C0j0HJsKm7N/EMj
         NNTj9duGYmApdDNRq954LDNFEMoM6ZqU+r2spypaL2ku2ymBA2WQga/TRLL49oSnlNp/
         Q99UQ/jlU/Mh8yOAJUBa2Kcu/r2YR6Je4/0Jlc6D5PODqKQstK6ID37UowpWKBoE/pKh
         T/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+vkcHsiAqswgM9MUlspMKBKOzyC4WpGMlRs5sRsV94=;
        b=OOY1eMTG9vmRhDN07y3DDoj7Qlo/4qR5r1mnJ/YJzUFEwuNMUC4Ote/IRuxGKqVibC
         akkPdA3Z7QiaRdBF/yMcH0ywFaiT4pk/phViKQcNRTYW+cOVzVta3iq9AnUsnpnZ0nbk
         byJuHF2PwsXZ1591mBdc+z7xOsMSDN5SbqqZYMK0mLrmCNLmzYu7+jyVwEVDruiKk9Zv
         Jgz/dfMf1bWTh6M4wj/9W2uvLDFS7uRDovBvsXksYOsxumCo4H5FUtCkzHzVqU4UZl/C
         aqSnUIt4dpKZPRPk1tw9bpdsuqGxvrznLsX4UsBl3De+aSrj0W1/ji0K8baBjhcYUlqv
         yatg==
X-Gm-Message-State: AOAM532hlZusOy7baTifVYNIo9ccF/gvLN/p69yGWduE9zwloD3aPNGb
        WYYIXu0ov9tB95qRbsdGe6qTP3DSS1fMSnQq9+uCHA==
X-Google-Smtp-Source: ABdhPJwudvHcNGRWcUJycLu57rDSTV0lI86xj/Mc4NZOWgfOwiTAovNbt55DmReaufGCsbLUokwbJgaaHQReBSZ4UbU=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr7013834ljn.176.1610375981282;
 Mon, 11 Jan 2021 06:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com> <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net> <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net> <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
 <X/i2aIKmeyi5SZ7g@hirez.programming.kicks-ass.net>
In-Reply-To: <X/i2aIKmeyi5SZ7g@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Jan 2021 15:39:29 +0100
Message-ID: <CAKfTPtDk3+96ZuytRAPA3ZBqW-whzn3cbGmwgS7ZfyoPaTTKnA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 20:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 08, 2021 at 04:10:51PM +0100, Vincent Guittot wrote:
> > Also, there is another problem (that I'm investigating)  which is that
> > this_rq()->avg_idle is stalled when your cpu is busy. Which means that
> > this avg_idle can just be a very old and meaningless value. I think
> > that we should decay it periodically to reflect there is less and less
>
> https://lkml.kernel.org/r/20180530143105.977759909@infradead.org
>
> :-)

:-)

I was more thinking of something like decaying avg_idle during
tick_fair but at leat we all agree that we can't stay with a stalled
avg_idle value
