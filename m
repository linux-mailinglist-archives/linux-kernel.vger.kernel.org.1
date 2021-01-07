Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B763D2EE642
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbhAGTjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAGTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:39:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC42C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 11:38:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o13so17394296lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgTyS1NQ2UzjKoMzADBXjDVj+VbxzQgHopw6iDs7tkA=;
        b=DBpOtA1VUWMUKMvUYSZL1Rtw2oCnY7kRjiP38Qb86yzJghjeCZA4URMxOB+vUm9V5w
         ws4+O5Iv67QUEOkqkw/HNV17BUWg+ivR+KJhAHhs2PhTYzAZW4ML0JiFxvGX1dtsOl3K
         cEVf8kDbjZV4fStbf+4q58+pg88jkFIn/WrR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgTyS1NQ2UzjKoMzADBXjDVj+VbxzQgHopw6iDs7tkA=;
        b=eqYPrytAtKRaBsc3gs4Zh+/OkCyweV8OQDKsawUvVfJ/2Bul1pBUfSgHUJB5P4O+39
         Uy+N9QmfIIjHEtueOOje8PpVjRAv54PPz/iAJ9cXGTRqKVZnHTBaBrkUy+2li4tOGFYA
         LEPtvuROSNzGVOsH11rPA3Ze0ECGMiNhO95+LnZoz5YMmwjT+NphxCk2jca0/rSvl4zE
         ZgwZkw4REhPn0iZ3Ap+PCrlCVSQKWh6ept+LmXcaOxluPUTPhAjoQkX2y/+Fy+mRAtgw
         qhAvGvnU1rObT9wlNA72Bj0AvR+ZUecsw1XTPtpkym+0BTAXpMrVevvQTIKd/NZlE1yl
         yQCQ==
X-Gm-Message-State: AOAM533JbRhhJT7K9CAepwL2mSXlJufUhxLB7BLdOOxATjY5e2sIWjVo
        2tLbzFOpSAh7n+a8VJSqv8B0PlNlPPd04w==
X-Google-Smtp-Source: ABdhPJz10VmtufQBWihaYisW2seIJvwi7U+DhgDDcGPfPDZ2XXgOL6OIcIwVO2b5XnPAZWCWwo4NIA==
X-Received: by 2002:a2e:b5cb:: with SMTP id g11mr19433ljn.502.1610048333482;
        Thu, 07 Jan 2021 11:38:53 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 68sm1474167ljj.23.2021.01.07.11.38.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 11:38:52 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id x20so17249337lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:38:52 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr110163lfi.377.1610048331953;
 Thu, 07 Jan 2021 11:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20210107164400.17904-1-pmladek@suse.com> <20210107164400.17904-2-pmladek@suse.com>
 <X/deF3U+LK5YCQT3@kroah.com>
In-Reply-To: <X/deF3U+LK5YCQT3@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 11:38:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSz8tS=QqvnMDk4qHe5t5FS-Nk-SQMPAHJo5SJYp_t6w@mail.gmail.com>
Message-ID: <CAHk-=wjSz8tS=QqvnMDk4qHe5t5FS-Nk-SQMPAHJo5SJYp_t6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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

On Thu, Jan 7, 2021 at 11:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Linus, can you take this directly, or is this going through some other
> tree?

I was _assuming_ that I'd get it through the normal printk pull
request, it doesn't seem to be that timing-critical.

But if there is nothing else pending, I can certainly take it directly
as that patch too.

Petr?

            Linus
