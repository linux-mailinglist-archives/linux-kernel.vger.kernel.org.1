Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F22953A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505543AbgJUUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505533AbgJUUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:52:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD4C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:52:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so2191925pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ClZ+itAYHP1SxYy/1eiELkqdER63iI6Fwa0ilWU8UeI=;
        b=ajPWpU9RuEZH1Nq7OAbOr8zwHPWVHRVda1XVCpTMTHC0uH84EVv/0zw4i1wJqg0RwH
         ZP1393V/uJq6KtTlF+DVb4yoW+f5v+pRiOonR8ZEwNsyR3QcNXXRasCX3G5opO+p/DUB
         ikCHO/JqWzdljdTyiMxkVM6V6NF5Jrr7eaAJ2XULS3flxlQcWyEtrATUhwrolbUXccJQ
         snPgvtUKevn7KWVmmMXnG4p3ghzTfSMsrWsXOxUGNWdVnEOx1uds5GVZ6uNXCMz2XQm0
         pk9dMkyPgQ3coELRuQJWhkz32cnRdBw74+UCB8Fgp3vM+ASmgzAJMbDcT61+rWf0P4eB
         E87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ClZ+itAYHP1SxYy/1eiELkqdER63iI6Fwa0ilWU8UeI=;
        b=q+0seSMNzhPS+gsccAC6z61HAPR+etX2mrGs0bggMY7hqM3GfAaDB477qg/P9ot+Mr
         Q0Py8VvGPrvsID4IfojV8vBEpipSH1O28pfBwFn7EO92dHAWAURUnn83uRJbHd2Uxidq
         zQpTh8ORP1W4/Y0++Vou26P192ebGtc8uZ/WcUhZW0qGpAW3DBGWbH0d+gVaeiFhfia9
         7si4UdGA6pY2lCeERQ3tHHIh7cZy3FGIEwON84IfXLOxbrBRYO9h30Q0lA/UTERjio83
         cmrQTklnEgYOhJ98oZBlOYtFzbYXuZRFQKTb6eeobK3/6MeeDbo0+kxxXXvgJPL7h1pa
         cFJQ==
X-Gm-Message-State: AOAM530iiTbGrFpK0dVd9meX1pNgbWkw9wcMBvreI3cgPJM7j3XYW4b+
        ZSBSerDMIu2Cq63LXahBATniR8pWzyw=
X-Google-Smtp-Source: ABdhPJzGiQjpDY7gnJz5NDNIw8J0GXIiHlu6sw/bX/hGeZ8qcxeakjhDS/kDcaI2mEbnZoR3WxwIWQ==
X-Received: by 2002:a63:e443:: with SMTP id i3mr5032148pgk.289.1603313573881;
        Wed, 21 Oct 2020 13:52:53 -0700 (PDT)
Received: from ?IPv6:2001:569:7f0b:ce00:d8dc:3b8:20f5:171f? (node-1w7jr9qweqixwcgii8kjz0x7j.ipv6.telus.net. [2001:569:7f0b:ce00:d8dc:3b8:20f5:171f])
        by smtp.gmail.com with ESMTPSA id q8sm3333768pff.18.2020.10.21.13.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 13:52:53 -0700 (PDT)
Subject: Re: [GIT PULL] prandom32 changes for v5.10
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amit Klein <aksecurity@gmail.com>, George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201012203226.GA11861@1wt.eu>
 <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
 <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
 <20201021032725.GB396@1wt.eu>
From:   Marc Plumb <lkml.mplumb@gmail.com>
Message-ID: <6700002d-e775-4c6b-5ebc-2d6a872f1a62@gmail.com>
Date:   Wed, 21 Oct 2020 13:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021032725.GB396@1wt.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As one of the participants, I mostly backed off when Spelvin seemed to 
be more aggressively driving a secure solution. I still think that this 
is an important change, both to fix the original network vulnerability 
and to avoid harming dev/random while doing it. I greatly appreciate 
your time and effort on this but didn't want too much chatter on the DL.


On 2020-10-20 8:27 p.m., Willy Tarreau wrote:
> Hi Linus,
>
> On Tue, Oct 20, 2020 at 04:08:03PM -0700, Linus Torvalds wrote:
>> On Tue, Oct 20, 2020 at 12:26 PM Amit Klein <aksecurity@gmail.com> wrote:
>>> Quick question: is this patch still planned for inclusion in 5.10-rc1?
>> It doesn't even build for me, so no. It clearly hasn't been in
>> linux-next or anything like that.
>>
>> Hint: grep for prandom_seed_early.
> I'm a bit surprised, as it worked for me, but thanks for checking. Given
> the lack of responses from many participants on these patches, on several
> occations I feel that this series is really not welcome. Initially I just
> tried to test and fix Spelvin's patch, but if there's not that much
> interest in it, or even reluctance, I'd rather stop. If it's just that
> the current state is ugly with the two PRNGs side by side, I can get
> back to completely removing the original one as I did in my first series,
> and propose a larger series. Or if nobody's interested, I'd rather know
> so that I don't have to put more time on it :-/
>
> Thanks for letting me know,
> Willy
