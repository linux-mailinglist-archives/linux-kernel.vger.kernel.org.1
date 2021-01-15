Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43902F7CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbhAONd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbhAONd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:33:57 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC164C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:33:16 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 186so11594742qkj.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0aoGg0wPuE1hYe4sqWhHeR+8ZOS1Jh5Y7WE82oHlpQ=;
        b=LpFhrwzGtivImHuZyJyOguqdzO/W6jTbisntyRsA8SYA0st26tZxXzsVp0UCcBzpyY
         s4cMz9Cr2GUSypTdyNhkmMIp9YwhuIUoWrnuI4ppAKLO9X0Q7Mm89lvZfO5N7atXYTc+
         9Vj+efQwYTaOy+5WFfHpm8FdcGbMr7EpTTW7PFW8W0igIVsw9AIqppb1b87rFDCkcxjy
         fIKnmtMTEh9tlIEqTphJq/96v5h5usIHaf+SEmgcT/5ogQ8d21giWCsqwOUgilZlwifr
         NqvNVJpvwVmPSVcjzidnGHdMldOP5lWKus3YFw38eYTfmDcQgnumIT16b33j25Hf6i2b
         BI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0aoGg0wPuE1hYe4sqWhHeR+8ZOS1Jh5Y7WE82oHlpQ=;
        b=JSltoBajpLh41o2eg9gYqal7J1dyyoeRKQzJhWKuJYMIozWLwxj9CaSgDKW98xwhne
         7Kr40qA+vRJdbGTwX8lCoNUl1lvtloQN3f8DcnM+mibtFggkR3P763FXVVxB8crxBcsJ
         TCqFF5XcTiUZW77TUjYnb9NtDmb4CHaRWV0CRBfhm985McUITBaLEHQFourAVx6I0387
         SCujnj0pj7yw9pMAl9n3k/kPv/S76JSMx9OTt92uKXPBlEjmiBXn5awp0TBIBXa1CQUK
         ehrD+eTM7gjsLz1jVZXTjyBvKmY52O8VF81PpVaYWdTGDCS3DaPY8ZrTXd22Fm4Zl29V
         1pvg==
X-Gm-Message-State: AOAM531RF4BFgUPNbujaps6oHHl3eHl3ucOHbfkF3feS4TD6yAmjSZi3
        I6WSYrVqpjaGm2vEqKKnLSS+MxCMOO+CGWRwI0Parw==
X-Google-Smtp-Source: ABdhPJw5p3xgG12EUUQ9NmnmlmvaLHhlOFEA/tDuImAA12I1+PC+ozHXAXHgKRI4ctQifa8qFZZEaLPZ6Q/SpkaJwOE=
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr12177058qka.403.1610717595909;
 Fri, 15 Jan 2021 05:33:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <5153dafd6498a9183cfedaf267a2953defb6578e.1610652890.git.andreyknvl@google.com>
In-Reply-To: <5153dafd6498a9183cfedaf267a2953defb6578e.1610652890.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 14:33:04 +0100
Message-ID: <CAG_fn=WcrOHH0eoG=R9-6w3pqs2ig-weowWFG78r-s0whDqj=A@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] kasan: add match-all tag tests
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 8:36 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Add 3 new tests for tag-based KASAN modes:
>
> 1. Check that match-all pointer tag is not assigned randomly.
> 2. Check that 0xff works as a match-all pointer tag.
> 3. Check that there are no match-all memory tags.
>
> Note, that test #3 causes a significant number (255) of KASAN reports
> to be printed during execution for the SW_TAGS mode.
>
> Link: https://linux-review.googlesource.com/id/I78f1375efafa162b37f3abcb2c5bc2f3955dfd8e
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
