Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0D2EF7D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhAHTEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbhAHTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:04:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D50C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:03:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a12so25396849lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCPSQAa/gh4YgO7FJC/K0d24//fghwxCWnDWIhPCuHs=;
        b=KPfXf/negleYseEYvP5xY+8qF5PMEww3dcPbGE9iFuOPPtznLwbUAoixQx5X/hE01r
         uXBYPLaqyg6wFwzUkmS+DKPlVWCZgcS9IMAE0sR/NsbBCzFthyTiHG/QtTvV/+6oEhL8
         9KyxavkbSE2tQz8IBLDUJLj1u5x4g7AwCn7Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCPSQAa/gh4YgO7FJC/K0d24//fghwxCWnDWIhPCuHs=;
        b=B9YFTQtNd7sJZ5y3p9bXpsNeRA/qMA9ZAcoCjfBpBK9gg/6c88s5tKr0I1upRc7wT/
         dY/i6SqPjz2ZPd3dKpvS1oVnzHJ1SNDJRjKQkuDVwqQg/KTgr9Tw2VpQsn93rl2Z5UZY
         nbUS4WB7Mq+6v+gcAZ4wN4BXMtojzpSxN/D93EkUH1iFYZ9Zfz5DEdNYec9FnuS6AzwH
         Dhzsw4+HTOtEaurYUCmv16/Gc3cbSe4K0LgvvetwHiQRiHqAifbKOfdZ2nec+B78wLBe
         GqwbXYo+YwSJRxhnmhqcWnaGaiXhC+9/PYbbhzmTLkWpHfsEPODOl8llU9mUQIycZvBj
         n0PQ==
X-Gm-Message-State: AOAM531RiCYCUge980BfUrQ3QBMLOas7XA1K8BZ2jDXxxLIq5IY9kbXY
        iLLg7hFoJJ2pmoQZokScbn43aqVFukUaww==
X-Google-Smtp-Source: ABdhPJypZwOuhCliDIetVHqDufnHosx7R1SoilKt+gsOT4qs2vbK4+w/kzDAB46l0ckXdFErPT21Sg==
X-Received: by 2002:a05:651c:1255:: with SMTP id h21mr2188460ljh.8.1610132598517;
        Fri, 08 Jan 2021 11:03:18 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s5sm2147602lfc.150.2021.01.08.11.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 11:03:17 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id o19so25434080lfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:03:17 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr1825059lfc.421.1610132596921;
 Fri, 08 Jan 2021 11:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20210107164400.17904-1-pmladek@suse.com> <20210107164400.17904-2-pmladek@suse.com>
 <X/deF3U+LK5YCQT3@kroah.com> <CAHk-=wjSz8tS=QqvnMDk4qHe5t5FS-Nk-SQMPAHJo5SJYp_t6w@mail.gmail.com>
 <X/iaJw1JKRRGcoX9@alley>
In-Reply-To: <X/iaJw1JKRRGcoX9@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 11:03:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+X3DFsnPkx_v_w-amuELJiQrwZrKrGBaMpk=dZaYh1w@mail.gmail.com>
Message-ID: <CAHk-=wh+X3DFsnPkx_v_w-amuELJiQrwZrKrGBaMpk=dZaYh1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 9:45 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Feel free to push v2 directly.

Thanks, done.

            Linus
