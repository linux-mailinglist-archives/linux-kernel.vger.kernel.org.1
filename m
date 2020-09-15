Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0726AEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgIOUxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgIOUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:50:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F5C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:49:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so2651650pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQN0ednkgp1zJbGZ3MuZGCQdVZKsdpv3cYQ+zMKOR/U=;
        b=eKmxCli6MAqjY825CYelH6OIonf5Kf4aN0AJbKAbb3tgva1GEd2E18A+o3pewdS23X
         z6kLSv1OxiZ3mRrQOYxwBFciQ8fF0x9CBYWX4z3JDSvwOgNqaywZvLu6wPwIDms23dTM
         IJsTh08Nq+lR12VR0+CeRIIYiVofX0CNyAFRBRNKy5lG9sjuysRlXVgBkPRFg7PntW8L
         aihzI46Fyg0rV36sVWuuTF7EnkjicepY8S6nA8oaamNcOEcHmrcOVsBt+FpuYObpzsrb
         3e1lAST/oxL7U4cUa8vv2nvxVyIk664l6SWG7OiPgmiW3aYyeHHwgOBW/yVqTPI8x5CZ
         EOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQN0ednkgp1zJbGZ3MuZGCQdVZKsdpv3cYQ+zMKOR/U=;
        b=WzZLYl8agO3g0DSCRTjG/BP7Nb2tkQkSOhqjFOkGTgvHgfZ8ktlVH82OzYAA/hNjQf
         oJwJW0yLPXlPJPOtvV6kxbFDHavTN5rfYrW+iKdET2EqLTYUDPOMyliCZg/IupWCW4QC
         5Gl54IU0N78K9kQe9+XHIvHGmsSo0s3dEv4oJG8spnYr7EquMsno/QzER9Uv3AXeYBPr
         rcAP54SBWm3yf9d4RTrOh36qmqceMc1lg13UpABGuNRSpe7ME9UpfIg1NPOFagmJNYHq
         m4iEUnlunqZ2GqEc8bwOyZELyvv4/EESBcJz0o0rvQ+223oqToV3vu7xSzQCxAIualAY
         uZ3Q==
X-Gm-Message-State: AOAM530ZkHnARFXtVUOhcg2b3T8ubHaTFcf4kHAofP/nya4Wvr11ijop
        7MEdOBPnhUNgnYN32EVgLqn1fBqz4/kzLPq8lek9iA==
X-Google-Smtp-Source: ABdhPJxFB963MU65B1a9E7v2Mmlq6zNB1cmrCZMdoVfcNU5+bqnQPe0WDctIZ71Y0529lskt2ixBiBT3IkTU2jKiMXg=
X-Received: by 2002:a63:7882:: with SMTP id t124mr6286483pgc.381.1600202998459;
 Tue, 15 Sep 2020 13:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkHzbPjw71n+RVXuM6Wt6PNO6fiy+14QTzthF7MCkewwg@mail.gmail.com>
 <CA+icZUWvEzUhCjkMYAK22pkjshKmfE4a2y_W0sPPuqRtzXOtNw@mail.gmail.com>
 <CAFP8O3LQSS4BufLEPQKOk62T0d8HoZq0kQAU8+K4d4gpY4CPag@mail.gmail.com>
 <CA+icZUU44tbsmGfTc-2OO42V42Z02dRSs7AZCJBnXL65vJDz-Q@mail.gmail.com> <664e5923-d65e-0a3a-1320-8b6635146676@redhat.com>
In-Reply-To: <664e5923-d65e-0a3a-1320-8b6635146676@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 13:49:46 -0700
Message-ID: <CAKwvOdkiSLidxNxWUxCrJ_rPogORt=aGDHTkbO=yJn0FPevbpw@mail.gmail.com>
Subject: Re: linux tooling mailing list
To:     postmaster@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Clifton <nickc@redhat.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello postmaster,
Any thoughts on linux-toolchains@vger.kernel.org?

On Wed, Aug 26, 2020 at 3:14 AM Nick Clifton <nickc@redhat.com> wrote:
>
> Hi Guys,
>
> >>>> Would it be possible to setup:
> >>>> linux-tooling@vger.kernel.org
>
> >>> s/linux-tooling/linux-toolchains (better plural toolchains)
>
> >> FWIW FreeBSD names it "freebsd-toolchain".
> >> NetBSD names it "tech-toolchain".
> >>
> >> I'd slightly prefer the singular form.
>
> > OK with singular form.
> >
> > I was thinking of GNU and LLVM toolchain*s* - that's why the plural.
>
> Personally I prefer the plural too, but it is not a big issue.
>
> I am however delighted that it looks like this idea will go ahead.

-- 
Thanks,
~Nick Desaulniers
