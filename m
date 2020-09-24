Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB92765EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIXBj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:39:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63297C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:40:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so846347pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jqke61+2arfJt+5tiS9HI9FYjbLGcSUxG2Gu6pVfuFU=;
        b=doR0EW+NSvfoqRl06aQjpoWQvY+dRXwyHb0deg3yYZfBZH1KaMnypppckt6bBQLhEt
         aIpUb559wN/Koco+g/ucYnf9rv8WY1znm4jvFIBN13mmbbFw9A4fRmM9m8LzXNEH7wIT
         iiB/gnoeAfKKOE0Ysj/jvhXFqdUdgxuhV+LAng8k1jruzWj+JeFWS+Yi9+qXAl1Rr+wa
         3O4j/Qp28g8xzaQXPqvpSyH8XFFadNyWDjAMXex/HMqMFU1mYZA9OGxhEcRQ1EI7hIwm
         ApE1KtSRaVdeMgcTpM8R7NHzZ0GQDcgNUgItQFChIydcO2Y5Slj4T+hc/PG6gMkAaDMQ
         z8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jqke61+2arfJt+5tiS9HI9FYjbLGcSUxG2Gu6pVfuFU=;
        b=NnMLrJNnEJUEvTWsCx5bTOwrVFouVMuNRcLXpm2JEUu7S0zsLOcc5FCaaGqkr9o5tI
         NGPU2PVp1LhtVcvSiWVIER7i/nICG9bXBrNqNnVhWuXlh8Q/NGenYYt1/qkzbxHwSzcM
         tC9XZwFD2inMBkC9oNbpKnMpZ2G0gBq8v1owJhH9zUM+EbP6iFVfkNqp6WP6jCai1+x9
         bi/XEd4hVcWXXZQPq7AYw4JJG5llkXpJ6De04cFNUEiut6b7wlIFrih4vL+axM18KDQV
         nMX5Q+36dnpn9YCf/lrr38i3jGnBmXRxCex9nEV1oGUCncFK70LMUh7Y35GAfEFvQf35
         JznQ==
X-Gm-Message-State: AOAM530b69vK82QVB7wVkBacQ4NnKABp2GERxmKYOJr/d+DT5uf8CfTl
        uWKP2nBQHpiww/sz1A5REfu9OCMBwrM=
X-Google-Smtp-Source: ABdhPJxcPCihqFL9WGy50FXhzM7hDiFApyQopWasbqI40fjjpRO1F4pbfi1ylH/3ZjxDo0Kgh8bOeA==
X-Received: by 2002:a62:2581:0:b029:13f:ba38:b113 with SMTP id l123-20020a6225810000b029013fba38b113mr2331202pfl.15.1600911612954;
        Wed, 23 Sep 2020 18:40:12 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id l78sm856637pfd.26.2020.09.23.18.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 18:40:11 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:40:10 +0900
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
Message-ID: <20200924014010.GB577@jagdpanzerIV.localdomain>
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
> The information about the printk caller has been added by the commit
> 15ff2069cb7f967da ("printk: Add caller information to printk() output.").
> The main motivation was to reconstruct original messages when they
> longer output from different CPUs got mixed.
> 
> But there are more usecases. The number of CPUs and tasks running on
> a single system is growing. It brings bigger challenges when debugging
> problems. The context in which kernel reports its state is sometimes
> pretty useful.
> 
> In particular, people suggest to remember the task id, cpu id, more details
> about the interrupt context, and even the task name [0][1].
> 
> Prepare for extending the caller information by replacing caller_id
> with struct printk_caller. And always store task id, cpu id, and
> exact interrupt context.

Wild idea:

Currently, we have two sides to the problem, I think. There are tasks
that store messages, but then there are tasks that print those messages
on the consoles. And those tasks and contexts are not always the same.
What I found helpful in the past was not only the caller_id, but the
emitter_id (especially preemption count and irqs state of the context
that prints messages on the slow consoles).

	-ss
