Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09D82DC7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgLPUXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgLPUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:23:48 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF195C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:23:07 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so10411474pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/u0Ml7z8U6hoRgIhUcWTGpqRq8tZ6gW1mUfFKW/Eh3E=;
        b=YxNWi7p0t1283L9u/yRAz+3PEm5W18srxEKo+tvG7XZ3z6a/WW1fJcQQ8VNbobGf60
         8dMcg4TTJxdA0mO805jU8wXdFLImf4lhNSDVXv0ukok2XXtw75UNzJLDiCeko82+VRrG
         tJDBPP0eEQhocXu8e9o4wRJRU2ijAGHTw0M/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/u0Ml7z8U6hoRgIhUcWTGpqRq8tZ6gW1mUfFKW/Eh3E=;
        b=g1AarisjBFlCe5BeFVlAr5iyLXlUexKNj4W8Q6RFysEov6Jn2nYx1HwpjmTwVpDSIV
         VcQh6G0gTV7QMnMO3XpnTMu90yDa8ZpKxoO+gFbCPcSlsd9u9dm3PItZa59EgkudamhP
         vFFEV6Pj/E8Z+df+4MnjUK5feugPNrfdoUPDKXyrxiBDjLfktTTXGqB6OEF2S2ww0coI
         /QAk3HyqTHxCcV1HFgEN3YI0rWvdworxdBZHFNz+HPY7asyon3pJNQdOPruR5oJCwvlP
         0/+jlEbZelBEX3JQgNKvrR58jVc+3PsSgv//QbBs/53eQrOWOkx6RBNGidlugSmS2nex
         eFaw==
X-Gm-Message-State: AOAM5308KA054Z4TCeaWD1pOyPuilmsYBHtTKvDbIU15SeqxPzPcAilk
        hkckDzBAHPy0ZQ9r66vQ5eTHpg==
X-Google-Smtp-Source: ABdhPJyFpM/otugbcdzZt/TsMDbqfxyVFXKIvI3gJb/onxct24dwWbur/ChxoAitPRminzqAis0+zA==
X-Received: by 2002:a63:7d47:: with SMTP id m7mr34095599pgn.405.1608150187361;
        Wed, 16 Dec 2020 12:23:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c199sm3815754pfb.108.2020.12.16.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:23:06 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:23:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [GIT PULL] gcc-plugins updates for v5.11-rc1
Message-ID: <202012161221.18C0E3B5CC@keescook>
References: <202012151215.E7AA7D6@keescook>
 <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:24:04AM -0800, Linus Torvalds wrote:
> On Tue, Dec 15, 2020 at 12:15 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Please pull these gcc-plugins updates for v5.11-rc1.
> 
> Hmm, I pulled this and then did an allmodconfig build.
> 
> I expected that to be a full rebuild, since the plugins got
> recompiled, but it turned out to just take 16 seconds because it only
> compiled the plugins, not any of the object files.

Hmm. Yeah, that's a bug. I think that's an existing bug, though. I feel
like I scratched my head on that too. I will see if there is a sensible
way to have Kbuild "notice" that -- I hope there's an easier way to
invalidate all object files instead of adding all the plugins as a dep
to all .o builds. O_o

Thanks for the heads-up!

-- 
Kees Cook
