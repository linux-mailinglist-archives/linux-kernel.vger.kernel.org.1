Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DD2EEBF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbhAHDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbhAHDmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:42:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E69C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 19:41:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iq13so2925393pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 19:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sOF+KlKWNno1ZXirYm3D0U//2jl0xNilHyDGa2gFnkU=;
        b=Q065Tr+1B8i5HA/t6pUckZwEslOvXkCJr+BYsA8xJICXthOyGqGYy/wBHXZMX9iwTg
         qZvJO1sNACdCUixhLn4zD1+nrSIARoYjqugcCtACbuXCtBKKaUoi1PlnBsIhfYSnayiv
         4WToh+UsEhQTQGDtXmawCdz41zegmecIcEyWnik6tyfqtab1txX+FY8x4HRfcgnBcX20
         P+1k6RI2sdRh5i79zUKvwc1et5rXA0tNqESSkaq/kFBchx0PQKnXr+Ta35wYBoNDo6m3
         Cyogb2+Lknx+Yb90jqux2IfX1aKXMdmk4+G78ZdKYsrOFiVs2UNsvqAxCwAH5jwG0o/o
         EmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sOF+KlKWNno1ZXirYm3D0U//2jl0xNilHyDGa2gFnkU=;
        b=C02qk1/GEvX2KjbYPGgysuk+tKXm1f56ALvx7hjCM6rmFxNiNaHwJyjg4I2nn+1ggh
         x05IJc1I3oYKNYJfeD8YWRZB6sO8H4Za0GtBYiQfiSYgcV4j0ikbggytAiT95ZmcW/wJ
         FKD2GWJdHLXGzdgoa30OlOST3aweiilrG1SLUNc3Eu1ElUvRemp12oyFu6o25HetUaW4
         xr8MzCdEMlSXZ3TJt+CnggISbvqDUZvYG5WBzskKZrgdmsIRDe9upM0aP8Xi41W+j4ee
         HDKAW+kkoXceUz1SZsmiWw5+jX6NpcB0/9w5FsWfs+LqMzxBV8WOCWW8htF4ErgxPT6G
         qDbA==
X-Gm-Message-State: AOAM5330Z5hsgdRHwwiLMT8U+RlAb1MzLm/st/Pf0yqD2aC32Dzi1OHM
        BvJxgwGKHjk31Lt0Lvg56z8=
X-Google-Smtp-Source: ABdhPJwmUMduENgWXflmVDE6bLR8ixefy1g9kRUMCk+CvbyKXmzFm9jNFIRzt1rsI6DrwUm03KINHQ==
X-Received: by 2002:a17:90b:68b:: with SMTP id m11mr1633006pjz.208.1610077281012;
        Thu, 07 Jan 2021 19:41:21 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id s7sm3386513pgi.69.2021.01.07.19.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:41:19 -0800 (PST)
Date:   Fri, 8 Jan 2021 12:41:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
Message-ID: <X/fUXWWjZJKE46OV@jagdpanzerIV.localdomain>
References: <20210107164400.17904-1-pmladek@suse.com>
 <20210107164400.17904-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107164400.17904-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/07 17:44), Petr Mladek wrote:
> 
> This reverts commit 757055ae8dedf5333af17b3b5b4b70ba9bc9da4e.
> 
> The commit caused that ttynull was used as the default console
> on many systems. It happened when there was no console configured
> on the command line and ttynull_init() was the first initcall
> calling register_console().
> 
> The commit fixed a historical problem that have been there for ages.
> The primary motivation was the commit 3cffa06aeef7ece30f6
> ("printk/console: Allow to disable console output by using console=""
> or console=null"). It provided a clean solution
> for a workaround that was widely used and worked only by chance.
> 
> This revert causes that the console="" or console=null command line
> options will again work only by chance. These options will cause that
> a particular console will be preferred and the default (tty) ones
> will not get enabled. There will be no console registered at
> all. As a result there won't be stdin, stdout, and stderr for
> the init process. But it worked exactly this way even before.
> 
> The proper solution has to fulfill many conditions:
> 
>   + Register ttynull only when explicitly required or as
>     the ultimate fallback.
> 
>   + ttynull must get associated with /dev/console but it must
>     not become preferred console when used as a fallback.
>     Especially, it must still be possible to replace it
>     by a better console later.
> 
> Such a change requires clean up of the register_console() code.
> Otherwise, it would be even harder to follow. Especially, the use
> of has_preferred_console and CON_CONSDEV flag is tricky. The clean
> up is risky. The ordering of consoles is not well defined. And
> any changes tend to break existing user settings.
> 
> Do the revert at the least risky solution for now.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
