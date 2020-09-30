Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B221E27F023
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgI3RRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgI3RRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:17:53 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E795C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:17:53 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id k18so1862455ybh.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pI0ZPii+Ef4ldfhEFgHhgreWPVL6YgxnLxQdaEvG2Ik=;
        b=isfEgguRV45OV/H+5M2SDAvctmMWraDuCzYsMoO8ze1Td/qY/F+uDZSU0nJtauFyjN
         otE+4YWFK4aHexsMLaipZFG7o4e0i5B06ejpd8HcEobH7VHAZNEuAfQD1cs58vT8ApFN
         UCbRbnxnLy4sy483yEjRbrXSQKNeXSEyGQWe/LgAcokEYE2qvvn6VSIs8MLO9rKTPuTZ
         NVGWUJ7DxqOTTx8ZMnM2Y0n/AKQFeoDofLQiokQyrqPlCCCsCmI+IEX4kiY2z6DtYQcH
         bwLm92Tx8blyaNDjkR8Sc4D5EyN5JtQFsUsBG7QtFcdWQDD51Ywyd+mbzZdUug3Krtd8
         gkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pI0ZPii+Ef4ldfhEFgHhgreWPVL6YgxnLxQdaEvG2Ik=;
        b=tv7lZ8J+HVxUQWHmwbwn2W5/VBuZvf2n5zK0LhN/vR+m0PHZlFO2jsHBtn7mcViIsd
         Hd9e8VoVHb5ilbUpenGEHsjzpn1JX4dbv41txOfkbuiXEMxNIfK7mwXMkgV8Bw3pwKn+
         SO84Hs3JPOQAZFPH339nUTB9KRxOo60aOn9REbTSisL3zmi4Wynp2uATDTOf+Lz6bI3x
         kjfDhqEYAgpjRVwITqs/eoi/oViG857sLbidjQWcOBlT8D7j1qIbKScTh8iq/6aWlK/C
         RhXptyVZLUclasC8UuB5gd4BKK+IF9+gdagvzhxZgd27PYNG5oA8HjrrjgZlr3x+9crt
         0BzQ==
X-Gm-Message-State: AOAM530Hlw+25RkGEJErJE8D5jOD1Q9U/bRa5ZzyjK1ewSQjUlk24alp
        WL3KmCfawrpJKhT+vJHzorB9Lte/gZ724NCUw26UUA==
X-Google-Smtp-Source: ABdhPJwT22pelbEjsgpX0X5cEEpTC7Z0gwLCPhFqu1W8xH5wnCc+JSIFEjJJ5rA3I0EGPbKDfud1mjhfYY9OpwVD2oQ=
X-Received: by 2002:a25:bd93:: with SMTP id f19mr4130854ybh.155.1601486272356;
 Wed, 30 Sep 2020 10:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200921152653.3924-1-kan.liang@linux.intel.com>
 <20200921152653.3924-2-kan.liang@linux.intel.com> <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
 <4e974520-6d0f-68af-7eb8-fa52d95ba77b@linux.intel.com> <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
In-Reply-To: <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 30 Sep 2020 10:17:41 -0700
Message-ID: <CABPqkBTk6H0Wku8gGJeBD2naFU=WOqp42VSjFBhk_1Wy6bRzXQ@mail.gmail.com>
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 7:48 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/30/20 7:42 AM, Liang, Kan wrote:
> >> When I tested on my kernel, it panicked because I suspect
> >> current->active_mm could be NULL. Adding a check for NULL avoided the
> >> problem. But I suspect this is not the correct solution.
> >
> > I guess the NULL active_mm should be a rare case. If so, I think it's
> > not bad to add a check and return 0 page size.
>
> I think it would be best to understand why ->active_mm is NULL instead
> of just papering over the problem.  If it is papered over, and this is
> common, you might end up effectively turning off your shiny new feature
> inadvertently.

I tried that on a backport of the patch to an older kernel. Maybe the
behavior of active_mm has change compared to tip.git.
I will try again with tip.git.
