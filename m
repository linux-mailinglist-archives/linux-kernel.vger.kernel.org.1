Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0892FD9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392702AbhATTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392627AbhATTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:40:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E7FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:40:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a8so2068766lfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQ/PIa+xFrMMmWkHSlVcGDO0dSR+BGNs0oqmsfRTI+4=;
        b=BwzKufG1cmihffvIJY8GqHD0JAKRamXQ4+NRsSa6Y6hTEyVNHf3fcyqTOX2RK/JHKo
         1J+GbPkGp2/9IMw9bkNY1PJ1SscRDoMAX4VTfVX/zM0Bhr7Sv2H6Dk4VZKNNdMq+6N0W
         xncu1a+Q3aNVm90FklHZC7uyhQw7RIIOPkK0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQ/PIa+xFrMMmWkHSlVcGDO0dSR+BGNs0oqmsfRTI+4=;
        b=oBrm7njeRHBPlQO0z0N2p3vBjBszXwVfcnT2GXALZA27D2B27xbmZiFMP4lClO8zp+
         U6DB/E0yq00kW8H0DZEyNRQHZb/kFudmQRBiZ8aUd26PeZztxQmGtGEnnIocZGlvPr+s
         Ztxa+EUCd4MInnqAnBpuxdD1ftJJeODPs8i11sEUg65JHe2+4S2ufW+T+urZojuSOK5R
         4C9qEHSjvVGQ7xuWKaCF7AAZHxdbxFAQix91D4yFL67IYtY4tnOMAYXNP29aUg/DyXCX
         sgURsHJ41MglGmEWbnmp++aAn3JumVNd5kKWRt2uZ/8vJsF1lv3QtURKQMq2Hki2tIWP
         ntLA==
X-Gm-Message-State: AOAM531FjK68POw9+OHLvvj4Z6fGZ5pkfmm5lgLgEB53sa9N4FZFu9Uj
        9iz3lJpsCSDsmxe5a/kRkqyyeqFo79KLHg==
X-Google-Smtp-Source: ABdhPJwPU3YA9H3eElWZwv1SqdS5yExL3yJV7IkxzrAdyBAtk7+5041/3aHoQQ0yn1GLhXQQdInHBg==
X-Received: by 2002:a19:c787:: with SMTP id x129mr3029987lff.211.1611171608243;
        Wed, 20 Jan 2021 11:40:08 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m83sm280047lfa.113.2021.01.20.11.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:40:06 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id h7so6478476lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:40:06 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr4714519lfc.421.1611171605824;
 Wed, 20 Jan 2021 11:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20210116220950.47078-1-timur@kernel.org> <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org> <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org> <202101191135.A78A570@keescook>
 <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org> <YAf1lS8zsHwhShCr@alley>
In-Reply-To: <YAf1lS8zsHwhShCr@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 11:39:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnEV2E6vCRxv5S5m27iOjHeVWNbfK=JV8qxot4Do-FgA@mail.gmail.com>
Message-ID: <CAHk-=wjnEV2E6vCRxv5S5m27iOjHeVWNbfK=JV8qxot4Do-FgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Petr Mladek <pmladek@suse.com>
Cc:     Timur Tabi <timur@kernel.org>, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        roman.fietze@magna.com, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:19 AM Petr Mladek <pmladek@suse.com> wrote:
>
> And we should definitely add Linus into CC when sending v2.
> His expected opinion has been mentioned several times in this
> thread. It would be better to avoid these speculations
> and get his real opinion. IMHO, it is too late to add
> him in this long thread.

I've seen it, I've just not cared deeply.

I suspect the main issue is if you can cause debug dumps as a normal
user and find kernel addresses that way, but I'm not sure how much we
care. Somebody _actively_ debugging things might need the address, and
KASRL etc be damned.

I also suspect that everybody has already accepted that KASLR isn't
really working locally anyway (due to all the hw leak models with
cache and TLB timing), so anybody who can look at kernel messages
already probably could figure most of those things out.

So as long as the dumping isn't doing something actively stupid, and
as long as hex dumping isn't something that is easily triggered, this
probably falls under "nobody cares".

             Linus
