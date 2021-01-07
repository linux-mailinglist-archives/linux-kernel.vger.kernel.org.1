Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02B2ED60A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbhAGRuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:50:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95276C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:48:31 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a12so16563189lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2vIDRi4w4FrROtR4uQE1WT5c/8OSWqME6TgOEaIYkk=;
        b=ayTvX31BvLuhk8m3fgGQmOSMsYpjQ54lgMyv8fbSEETOrmRwWzarzGX+vEjcHQSume
         YgWKMHLIGWJom0QE4ydgQzQRA5Fzav71GE87OAJlyce2ERGLaUyVCt51j7wVrDp1E1De
         dR1r+z0eZnbfoUzCpgqZ0fd0rk09yR0j30n5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2vIDRi4w4FrROtR4uQE1WT5c/8OSWqME6TgOEaIYkk=;
        b=CIpFR9tfW+RjfsCmlWF+8tvBIcKcINoz555cR/UBj4JzZVUb2Ag62cSf/NCN1EJ/0m
         z2+ae0tSm8o8UFp/yu6XtH/csH56x0GlXoJK9C3KRKQMSLcacvwx12vBj/EGSlSCsdQh
         ChFiJ7u49X1YNT2yH7cMb0jLAFrWua6wi9hHiHYiX5w7rhC868T3ZaCkrgney6Z/NkV3
         A2FZUKjj1hzG5zh9jwwnPH3fRXroVrVRn7AihJwH3BCK1SiFIhUf/PNMbmcx6o1+u1yg
         YW+cDC+ZjzTU3S6Er9MVf0S0H+8EWpLC9+qK1dWyupAi+yzGmmT6WnmU2FVFLIZpCZ1P
         kD0Q==
X-Gm-Message-State: AOAM530UQFSTcBk9xT6MKcoaQ3Bbm+sX3Mehy6vaubdH7nIZDqv0ker0
        p+C7zgYRbReaHC02PG9Jr9QGbButjM2z+g==
X-Google-Smtp-Source: ABdhPJwNlY9D3jguwX2OoTef0v0AJ1cKv6M+4R1s6lmxrwuFqwJvWDEo5EYTzOgXDliwlg1Lp2jtQA==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr4768801lfk.510.1610041709905;
        Thu, 07 Jan 2021 09:48:29 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s1sm1421382ljs.0.2021.01.07.09.48.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:48:29 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a12so16562996lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:48:28 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr4577806lfb.421.1610041708536;
 Thu, 07 Jan 2021 09:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20210107164400.17904-1-pmladek@suse.com> <20210107164400.17904-2-pmladek@suse.com>
 <20210107174638.GH4077@smile.fi.intel.com>
In-Reply-To: <20210107174638.GH4077@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 09:48:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKt0Xec69iMK18h6-BNZ+3vWR-zswQtip=Y0unK0K56g@mail.gmail.com>
Message-ID: <CAHk-=wjKt0Xec69iMK18h6-BNZ+3vWR-zswQtip=Y0unK0K56g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
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
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 9:45 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>>
> Shouldn't it have Fixes tag along with Reported-by ones and explanation what
> was the actual problem reported?

No need for a "Fixes" tag for a revert - the commit it reverts _is_
the thing it fixes, so that's implicitly there.

But yes, a reported-by with an explanation of the actual case that
broke would be a very good idea, so that the revert documents the
particular case that caused it, not just the "big picture" case.

           Linus
