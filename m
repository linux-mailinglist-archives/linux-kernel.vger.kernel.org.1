Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71BD2B7E58
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgKRNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKRNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:33:43 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B80C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 05:33:42 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 1so2743009wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhSKm6xXD/S2USk/xN5rMNMtHJTfjEBBg1GQZ9wQdwM=;
        b=QImmPshdTjV1NJrDADCTneKdpxi5uJioL+eQ8QDHDpdv0hH30nPGo0kDGvD/zwALyd
         30vCXYj2RStj1hB7kh4JE3YXMMTbI9H07/h8WOebJDrrsFvsP8xjQy72AMrNINrzqeMj
         tqUnoDB4cNjCxmsiFdUHG5vQmuoXBMKuGmdgn8yY2JDXREAMiNPwX2ht7UHmw3IYEFV3
         ll80L/0XCHkm6Z+ZW+AF96hQ8IWr7pMQEEpcbXPSOEnYwaHvs7MWot6fdjzTzn56q/fh
         zO0ccXySdqQIY05+P9m+fDk4b43TH+3zK5ByjKaqZS1o2FJ/eQJt8+tiKMwScKV41+Tp
         gJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhSKm6xXD/S2USk/xN5rMNMtHJTfjEBBg1GQZ9wQdwM=;
        b=mxvZA200dvNgV5zMvWEqlVB4iRx1pToMXseFSX9J+zlkcSW3Eot5F/LseVyw0e/Yq8
         /qrQZH619RJGjTO01PJrUc5DFXEEYBSBwXshi/UQsRERh3FIR7SGVFem53O9+3kehtFo
         WX34zYrInGumfjQO4S7VXJfzAzUfQR5G4SlhIF5LWzU/ahqat0T7sql8PHIuKyY6Dt71
         Y+BjaaDgTZsxi51AuOVpbR1Kfo8G0a2Nf75StyU4k4n2GBLUvtKKLnAwhDge7AYfsV0U
         qJ9Krmeib/CEApqCSsi2XJJvaVyix5mrBNAOvGIDKoGLnuKULL8HPVaeJybyJgO7I40H
         462Q==
X-Gm-Message-State: AOAM5315Jo1GiJrxg76iNF1Xb42AZX0ylwD+HD8Ln+S7A1DGirPHTmCl
        NpKb+lemkqYF93pLTeO9MXCYfw==
X-Google-Smtp-Source: ABdhPJzlRM1pabR6XP3qseZnb4OnIlGC+nOLcf09PaLAN+UpslI69NrtJvWxE+TCMD1dmy53V6aLqw==
X-Received: by 2002:a1c:2d93:: with SMTP id t141mr80222wmt.104.1605706421330;
        Wed, 18 Nov 2020 05:33:41 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id b124sm3919845wmh.13.2020.11.18.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 05:33:39 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:33:33 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201118133333.GA1506553@elver.google.com>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117091545.GA31837@willie-the-truck>
 <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:29AM +0100, Peter Zijlstra wrote:
[...]
> > Now the million dollar question is why KCSAN hasn't run into this. Hrmph.
> 
> kernel/sched/Makefile:KCSAN_SANITIZE := n
> 
> might have something to do with that, I suppose.

For the record, I tried to reproduce this data race. I found a
read/write race on this bitfield, but not yet that write/write race
(perhaps I wasn't running the right workload).

	| read to 0xffff8d4e2ce39aac of 1 bytes by task 5269 on cpu 3:
	|  __sched_setscheduler+0x4a9/0x1070 kernel/sched/core.c:5297
	|  sched_setattr kernel/sched/core.c:5512 [inline]
	|  ...
	|
	| write to 0xffff8d4e2ce39aac of 1 bytes by task 5268 on cpu 1:
	|  __schedule+0x296/0xab0 kernel/sched/core.c:4462 		prev->sched_contributes_to_load =
	|  schedule+0xd1/0x130 kernel/sched/core.c:4601
	|  ...
	|
	| Full report: https://paste.debian.net/hidden/07a50732/

Getting to the above race also required some effort as 1) I kept hitting
other unrelated data races in the scheduler and had to silence those
first to be able to make progress, and 2) only enable KCSAN for
scheduler code to just ignore all other data races. Then I let syzkaller
run for a few minutes.

Also note our default KCSAN config is suboptimal. For serious debugging,
I'd recommend the same config that rcutorture uses with the --kcsan
flag, specifically:

	CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n,
	CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n

to get the full picture.

However, as a first step, it'd be nice to eventually remove the
KCSAN_SANITIZE := n from kernel/sched/Makefile when things are less
noisy (so that syzbot and default builds can start finding more serious
issues, too).

Thanks,
-- Marco
