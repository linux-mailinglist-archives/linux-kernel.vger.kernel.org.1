Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFCD2FE599
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbhAUIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:53:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbhAUIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:52:44 -0500
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1l2VhB-0000aV-Pe
        for linux-kernel@vger.kernel.org; Thu, 21 Jan 2021 08:52:01 +0000
Received: by mail-ej1-f71.google.com with SMTP id v11so480146ejx.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GS6uyl18DS5/tavzuQl/Q5aTYUmkCKLCcwIE6hhMVf8=;
        b=q2dSSqLnbOMeUJOIaQYya2F7gIcOzD25mvTHPLnO3zNrdvWFLxszWXeryJOmSJU0Gc
         42Oi7xEskjZXQqNlcklEjYEpfg2fiWiHIJXs8b/8U5rJa7R5l8vupiWmgPgba63lVADZ
         bJGobtkSJI8xDZuj13mBOFqXK90inrLvNLmU/myz9KRBxn4KDctfzC8TmspYwIajuybW
         eYQUGcBOVUAd05itKtU7mjVE8bBkCa58bH9WYeZ42FQ9HKMOgBnGoEjdsIF1B4uNQqdu
         xOHxMLn7QVi5vv4GDio5Bj64W9xwy6EGXEYrpkNlnMF/V3FImdA7dvfXB6LC3/nH00uU
         dnnQ==
X-Gm-Message-State: AOAM5310/oqD0ftjZ9ESVzc/RXNrBJ3iobndZzoWTP8tj2Tgonr9le8L
        nlY8uL902sHWKUaoRd+zGkwSdbmwDf+sEvveUBirib7awOjdbRqLIA0D+WQR7+1j8p3cNuFeVCK
        G6+0v0Q7u1PnTOratg9kXY6KKYEV96lXveeKb1HA13Q==
X-Received: by 2002:a17:906:3b97:: with SMTP id u23mr8458743ejf.147.1611219121170;
        Thu, 21 Jan 2021 00:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvJfiKbOKkjZDF6lmyAN2L3bi0sbtRcMnGkDUWOTFgdjS6xZ6S9hdOVwWiufnA1Evdn8LRMA==
X-Received: by 2002:a17:906:3b97:: with SMTP id u23mr8458724ejf.147.1611219120941;
        Thu, 21 Jan 2021 00:52:00 -0800 (PST)
Received: from localhost (host-79-52-126-228.retail.telecomitalia.it. [79.52.126.228])
        by smtp.gmail.com with ESMTPSA id ce7sm1937436ejb.100.2021.01.21.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 00:52:00 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:51:59 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/entry] x86/entry: Build thunk_$(BITS) only if
 CONFIG_PREEMPTION=y
Message-ID: <YAlAr1Gs+Jm4r5o7@xps-13-7390>
References: <YAAvk0UQelq0Ae7+@xps-13-7390>
 <161121327995.414.14890124942899525500.tip-bot2@tip-bot2>
 <20210121074928.GA1346795@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121074928.GA1346795@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:49:28AM +0100, Ingo Molnar wrote:
> 
> * tip-bot2 for Andrea Righi <tip-bot2@linutronix.de> wrote:
> 
> > The following commit has been merged into the x86/entry branch of tip:
> > 
> > Commit-ID:     e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
> > Gitweb:        https://git.kernel.org/tip/e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
> > Author:        Andrea Righi <andrea.righi@canonical.com>
> > AuthorDate:    Thu, 14 Jan 2021 12:48:35 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Thu, 21 Jan 2021 08:11:52 +01:00
> > 
> > x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y
> > 
> > With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_64.o is just an
> > empty object file.
> > 
> > With the newer binutils (tested with 2.35.90.20210113-1ubuntu1) the GNU
> > assembler doesn't generate a symbol table for empty object files and
> > objtool fails with the following error when a valid symbol table cannot
> > be found:
> > 
> >   arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table
> > 
> > To prevent this from happening, build thunk_$(BITS).o only if
> > CONFIG_PREEMPTION is enabled.
> > 
> >   BugLink: https://bugs.launchpad.net/bugs/1911359
> > 
> > Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Link: https://lore.kernel.org/r/YAAvk0UQelq0Ae7+@xps-13-7390
> 
> Hm, this fails to build on UML defconfig:
> 
>  /home/mingo/gcc/cross/lib/gcc/x86_64-linux/9.3.1/../../../../x86_64-linux/bin/ld: arch/x86/um/../entry/thunk_64.o: in function `preempt_schedule_thunk':
>  /home/mingo/tip.cross/arch/x86/um/../entry/thunk_64.S:34: undefined reference to `preempt_schedule'
>  /home/mingo/gcc/cross/lib/gcc/x86_64-linux/9.3.1/../../../../x86_64-linux/bin/ld: arch/x86/um/../entry/thunk_64.o: in function `preempt_schedule_notrace_thunk':
>  /home/mingo/tip.cross/arch/x86/um/../entry/thunk_64.S:35: undefined reference to `preempt_schedule_notrace'
> 
> Thanks,
> 
> 	Ingo

I've been able to reproduce it, I'm looking at this right now. Thanks!

-Andrea
