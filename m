Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED582D4C07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgLIUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLIUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:38:13 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B6C0613CF;
        Wed,  9 Dec 2020 12:37:33 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id a1so4046923ljq.3;
        Wed, 09 Dec 2020 12:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ps0HzLtO3/TtXEsM+0xqsO+WH9Hy/vF5yoyOtvGwKBo=;
        b=C/NJfjCLOVMQTNTll13YnI2VM861tvCvtdfWqsFnEAgKqf/2C8R5ru2XqXL+zXqEtv
         MhVEo3ThrC06oREomIrSUlWFiDqrvm63wdTwlJUqIt1L3jkgByDdcTN+sUvpGt8zgiKS
         YraPECtNAb3ib3jli0j26aHQjOdKKQeaIioNES8mokBC+h+C7eIoVQ434Fgvgb86ifqf
         pP/tKqsxlrMNcFL48s9Jvgc5GKv2xPFVwCsW36ojsAKE/hbxwuH5R48n/LXFa316p/gi
         qNNUUmzFdwqXojDuim86DnxU2gdS7ERQu3TD1rSLeO/m5uTd4PDLaTo/F2LTiAm38s+Z
         IbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ps0HzLtO3/TtXEsM+0xqsO+WH9Hy/vF5yoyOtvGwKBo=;
        b=IaKBa14vfNYIkLV3BVybXbbjP/YiV4mtWt1iwqM/bg0fUREcqkf+/lGnJw/OS+OvRj
         +C26eppbFgLIhOv1HCMcvLoSRyPlw+Ji6xLS4df7j/D4qqdclxvmmpv3mF3AhMRnVp1S
         NQVnPclTkK27N1nHJYSoCdOFqszpbuQOQQUMzTtHd4QlKgg/Gr5CeLc9COnNTZntZhBR
         sTXB2BQ7OdCGEpAuEzkHPHxDx5sSlcdwgjWbB/Ia4GH3guwZylRXFdKntilQdvpMUiwn
         1O36qSTy7KjYJikaj3jBXcv9nT21fVeKzZYeecDHAvj+y3wA2DPKDz49wrRe0TzL+9zf
         ZB5A==
X-Gm-Message-State: AOAM532fDd1I5yVKBfy3qIceJdq9aCezAqLn9YUbMR3d6TjqlP+K6tmn
        L80dXw4AoembXFpHh6MmvhA=
X-Google-Smtp-Source: ABdhPJw3x0eNA6Rcna39d8jOJX4JMaSXTUwe6m1UNhsiWRa2C0VxoXuTcznqcZzTqXDDlC2ZiJdQTA==
X-Received: by 2002:a2e:81cc:: with SMTP id s12mr1767394ljg.39.1607546251467;
        Wed, 09 Dec 2020 12:37:31 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m21sm362816ljb.108.2020.12.09.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:37:30 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 9 Dec 2020 21:37:28 +0100
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of
 core_initcall()
Message-ID: <20201209203728.GA5972@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209202732.5896-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Initialize the RCU-tasks earlier, before *_initcall() callbacks are
> invoked. Do it after the workqueue subsytem is up and running. That
> gives us a possibility to make use of synchronize_rcu_tasks*() wait
> API in early_initcall() callbacks.
> 
> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h |  6 ++++++
>  init/main.c              |  1 +
>  kernel/rcu/tasks.h       | 26 ++++++++++++++++++++++----
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
I still don't have a powerPC hw so far, even though i have sent a request
to the osuosl.org. It would be appreciated if Michael or Daniel could run
and verify it.

Thank you in advance!

--
Vlad Rezki
