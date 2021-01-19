Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FE2FB766
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391004AbhASKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390593AbhASKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:30:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D29C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:29:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so12699517pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qxx4tooN9pY52eWelOpuS9rLDNjCrg58Wch5BtDwzh0=;
        b=bhFNGSdL6YGi5PDkvPJWBni6uzhgfPOjKwPeeKmFgvQJrkJ4YLPGW5qHCxjDgM9kv0
         mmuVOY6k+U3Mreja/LFMKm9PPLO/cwb5nRIQOJm4tTAFLQ7ijCPFShPwAwsAMf5WF+Mg
         s2LI6j1/nsKZ0fdL5jKg+/ZfjsJ9Ta8X8Wac4LRYUs+kANW0rYNl70Z3x9umEIZiutz6
         MNIL3zyfMmgcORP1EPlY24DELsycpcWkTvWkWHYeqnnb3mIUdtQZDBkLtlW3pQ+HW4zv
         G36cTDVs9P5cQQqzjfQQF/dcMM1rSt/j9rwjrVZ31VXi9ZlvzQe4mAdMErTkPdD6Y7sl
         U2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qxx4tooN9pY52eWelOpuS9rLDNjCrg58Wch5BtDwzh0=;
        b=tgLiASzMO5VNID3lz+IWeDXxwF0GVe8wFDmVxRcpYCNgMxLotHDthyyVOrgJIzT51O
         uPaz83hC2apeabH4Euh7FKNkRGpRNmlwQmUVuVy26W+hs7yconAbtWPF9oG9M0M4uu9G
         71IQH5BW+Y5jBhyukM5uPvefc6GegUqaRhSSrjdheA4L/SQLRBP5dpCINcN84oNN4fUX
         0d0RV0Vkvub6tRK1EphLmte6emxwE4+J4RuF5aAwkWxGmxB3BGgNeMYA4+/JsKn3Tmei
         P6294MHH/R2W1JEJ/rCbTBeZugVNxuVfDw3y3SyJMus5FUG0oWxNJATwJu59UzX5ULAx
         wHZQ==
X-Gm-Message-State: AOAM5321t6Q2FkMqeC17uSKYR1Y0E7R/TUNiablR7eL8+8Qb1hh0jh3U
        SZ1Sc9dpzrILUZ9MfMTjV24=
X-Google-Smtp-Source: ABdhPJwLDEJMQGyGP1X4/m3QAkmhtk+YgDQj5b6otI5P1jhVihSLLgLJ2tBZ3lqX0ECutkLe6293Pw==
X-Received: by 2002:a63:6686:: with SMTP id a128mr3764766pgc.96.1611052178925;
        Tue, 19 Jan 2021 02:29:38 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i6sm18734317pgc.58.2021.01.19.02.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 02:29:37 -0800 (PST)
Date:   Tue, 19 Jan 2021 19:29:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <YAa0j9CG/6yrGcs+@jagdpanzerIV.localdomain>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
 <YAGE1O/nG57hyRs4@alley>
 <YAGFebfPNLwjyhcl@alley>
 <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
 <87r1mh5mso.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1mh5mso.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/19 10:00), John Ogness wrote:
> On 2021-01-19, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > John, how did you spot these problems?
> 
> I am preparing my series to remove the logbuf_lock, which also refactors
> and consolidates code from syslog_print_all() and
> kmsg_dump_get_buffer(). While testing/verifying my series, I noticed the
> these oddities in the semantics and decided I should research where they
> came from and if they were actually necessary.

Any chance you can put those tests somewhere public so that we can
run them regularly? (say, before Petr sends out a pull request to
Linus.)

> I wouldn't say the oddities are necessary (in fact, they are quite
> annoying), but we have decided to keep them in out of fear of breaking
> out-of-tree modules and/or interesting userspace code.

Sure.

> One positive effect of the rework is that we are finding these oddities
> and documenting them.

Absolutely agree.

	-ss
