Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07749277D37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 02:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIYAyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 20:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgIYAyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 20:54:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509ADC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:54:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bw23so951716pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pci8wc6C3sL56nLHCcZggaiDkvGB6P5cNXj+K5byzNE=;
        b=ZkGUt2PZtlRrXjXYuZhhn2xi5M3Ro/NfLR0zFG7qndd/iC5ST5IwbkDvA7aHSTFehS
         FdslJhI8zB3VkjGiDRzvixS2KukLQhBVbUJUHyoS1SdsKAS041G5x4r4iOViiVjqsiPl
         h0FvW4JsHNPxv5Z+GfPiaXseX636qzYPkwJAVU1mTimHXSNWeZ3CgJWuSxx6qBP3dSyh
         GVWE7ZVPbEIys1JDKQaVPHQslMJKfExg+RY8JGqRpxF96QVfDU9JYKuCYHTejflwXqqt
         pHAk6C3B724hnqbueS98e5GUiwnO1SN5qmEdCFKGuK+NVhdDbbpoeKkn1hJ+VA31zJk/
         TxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pci8wc6C3sL56nLHCcZggaiDkvGB6P5cNXj+K5byzNE=;
        b=FrbNpjlvk5N7cbfvDSXgJPZQN05SAdBfy4P5rNSCEQdbqf/pJ5hAw9xWHRjo/L7yLJ
         iVSJZxlXItDBlg3uV53NoCXG5MGq6fhVHDLGm6L5mBQ0eBP2qztiiIj1PPQak6bnCHVF
         2pJssXdlsIU5NIAPa5FOiO8MrN7mii6kNxQ4oz1aseIEbYsznjBYmtR/h/qCnrVmnXEo
         uT5OrVgJK+zECZj440hMtbgEYWK8nIL917eoZmnapP0NdgSmP6ggTguQzocGmDYvlCve
         X/3JhLNF3Z2ZWPlo8BR4hu6tkYLPxt/69kQxYNuGnfGB06gvrzO3y7Zic6/4VX9UBE7m
         NlRw==
X-Gm-Message-State: AOAM532+Co/KfeV6+vE8LVsRSe1y6kB4Y/GdVxY/MlZElidlXivynT03
        yxkLfoh9BGIcqSuHHLYhMFU=
X-Google-Smtp-Source: ABdhPJyrfFVFuHh0Nje0Go9eXi46nHKKOCbGgn6ZtXsDxlrSMEwtiebjEb8OEvMlmyxA6z0nKYDESQ==
X-Received: by 2002:a17:90a:b64:: with SMTP id 91mr268059pjq.93.1600995243767;
        Thu, 24 Sep 2020 17:54:03 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i15sm605270pfk.145.2020.09.24.17.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 17:54:02 -0700 (PDT)
Date:   Fri, 25 Sep 2020 09:54:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
Message-ID: <20200925005400.GD541@jagdpanzerIV.localdomain>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924042414.GA6039@lx-t490>
 <20200924125259.GC29288@alley>
 <20200924133850.GF29288@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924133850.GF29288@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/24 15:38), Petr Mladek wrote:
[..]
>
> Grrrr, I wonder why I thought that in_irq() covered also the situation
> when IRQ was disabled. It was likely my wish because disabled
> interrupts are problem for printk() because the console might
> cause a softlockup.

preempt_disable() can also trigger softlockup.

> in_irq() actually behaves like in_serving_softirq().
>
> I am confused and puzzled now. I wonder what contexts are actually
> interesting for developers.  It goes back to the ideas from Sergey
> about preemption disabled, ...

Are we talking about context tracking for LOG_CONT or context on
the serial console and /dev/kmsg?

If the latter, then my 5 cents, is that something like preemptible(),
which checks

	(preempt_count() == 0 && !irqs_disabled())

does not look completely unreasonable.

We had a rather OK context tracking in printk() before, but for a
completely different purpose:

       console_may_schedule = !oops_in_progress &&
                       preemptible() &&
                       !rcu_preempt_depth();

We know that printk() can cause RCU stalls [0]. Tracking this part
of the context state is sort of meaningful.

Let's look at this from this POV - why do we add in_irq()/etc tracking
info? Perhaps because we want to connect the dots between printk() caller
state and watchdog reports. Do we cover all watchdogs? No, I don't think
so. RCU stalls, local_irq_disable(), preempt_disable() are not covered.

Do we have any technical reasons not to add those missing bits?

[0] https://lkml.org/lkml/2018/1/9/485

	-ss
