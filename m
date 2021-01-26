Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0A304D99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbhAZXME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbhAZEsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:48:55 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:46:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so9813279pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hShbIms5NYs6IydotF01qyWzp7TZl/6azhfbVRi5o6E=;
        b=MifeBThAMKqxhSVAghpvfs585hTpBPF+rXgdrGmyymQoXDyyKc09lSU1aAXf1e3QPK
         hN35pWvH23+2XiXI+RSMRXMOgWU1DST62Xj6vZavH5y49VwlO7cBq38+H2656v+yt2bl
         jtshB6qyKBH2RdBNAhBpoggs/tDXwFiIJdmobdVWXyi+GiOJZJIZSvvV2TfbY9r0NuEh
         W52o09PkdXfcesIyaOYT8y+WSZa4KO4b3PWWlVomvubPsG3MjZXURj1f35pwWxrG0l+p
         7i1CT9tgTr91nWkvLrJYWhjN8CuGrIlCanjsVh9SfU52DYia4Rmz8+t183Oqq1JNs/xO
         wW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hShbIms5NYs6IydotF01qyWzp7TZl/6azhfbVRi5o6E=;
        b=kDQqWMD3rCM2ukKoarFcnZP4IWkRsOS06V4hpmWsO55KQN35Pzq+hooDuZgYnGNCP2
         uSvI0IYGrgl2F2irwcqpLyT+Dv10WtZsr8swtjxP4190kV9l7uNk6kGFEefQ/o52zeWV
         IYfQP7eE9tZqaCVnO43p4jQI54SMHFEOWtIRCwOfMjm7Jktr1Xg5LoP2xc02g9wfiDyO
         0EZMPAOVdzSqFgxjuZrpU5rLSQup9S2ExmHF+Bwr8ptouO8eNcxwhwJ5qiLThjvDvsg9
         XlO/PaS/bd3FnDAQ6lwHrqoLrKwQvKdeIWOpNjOjmzZtBcVdpWvGA35RSPzFB/PgOlKz
         7MZg==
X-Gm-Message-State: AOAM530VSWVLlR2QimKTSTEywuhbP4+9GEVRHrwboeHbcZt27l2b8PJL
        DJvIIkXETuFEsNGTTHp3zdo=
X-Google-Smtp-Source: ABdhPJxuICCHgQTP1qca61356Po6GiWLQDSs54EnDltxdoeT9mJyCPOUsPCvWm+hstziesbp+ODfgQ==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr3995536pgk.186.1611636382599;
        Mon, 25 Jan 2021 20:46:22 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e12sm901336pjj.23.2021.01.25.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:46:21 -0800 (PST)
Date:   Tue, 26 Jan 2021 13:46:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix BUG: Invalid wait context in hrtimer_interrupt()
Message-ID: <YA+em8XkTidYetGE@jagdpanzerIV.localdomain>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123233741.3614408-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/23 23:37), Qais Yousef wrote:
> 
> I hit a pr_warn() inside hrtimer_interrupt() which lead to a BUG: Invalid wait
> context splat.
> 
> The problem wasn't reproducible but I think the cause is obvious, printk can't
> be called from interrupt context.
> 
> AFAICU printk_deferred() is safe from NMI, so I assumed it is safe to be called
> from hrtimer_interrupt() too. Adding a pr_warn_once() inside
> hrtimer_interrupt() in a location where it is always hit produces the BUG
> splat. Replacing it with pr_warn_deferred_once() generates the printk warning
> without any splat.

Could you please post the lockdep splat?
Why is it invalid? Is this... -rt kernel, perhaps?

	-ss
