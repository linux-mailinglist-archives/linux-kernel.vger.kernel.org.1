Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B587027F297
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgI3T3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3T3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:29:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B1C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:29:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k13so1879124pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0718eD61RtZrDelH388/EGBdg02t0E8sAAnK4wHaLTI=;
        b=XLf6gHO1NEA8tmhQdg/7LF50kkq87X1dKWBSUbU6r9YOOHiLJoZSo8ZC3Qat4EK6pN
         Ow8xmF575JzqXL9u2lQi1F2UmHBYc0ovrnvqh665n+mtCx9OKeYRWrj4cHEJG6U179tB
         iC+dxSN/WWoe2jKHf6v5ztUg1vWmBbcku9eNgiF3OaLkd0aaRzl3GtWel2E/IX61khLs
         elht9zbiQKJJnBy8yMoKI7jmRrKRLWUwUWl7a/ipPw7cPH8VkpzPrb3kBRy4057rhl5B
         UA6Ib6/oNz2Z916Z1WAcXNowkZiFEi3XV8sC4YqFNQpNdL+p6/YU1Z/qOScpq5ScYhTA
         YQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0718eD61RtZrDelH388/EGBdg02t0E8sAAnK4wHaLTI=;
        b=CQiT41e4EthYoven8Xce2Mq/d91hAYN1o8xH2SulGdv7kEeUS3En4M0iwf7TPwzS17
         CnM9HQ3FgTVvzm3hLqXlUSvy6YS5OQi4/kckoMxP/GDoug6BrTavRl7PphafuTL9f0pw
         vLT7UG6Df6ZbumweVIz7HuMiZ21PVk7gpP/c0mfz10Q36N/av/3IxvfVmLL9MuuRyFOf
         3JDx2ckz8MXlOmD0q4qs0N/S3zTRjB1EiCO5WxBLbGt0coo+SLCDTVZgQvLKPVLBrFOc
         3DVC7NBAv+Lc7s/u54n86b2bK7Z4lF7Ugr1nCkUUAlS3hS6XyUzVlm/5wEEqGF9IesM+
         MuUA==
X-Gm-Message-State: AOAM531OAD5Qte+lo5VyG9klqyCoKyhB5C+nD68m/lFXu+KoDwj3KK4D
        oabveLVCyHOvHCQGfsKbZ9FKhQejeKaGTLsykDl/dQ==
X-Google-Smtp-Source: ABdhPJxAB7toVvdC7oK/mMFS3ytWoP2zt6f0LxsAgfKuz6QoNhpIwoXK9VpFzFoMYDBOQM3BuCiu1C3jcZRMANl5aak=
X-Received: by 2002:aa7:99c2:0:b029:142:440b:fa28 with SMTP id
 v2-20020aa799c20000b0290142440bfa28mr4215825pfi.30.1601494190534; Wed, 30 Sep
 2020 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkHzbPjw71n+RVXuM6Wt6PNO6fiy+14QTzthF7MCkewwg@mail.gmail.com>
 <CA+icZUWvEzUhCjkMYAK22pkjshKmfE4a2y_W0sPPuqRtzXOtNw@mail.gmail.com>
 <CAFP8O3LQSS4BufLEPQKOk62T0d8HoZq0kQAU8+K4d4gpY4CPag@mail.gmail.com>
 <CA+icZUU44tbsmGfTc-2OO42V42Z02dRSs7AZCJBnXL65vJDz-Q@mail.gmail.com>
 <664e5923-d65e-0a3a-1320-8b6635146676@redhat.com> <CAKwvOdkiSLidxNxWUxCrJ_rPogORt=aGDHTkbO=yJn0FPevbpw@mail.gmail.com>
 <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com> <20200930173719.GE2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200930173719.GE2628@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Sep 2020 12:29:38 -0700
Message-ID: <CAKwvOdk+Rp0QGJmX07XxD8L7WVgco98LHFTu-R_2R22+UMVerQ@mail.gmail.com>
Subject: Re: linux tooling mailing list
To:     David Miller <davem@davemloft.net>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Clifton <nickc@redhat.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, postmaster@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Behan Webster <behanw@converseincode.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
Apologies if this request has crossed your desk already; I know my
unreads in my inbox seems to have doubled this week somehow...(should
I send them all to /dev/null? I think I should.)

From Linux Plumbers conf Binutils BoF, Peter had the idea of setting a
toolchain agnostic email list, and from the thread folks seem content
with linux-toolchains@vger.kernel.org.  Is this something you would be
able to help set up for us?  If not, is this something you can help
delegate to someone else to set up (any pointers who I should talk to
in that regard)?

The full thread:
https://groups.google.com/g/clang-built-linux/c/GLEkFKlDXfo (sorry I
didn't cc lkml sooner for a proper lore link; I myself am ~1 more bug
away from switching away from google groups forever).
-- 
Thanks,
~Nick Desaulniers
