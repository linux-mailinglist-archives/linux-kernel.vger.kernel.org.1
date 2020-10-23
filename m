Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F193B297307
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464784AbgJWP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464584AbgJWP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:59:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04966C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:59:40 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so2692512lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3Ulwnj9weeuLkSzeBnteNylHfcf2HfYiMwB14GigO4=;
        b=UtOySjc4D4HoPv1550/vIz8G+9uh2ALNjxBUZdL7SK3CmBfgME3m1I4+efzQSAMZKZ
         LgjEDtoiKs+G+xDKuwyeOHq8L04fmBWEEGuuiYcc79v/phnIuxPO0QaH1OhARKOPDyTT
         aSq0NvyzYorcX8O1Pt/l1aPYGgKnjeoA9cka8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3Ulwnj9weeuLkSzeBnteNylHfcf2HfYiMwB14GigO4=;
        b=GJ2ca7y6SB/y8j1KkPmoUdCyagQPvDBqDuK9t3VQ7K1vcIFGY2x49rFdkyBqSNe2E7
         kjPKGYKUBwdOA0xcvv3l/LmaIWgmC9NzueL10ZOy/97baqzdGho74QABQXEvEipAu+CR
         O9WHCgesj9M2iUzFwMq2T/qQ4XDmcfJY4yz+jg9nCxIxhszu2zW69ShdcBbQA+ImuBEy
         bgZM9x/MWCNTKtwYUoosDVLyxtDVSFs4jphbuMiZjizCSv2jZ7V3kKDgVxuyCQaqL6Rj
         OqhMxW5teCE22Ps2QPcCWeLjMwQ9nmjVeJajh2xd8VqmL9jKpy4IYvKN++TRi+KmjyJJ
         4Hdw==
X-Gm-Message-State: AOAM532wWu9PDcxswTpEsojZQtTfXTjWnduvDKV83jeidDzWxTAba6X+
        fl1okXZ653ctX6JsjQqrlPVzIZf+v78VIg==
X-Google-Smtp-Source: ABdhPJy3n9H99OY01SuzLbPMSpirdoSf+X6wWxaSzTZcirSlvKyydZkg8uJmyBtYJvrWKdWfE97UUQ==
X-Received: by 2002:a19:4b03:: with SMTP id y3mr910701lfa.534.1603468778156;
        Fri, 23 Oct 2020 08:59:38 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y7sm203019ljn.79.2020.10.23.08.59.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 08:59:34 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id l28so2673104lfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:59:33 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1108317lfa.603.1603468773447;
 Fri, 23 Oct 2020 08:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114228.9098-1-pmladek@suse.com> <20201022114228.9098-2-pmladek@suse.com>
In-Reply-To: <20201022114228.9098-2-pmladek@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 08:59:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif0QueN8ovkm_x7TsOgOHjRrOa4wU-zHgBP=FTAnzvNA@mail.gmail.com>
Message-ID: <CAHk-=wif0QueN8ovkm_x7TsOgOHjRrOa4wU-zHgBP=FTAnzvNA@mail.gmail.com>
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 4:42 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Users use various undocumented ways how to completely disable
> console output. It is usually done by passing an invalid console
> name, for example, console="", console=null.
>
> It mostly works but just by chance.

Honestly, since that 'console=""' seems to be out in the wild, I think
we might as well just (a) document it, and (b) make sure it works by
more than chance.

That said, I also like John Ogness' suggestion to have it as a
per-console option to mute a particular console. At least that seems
like a perfectly fine extension.

I don't really see the point of a whole new "mute_console" option,
considering that people already figured out an alternate way to do it
that we'd have to support going forward anyway. Just make that the
standard.

             Linus
