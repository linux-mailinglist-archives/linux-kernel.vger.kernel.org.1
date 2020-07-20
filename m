Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB0225A21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGTIe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 04:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:34:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B17C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:34:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so9872268pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qwe5eoeikgPsdVVgJgZFvCBwEfnVFQKOymXhWv/sjwU=;
        b=AmQST3JV5BHy9gWF+aGGv4HcKoNtzOanTVTgCdxvRsclM7ZaSihwD656nnDS6//PXP
         tpsTT1zc9zBSPFQMYsWN1ZMOcMPVdLExNzEq+rIFKb8EsN8pa2R79Xr82ACFxH4ZhI/E
         75aI897o4xU7hmnfnCIfddj+uJ7oRTkrsOmakhb7l0KiF7SXkwfgySTRNFmdkWdjcY9K
         nVx38SLgzfBDk/n3+Prj9E2qB5AlN35jxKjhLPHHTImYPwKFGJXINeXTn3zuwJS2bnwW
         eJoNmTxoa4PcD71X7rld/Tca6WuQrUbRaRW/hPpDcpgZyHQUYbxJKwIhM/qBzciw85V6
         SODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qwe5eoeikgPsdVVgJgZFvCBwEfnVFQKOymXhWv/sjwU=;
        b=qyoeqVDk/98+vyEld5Dls6CZaO7W8tAlw/8eCQalchGhxMiMDuECddnghjVhLypvGM
         /dtwJ/mf9xV/wuhOBPR1D28XLSq5xYGOtgT3be8XIQ0NY3m55CaRj/LBSs6MObkcw1c8
         YEOvXw2o7O76GpNZMWk5AYrrtNQT6xSisLKvYCtyFSjNu44TS0czRmew+OkW247qJnVF
         t9fvIuNgBwicGtKfZ5k7U+f4txwMoSbHdMyibhozpNTjjdXCvqF+t/9CNm9/9hBZn3Ny
         gi6ghIWY4fPli9Dci5GW1aBrEdMqvQVFWrqPDZs64Bhf4cFon2OwiCnkDtpFPds98sNV
         GMjA==
X-Gm-Message-State: AOAM533MzLdI2yRgUyzmU+hVhVf7qI7PIAo1Q8oJOL3sEk71d2c4Nu5J
        XxrYdQsTwlObqOxmuOAB7DQ=
X-Google-Smtp-Source: ABdhPJyzxwvAQZZhov+oQjRDbhsrpwR+sNeovC0j7heVwX12gi0gScUzTNiUt3M1omiBDdqQmvR4Bg==
X-Received: by 2002:a17:902:b7c8:: with SMTP id v8mr17252214plz.201.1595234063979;
        Mon, 20 Jul 2020 01:34:23 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id p5sm14072134pgi.83.2020.07.20.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:34:23 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:34:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200720083420.GB463@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain>
 <20200720064303.GA2144711@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720064303.GA2144711@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/20 08:43), Marco Elver wrote:
[..]
> please see a full list of newline-print users below.
[..]
> $> git grep -En '\<(printk|pr_err|pr_warn|pr_info)\>\("\\n"\)'
> arch/alpha/kernel/core_wildfire.c:650:	printk("\n");
> arch/alpha/kernel/core_wildfire.c:658:	printk("\n");
> arch/alpha/kernel/traps.c:120:	printk("\n");
[..]

In many cases printk("\n") is not for "print a blank line", but
rather for "flush pr_cont buffer".

	-ss
