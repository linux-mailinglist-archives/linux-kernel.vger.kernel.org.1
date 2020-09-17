Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6326E063
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgIQQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:13:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgIQPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:14:39 -0400
X-Greylist: delayed 2065 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:14:38 EDT
Date:   Thu, 17 Sep 2020 17:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600355622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IQwO6UJxW20LMLUtLPlneWWJbc+jEBAaDIiu8rtDKk=;
        b=Cl6gMhytvYn69nfF+qjSG74YQ9i9krDUl5sORisQKH0JkQpqwV3gUA9IXdxHYSiWD5U56p
        Vrwt3t3zTXoRZ3ykeKBNdgsnh0NRSYxM1Jia7kWLQuyxs1/M6Q/qsQodt3Jkk2WXJ+Qlga
        Qz0x8DctK34ZkKFVkhksrJnKrm3Dd78Xockntlv5Ou7Vt9p8J0CXq9+8CoK6+WqET7a8Yq
        8W0PyY4pjnAdsO1YsswtXz6c9VZaUHX6Rw2QBpznnT+u2HStvNznun7sAOD2uVOwfdIIH0
        YqWzv5hzxhdcrQdX8z+s+NEhCtAKlojIMp5HGKVKUPZUS7VSkE0MilgelEt1cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600355622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IQwO6UJxW20LMLUtLPlneWWJbc+jEBAaDIiu8rtDKk=;
        b=0G3x32gLy6+xQXP8AVD3wKIpaIU/8d3f29Kq4vCvcicApCf43/RGoClDkb31rx86yve02j
        5QjSUk6fAJf/OdCA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200917151341.2ilqamtnc6hperix@linutronix.de>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <20200917143850.25akkvr32ojtwohy@linutronix.de>
 <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 16:49:37 [+0200], peterz@infradead.org wrote:
> I'm aware of the duct-tape :-) But I was under the impression that we
> didn't want the duct-tape, and that there was lots of issues with the
> FPU code, or was that another issue?

Of course it would be better not to need the duct tape. 
Also symmetrical locking is what you want but clearly futex is one of
a kind.

I'm currently not aware of any issues in the FPU code in regard to this.
A few weeks ago, I was looking for this kind of usage and only futex
popped up.

Sebastian
