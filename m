Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D62FAE30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbhASAp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbhASApk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:45:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647C2C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 16:45:00 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t6so9550367plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 16:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAP6YVCRqPrNfCjZamoYP6iHXVfN5atOSvue0hsNHKQ=;
        b=HZFe9W/moOmSXp0oFiCPqW2Gyw43X9nEwXi56DYeAWYPeyoOsf6NZFx5ip9Tsfza7T
         /hCYBkuFPNGaGGwuGPJlrBSVN0qs65BZKzzvadCxW3pZAv80WNWyoyaj7Wmq8/M5498l
         Xt+RIMmuCiLlPUjGXopdFPme5419aMW+m442Are0PfOFryLBdh6t5WTnybOHhBbFRtqQ
         mMK8K4KTWc65qtS/km6cJBGj3ZFgvqxJpretfofLJT23DganvPIO3E2U/WLcxjWJNMDY
         TqhvJKU5T+ZAL0o1gcXcdaKF0VsPhrueqJ/rcA+hul2WDoIMQAPCXYiEiqGaqgnfBO2j
         P8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAP6YVCRqPrNfCjZamoYP6iHXVfN5atOSvue0hsNHKQ=;
        b=qg2Pj4aSOE3TwPZjL82B6b5lTASfGXbRqbVaXx/Q29AVHnV1BYF2IsYKX/eSSn2q9C
         Qealtbub9sllTksOBIp/P5U9wiaWr20f28QKslTlSdZZ+1XHYSEQpKUBvgP6m+/fKYLQ
         qP+uhp+N8aydc6FnfRZawphL2c6KurowWbAsnTa+CxY7Gbmz0KKFbIWQzjLO9nTIlJ+M
         rQZTYu5unr32dDfawHTXPYMUKaUXbl2SnfoDoLSGTsMjTb0c2H2YYaKPKfEXgELFFRmi
         rgZmQPIrxP2KUlWzuYN5cXrwzSlXowkP9jcHqFgPNmcWyRtPuCG6Rw3ChRvU1UOrJiN8
         F8xA==
X-Gm-Message-State: AOAM533mGrEEF0CIlptcPrwhESeMR4CZ1qEsfTB2KdwryuXYMrfvT1rp
        FE+amun4TgciywNyWaFggX5YGzva06EGgQ==
X-Google-Smtp-Source: ABdhPJzHxn8Ko5Spo7auOLhGY6qGBbyx0cRAYzILCXCwrZiBGP8zTOxCizBGNqIXrrIbwARnT7NjyA==
X-Received: by 2002:a17:90a:e006:: with SMTP id u6mr2024759pjy.201.1611017099801;
        Mon, 18 Jan 2021 16:44:59 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m27sm269712pgn.62.2021.01.18.16.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 16:44:58 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:44:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
 <YAGE1O/nG57hyRs4@alley>
 <YAGFebfPNLwjyhcl@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAGFebfPNLwjyhcl@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/15 13:07), Petr Mladek wrote:
> On Fri 2021-01-15 13:04:37, Petr Mladek wrote:
> > On Thu 2021-01-14 18:10:12, John Ogness wrote:
> > > Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> > > msg_print_text() would only write up to size-1 bytes into the
> > > provided buffer. Some callers expect this behavior and append
> > > a terminator to returned string. In particular:
> > > 
> > > arch/powerpc/xmon/xmon.c:dump_log_buf()
> > > arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()
> > > 
> > > msg_print_text() has been replaced by record_print_text(), which
> > > currently fills the full size of the buffer. This causes a
> > > buffer overflow for the above callers.
> > > 
> > > Change record_print_text() so that it will only use size-1 bytes
> > > for text data. Also, for paranoia sakes, add a terminator after
> > > the text data.
> > > 
> > > And finally, document this behavior so that it is clear that only
> > > size-1 bytes are used and a terminator is added.
> > > 
> > > Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> > > Signed-off-by: John Ogness <john.ogness@linutronix.de>

John, how did you spot these problems?

FWIW, Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

> I forgot one thing. We should add stable here:
> 
> Cc: stable@vger.kernel.org # 5.10+

Good point.

	-ss
