Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CED27A436
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgI0VPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgI0VPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:15:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840BC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:15:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so4593573wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wo4yLXRXGXzvWNduXQeTvSnGkItHS2XwJ0Qpb3pIebI=;
        b=PgK5dB0EfwyESJ76pPs8H8HZ8y2jTGBuxHe4uughIzKTKEYDK5K0aDlVXaM9Go0lLv
         HZJKsSAjwDlad/w+aTw9VQjCpAH+zUi66wG0xOdSZ5NYBOxxwQr1kKMZ36+g+tpADcTN
         1UuW4XkcYBDjEQvVzq5d/GpnX+yKBA+DradgPXcKW/CpfMnjR7RuUe+xq1hFwHY92T/j
         9U28piAZGkJf+2b1TJUOZATdigvwym+uE0p4g6jP3UYVNWwLWunrBkdLfqgxeIMvuI/d
         vxdC4oUwP2BVl4T+DU/wGbCarpqek5EaA1WDd2QZ6EknGltY9h7Q0ZdnachlhuoINFgu
         OKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo4yLXRXGXzvWNduXQeTvSnGkItHS2XwJ0Qpb3pIebI=;
        b=OK01C3DXJiUl3HozOGPvjlcUKsg8tp6qMXHr9mopmNCRwWzBuRc1KngM/29C7YVM9u
         kC3txz6kJDwHYKg/x6uzbfp6cu/AGSnW4eUaA62tapVbI3KCCp6nJqNcvHgcN2RLrRRW
         Iqpuc2E4MjELHLqOYogZbCGBM+8ip+DvNSgz4D7RcKbUP0wlC5NQkDxVQq4Uic3twU1q
         mO/z62Y/n+jKNGrwyuO+4zT76g7os0x1lhgLgJt6zTyNhiwO1JbVSC+QWVA+aaqJVhwp
         n7yGb9BWHXCVyr0U07VVYGBWwVE0lANKRDOd6oUWcjzZPtUAsjAAlhh3EWqrV4rB5BP7
         jJMQ==
X-Gm-Message-State: AOAM531nvj0xk+Q5YZfvubm0zgohE21UC8JpWXZXZtV4TtX6g75J7l2t
        HygH0INbDpbdyHzL4xG9CsGVBQ==
X-Google-Smtp-Source: ABdhPJxZTZglZnvISi46LyC0c5QCR6qmfidmxXPZPTk7a/ypsDTNNHQeo9gTmNUMQz0CipMy10a7Rw==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr8647508wmb.171.1601241316210;
        Sun, 27 Sep 2020 14:15:16 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b84sm7220960wmd.0.2020.09.27.14.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 14:15:15 -0700 (PDT)
Date:   Sun, 27 Sep 2020 22:15:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
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
Subject: Re: [PATCH v3 2/3] kgdb: Add NOKPROBE labels on the trap handler
 functions
Message-ID: <20200927211513.3crdqbo4lr5xno7j@holly.lan>
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
 <20200914130143.1322802-3-daniel.thompson@linaro.org>
 <CAD=FV=XTgNxVLwytSY1wmCj7Dex3cWGVMA+Rkpp9gb1UN5CU_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XTgNxVLwytSY1wmCj7Dex3cWGVMA+Rkpp9gb1UN5CU_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:14:22PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 14, 2020 at 6:02 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently kgdb honours the kprobe blocklist but doesn't place its own
> > trap handling code on the list. Add labels to discourage attempting to
> > use kgdb to debug itself.
> >
> > Not every functions that executes from the trap handler needs to be
> > marked up: relatively early in the trap handler execution (just after
> > we bring the other CPUs to a halt) all breakpoints are replaced with
> > the original opcodes. This patch marks up code in the debug_core that
> > executes between trap entry and the breakpoints being deactivated
> > and, also, code that executes between breakpoint activation and trap
> > exit.
> 
> Other functions that seem to be missing from a quick skim:
> * kgdb_io_ready()
> * kgdb_roundup_cpus()
> * kgdb_call_nmi_hook()

I've grabbed those (and a one or two extras after paying better attention
to the entry logic).

> I'm not confident in my ability to spot every code path, though, so
> I'm not sure at what point we stop looking.  I only spent a few
> minutes and, if important, I could dig more.  Did you have any chance
> to see if there was any way to have a magic linker script just add
> this to everything under "kernel/debug" or something like that where
> we just use a heavier hammer to whack a whole bunch?

I think one could play games with linker sections but it would involve
adding extra infrastructure for the kprobe blocklist. I'm not convinced
that is worth the effort whilst there are acknowledged (and bigger) gaps
elsewhere.

> In general any extra annotation here is better than no annotation, I
> suppose.  ...so if you just want to commit what you have (maybe with
> the above 3 extra functions) then I suppose it'd be fine.

This wasn't quite confident enough for me to convert into an Acked-by:
but I plan to pull v4 into -next very shortly after posting it (since
everything else is agreed).


Daniel.
