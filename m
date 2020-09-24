Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2215627664E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 04:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIXCSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIXCR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 22:17:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E5C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 19:17:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x22so892858pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 19:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gKCeOBoU5Gnn58Cm54AB14ZxrSPvXUCdl5LfOJCj1Fw=;
        b=M4XeG+2TvxV35gsxacBXx/bgLRkKwqJ5p4BbhHpt00XNl6q/XPdYOI8FUvNMyMWmwb
         kM1Z6etjD2Hygn3+fudlwd1iFl0RiNM0HVh8v/p/HtiEOIrGpz8VyoZ9zkin+CSorNsr
         7AIsfxjgzY+uOK0FGcRfd4TgQdLfvPoWeitcSE2HTA/067Aaa853H3645KmeU06LXLzg
         xGrrA8Jbv3g3wudpP10zUKSoZQHHVQTXOeb99ZahQMlX821YBfEg4edOHdUqyThb04/Q
         caXtWaEjxRDvVO7lsLiah0pw6elfadG6E7HxF8T6V1twqbnWWAsoUq/AYK3rS4RLtodO
         ME8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gKCeOBoU5Gnn58Cm54AB14ZxrSPvXUCdl5LfOJCj1Fw=;
        b=f2+HmYnZeSGxs1GKXldwVvEwj8IQk3lIOcWAFfnd6Mq0rv+Gs+03hXgc7xjOnumkYc
         5Ume36HoDJRk6LvzFvhqaSkImcOWP16pWAbmtL79kJ/a3Yts41DuuZigQP8YnGRuOlys
         zIg3o2lo2MUGfFoA7p9hICDBO0elrh91Smw+KJb47idrZrLLAuCSrtyIgoFcR2Se4feU
         L8ha445iKgkm4WAX7cOPcoWtEdIdB1tOvL0dBc6mtd7I1iP9GmQcrG4jnHAfdyHYVGEp
         fmVbuwHHTetQorJlNEVoMH3xNBWV41SnRcx4TzCc7fsxOL/6nZm2Brj8VSNL7FApxMrL
         y+9Q==
X-Gm-Message-State: AOAM5323+lEybL6dJ2x/+r82hGOWpcsEdHP3zWOIR5URSzGiE1DupTgO
        9ZRC/5hzv9cyc4L+zufw9Qo=
X-Google-Smtp-Source: ABdhPJzEe2RJKmtJ3Ksj/SvxkYkpUgmPku/FVwzi5i2pKPpvjoc474JDg9ulTuYQS6+EPa9A00bnWQ==
X-Received: by 2002:a63:1a50:: with SMTP id a16mr2049744pgm.331.1600913879232;
        Wed, 23 Sep 2020 19:17:59 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e27sm874569pfj.62.2020.09.23.19.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 19:17:58 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:17:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] printk: Add more information about the printk caller
Message-ID: <20200924021756.GD577@jagdpanzerIV.localdomain>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923135617.27149-3-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/23 15:56), Petr Mladek wrote:
[..]
>  	/*
>  	 * To reduce unnecessarily reopening, first check if the descriptor
> -	 * state and caller ID are correct.
> +	 * state and caller infromation are correct.
>  	 */
> -	d_state = desc_read(desc_ring, id, &desc, NULL, &cid);
> -	if (d_state != desc_committed || cid != caller_id)
> +	d_state = desc_read(desc_ring, id, &desc, NULL, &cal);
> +	if (d_state != desc_committed ||
> +	    cal.pid != caller->pid ||
> +	    cal.cpu_ctx != caller->cpu_ctx) {

You probably might want to factor out ctx check into a static
inline helper. Since you use this check in several places, and
we may check more context fields in the future.

[..]
> +/* Information about the process and context that adds the message */
> +struct printk_caller {
> +	pid_t pid;	/* thread id */
> +	u32 cpu_ctx;	/* processor id and interrupt context */
> +};

A question. Suppose we have a task which does

	CPU0

	pr_err(...);

	preempt_disable();
	pr_err(...);
	preempt_enable();

	pr_err(...);

	rcu_read_lock();
	pr_info(...);
	rcu_read_unlock();

Should we distinguish those as 3 different contexts?

- normal printk
- printk under disabled preemption (affects scheduling)
- printk under RCU read side lock (affects RCU grace periods)

	-ss
