Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B02768C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIXGRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgIXGRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:17:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE4C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:17:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q12so1095951plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LSmTDa7H3lB3GnBItYeJYiiAXiThAxj/99DEm1q+Yk8=;
        b=gfZSSnDRcnEXg37IhcG+YAqpFzM1noEwaduBnw6edWSmQKujhmDnmgfoI/0QloOdd/
         ORVGyOmch0O52yOgYcUSdhSsICTe01x+1Ekxf8SWdG+aNmAkLo10qfX5cF1TrkTCtDTY
         ZjfbYEv+y6gTPU7aSJBC0z0p5AVzyFnb2hUJ2xuyhfBOwXsCtyeWp4g4FWhkU0aH5diQ
         DtADCZgHFZHXkfAh3TKyouuYf+njxRRrx/bI7x2f+bThAB+b0eNvqE+hbTLXacrz98NS
         RiTkehm3j6ciy3wvgsRsMtWr5r+SccJjwfn2UIr0hCEe9+PSOx70ogUjkcc3kcvBs4dQ
         Jy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LSmTDa7H3lB3GnBItYeJYiiAXiThAxj/99DEm1q+Yk8=;
        b=FURgWQjYSj+oNhDfv4HfabYoIPRHDZAbeqcAyjjq3WvWHqmZuWkCDEFcC3OSUx/IpB
         +KjRwHZtutIE05cDul/OloVlysVaUcdUxK+aBXv3Vw8wCcbug5838MrOZa2FtuFm6yOl
         aifiOz3cm5/3EdFza78lDVJ1mSPnDKgvpnFFsycUu1r9OPgZvrnybvowFCHUwk0YSEL2
         ksSVAwuVdfJOCx6tptKg+dbPdS/8yPYeXgiXKaUcQxIXLvrOW6NIVxS54crjYS767++N
         Axe6hwoezDZO+4CjsbrPGWNSIIRWsWPpGPiCDH5DRZIMWCIWaHG4NjxTPtzVfHV8U1Jz
         yjsQ==
X-Gm-Message-State: AOAM531lQ2swh5CB8xby648BmbOqGxB/jhS6Gt5vUfjECzwSvhoJPLYM
        tUZ1alcDHQL4pXcvVZgOmFRGIa6gpi4=
X-Google-Smtp-Source: ABdhPJzLbtV4LjRpxUnoI784gQlji2Ws8Ef2jSdg/N8V9vPQ29xK2kopCqfPoFMKkvsWMP8B7GTywg==
X-Received: by 2002:a17:902:6b05:b029:d2:8b5:14 with SMTP id o5-20020a1709026b05b02900d208b50014mr3148588plk.80.1600928269461;
        Wed, 23 Sep 2020 23:17:49 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e10sm1707161pgb.45.2020.09.23.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 23:17:48 -0700 (PDT)
Date:   Thu, 24 Sep 2020 15:17:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200924061746.GF577@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/22 17:44), John Ogness wrote:
> +/*
> + * The sprint buffers are used with interrupts disabled, so each CPU
> + * only requires 2 buffers: for non-NMI and NMI contexts. Recursive
> + * printk() calls are handled by the safe buffers.
> + */
> +#define SPRINT_CTX_DEPTH 2
> +
> +/* Static sprint buffers for early boot (only 1 CPU). */
> +static DECLARE_BITMAP(sprint_static_textbuf_map, SPRINT_CTX_DEPTH);
> +static char sprint_static_textbuf[SPRINT_CTX_DEPTH * LOG_LINE_MAX];
> +
> +/* Dynamically allocated sprint buffers. */
> +static unsigned int sprint_dynamic_textbuf_count;
> +static unsigned long *sprint_dynamic_textbuf_map;
> +static char *sprint_dynamic_textbuf;

Just a question:

Can dynamic_textbuf be a PER_CPU array of five textbuf[1024] buffers
(for normal printk, nmi, hard irq, soft irq and one extra buffer for
recursive printk calls)?

So then we'd

	vprintk(...)
	{
		preempt_disable();
		buf = this_cpu_ptr(... preempt_count_to_ctx());
		...
		preempt_enable();
	}

preempt_disable()/preempt_enable() is already in printk().

	-ss
