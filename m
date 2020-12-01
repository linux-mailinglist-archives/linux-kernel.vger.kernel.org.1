Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF42C99BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLAIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgLAIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:41:54 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 00:41:13 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j21so793307otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ImR5mFtg9wXtOK4HaxnOpZ6Mas0agGqVuxRp77OqsA=;
        b=ENWN14cwf5Erp2hWTHmj6/ZYf4XWpQfYkqIKHIPZmzszZmQDZMtaI/o4zhWJWx6m4S
         /rHUlqg1YJu2ENfj7oogh5ZX0p+6MnmsXhswsPWP85X06nXakNYPgfszPHCsRKj1htc3
         B4MBfAw6Zyo+SDB5f9OjH9sKygIUrjK+bBC7XXjGMfkENAxVpTD7iIShkg4u56fq4hDc
         z+hJ8N/JqxhwyoIz3SseOZRMBVXG2ErBT/A/iQw65rBikykAvCJVGjafMi2UFotIkPXE
         Okdsc2WdmukIlpQmO2pkz8yDAtdvjg/uCa9y3DNI1k71f3U9FUrA/HBKnqZzXRUDLwBq
         Q9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ImR5mFtg9wXtOK4HaxnOpZ6Mas0agGqVuxRp77OqsA=;
        b=jcDWcdYtnPaEPwbqkDppjYk+NvKducEwOvGCGnaKRnyQ+Yj+LFKciFmvDdBTlTJg8k
         2qykTkyw7csAlrTCpGIz6S55ImKW7Dg1ejatVyeKVMdBacad6aYy/jY7l6hRgFOj/mpC
         yb05noW5dC+xEI+tGL5DFjplaNUeos7B4f8GgUv559LUZi9Duzf4sRLnggAg0lQEQ5Ll
         4slnnNBMuTUg2MK+myNP24cuLa+XTwvEET5+yLpCvE3o02M7ttxDlgTUf8cWheWhrPoB
         cnL6AJTYQmYonoh1ub/ZJetcE7BOF5NpSUMUpA8afUmGnvUWi3jQ7eJJSbSeOA7uwEvO
         L3tA==
X-Gm-Message-State: AOAM5304g8QSfvYlv8sGPRZhfgiOPdO24lYYXHjZHGrVPMTmbqDIYBDO
        SwG4Azf/k/OWDjhshuKn4VQfklfHTMpwYZuqy21hQQ==
X-Google-Smtp-Source: ABdhPJy2FYYGfYobibxQ4zItAlZBew2mWMMTETYVSIJmglwPK78qaXJNfFyrS3uhvJOaP7TA1VW7XY2tubIYMSU9evY=
X-Received: by 2002:a9d:7d92:: with SMTP id j18mr1142495otn.17.1606812073263;
 Tue, 01 Dec 2020 00:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20201124110210.495616-1-elver@google.com>
In-Reply-To: <20201124110210.495616-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 1 Dec 2020 09:41:01 +0100
Message-ID: <CANpmjNNKgKAxHVdxC9LWpwrxRREU7JdMTeDiCU7hzMG=Oh9QcA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 24 Nov 2020 at 12:02, Marco Elver <elver@google.com> wrote:
> Rewrite kcsan_prandom_u32_max() to not depend on code that might be
> instrumented, removing any dependency on lib/random32.c. The rewrite
> implements a simple linear congruential generator, that is sufficient
> for our purposes (for udelay() and skip_watch counter randomness).
>
[...]

It's been about 7 days -- feel free to pick up this series (unless
there are new comments).

Thanks,
-- Marco
