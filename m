Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C66269A43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIOAOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgIOAOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:14:35 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEECC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:14:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e2so916274vsr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJnbONMeYZfyVdyxeGsIkJTHYkKRPSNz8vRxzIqGNEU=;
        b=d6gCudIK5g9Xugrn0/5pf/xRr0qPusWV9CWQYguGjj3LhcFyO8LTKBFmPsg7RfcHD3
         R2gUlTkMLn1B1RF/E7q/eSwLpevMLjOdwQQHQt6uq3KC9yEZJ1uxlK2N031hdXOkkYkf
         o9LHRKj4aCWRZS40y/4pMy6E/Bg3CS5QnHv2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJnbONMeYZfyVdyxeGsIkJTHYkKRPSNz8vRxzIqGNEU=;
        b=ZROToewwbPwbapfQ99JAUq3HMWqp+/j7SMk68P9wzmBIK1tu2I4xSmLoUyzsTfJb5h
         QzElU/Rq34QTRdscLMD1vTAwJKz6JnvjypP/NSM8B4jPh2KSMnaYFvvravPklROi3Ljv
         PRU7RoNvMW3j+weFLF1y/lpopWThd0KVL0Y743A0Cp09LFM16EfITihlNr8GxKCnzBDt
         G7fKZYn9gBgzTz5x/u3OoWeLDBbhG10oCRdWWwFJJ0qNqPqLlfhs18vLdXdXemOs5ZjN
         9ABqw/NvP4jS2C41ia17DZfu9Q+Wiccg/FC7R6MmKm+dhDFhmZ51NE3XlE4ldzyGuuZW
         A4mw==
X-Gm-Message-State: AOAM531coJ4gBxcjvghhjBHff7K4MDG3vcv1bCIxw7ICOWflPlquLfmS
        g9ZQH4nPR+pXVOwAnVuBrWv1VRxzUOUa/g==
X-Google-Smtp-Source: ABdhPJzQ+ftnMt/kzu2IkM4KO65bnH0YlTyfTF+81bCJcnBpghMQzQcHcMh7Ozkk40AkRlEdEXn6nA==
X-Received: by 2002:a67:6952:: with SMTP id e79mr9023410vsc.11.1600128874759;
        Mon, 14 Sep 2020 17:14:34 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id d5sm851283vkf.39.2020.09.14.17.14.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 17:14:34 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id u48so465912uau.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:14:33 -0700 (PDT)
X-Received: by 2002:ab0:5905:: with SMTP id n5mr8290763uad.90.1600128873477;
 Mon, 14 Sep 2020 17:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200914130143.1322802-1-daniel.thompson@linaro.org> <20200914130143.1322802-3-daniel.thompson@linaro.org>
In-Reply-To: <20200914130143.1322802-3-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Sep 2020 17:14:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTgNxVLwytSY1wmCj7Dex3cWGVMA+Rkpp9gb1UN5CU_A@mail.gmail.com>
Message-ID: <CAD=FV=XTgNxVLwytSY1wmCj7Dex3cWGVMA+Rkpp9gb1UN5CU_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kgdb: Add NOKPROBE labels on the trap handler functions
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 14, 2020 at 6:02 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kgdb honours the kprobe blocklist but doesn't place its own
> trap handling code on the list. Add labels to discourage attempting to
> use kgdb to debug itself.
>
> Not every functions that executes from the trap handler needs to be
> marked up: relatively early in the trap handler execution (just after
> we bring the other CPUs to a halt) all breakpoints are replaced with
> the original opcodes. This patch marks up code in the debug_core that
> executes between trap entry and the breakpoints being deactivated
> and, also, code that executes between breakpoint activation and trap
> exit.

Other functions that seem to be missing from a quick skim:
* kgdb_io_ready()
* kgdb_roundup_cpus()
* kgdb_call_nmi_hook()

I'm not confident in my ability to spot every code path, though, so
I'm not sure at what point we stop looking.  I only spent a few
minutes and, if important, I could dig more.  Did you have any chance
to see if there was any way to have a magic linker script just add
this to everything under "kernel/debug" or something like that where
we just use a heavier hammer to whack a whole bunch?

In general any extra annotation here is better than no annotation, I
suppose.  ...so if you just want to commit what you have (maybe with
the above 3 extra functions) then I suppose it'd be fine.

-Doug


-Doug
