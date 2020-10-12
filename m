Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590928BE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbgJLQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJLQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:33:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDBC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:33:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c141so12362117lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHRkgCXS/4kxgwy5q4bUq99hC9D3+OYqvz8yqO31CzI=;
        b=ZG06AiX+/49KCe0Q2TW4r9V4eXQ0gGkyb0bb/WaPWbnz+WFQ0ciDtrjvJrwTmUQ2P/
         32Ml5rL9ANglmIiAcAIXYFihJXMYikuPWU4C1Jdy8sUSXJlVd6uebWfgpQZgT2Jj4WoT
         aOjbpwpe1n/ribdKRRHRDGJdUOqqzWzQ16B5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHRkgCXS/4kxgwy5q4bUq99hC9D3+OYqvz8yqO31CzI=;
        b=p+xcW6F0jd2LfGMVXVKcyUQgfPtlytQgCkGpqqa/LaxHbN65YOyRPdOAfv0AbPi+qc
         f9wfRYznNJ2M6KJC/+GPLfUbBykn7591I8P6MJxiTcu/ZKLdUT1D2ROBi1nrEkU0LgL8
         +XmO6DfGafu1+5wnV9zaEl62HUccmlCBHL6u47ePMTxyt2vmuXJ8ajy4PhqUliUdH65e
         3k6323GuJSnZHV307f4UjPzAHMVJwxbGtWiIUXPvyfxLtqaDgc7hvzxPBGtwo1G525wj
         yehhC+k7IV4aYNm6lYNHofPunnkhp93Pg0flMvCGn4bYXnAtbA2vK+J6ABwy3l4b2Tnx
         nVeg==
X-Gm-Message-State: AOAM530tPj8l2qbY/iOxjHDT3cHcV6n85xiZ+BYtvoq0i7uMFYSSsYVi
        eMGlRzgA6nMVk+ko6G2g/JrcRR0zcz3TxA==
X-Google-Smtp-Source: ABdhPJzQBUVwsQ+Qli/o2mmaXpz6g8wKzLwVvMpB07Uln/ErUqKRrAx2j+vlGeKIsoe6i+vpXHKHAQ==
X-Received: by 2002:a19:4186:: with SMTP id o128mr7735244lfa.148.1602520433587;
        Mon, 12 Oct 2020 09:33:53 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d24sm1720590ljl.58.2020.10.12.09.33.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 09:33:50 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r127so18947591lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:33:49 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr1888495lfg.133.1602520429420;
 Mon, 12 Oct 2020 09:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200921092355.GI13157@shao2-debian> <4376a51f-a0f4-5615-edc9-2105b57f550a@linux.intel.com>
In-Reply-To: <4376a51f-a0f4-5615-edc9-2105b57f550a@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 09:33:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEd58q7Seh18w9S0+UWAGRYgjTiOahAyYiHCrc1N6YZw@mail.gmail.com>
Message-ID: <CAHk-=wjEd58q7Seh18w9S0+UWAGRYgjTiOahAyYiHCrc1N6YZw@mail.gmail.com>
Subject: Re: [LKP] [mm] 5ef64cc898: vm-scalability.throughput -20.6% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 11:57 PM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> Hi Linus,
>
>    Do you have time to look at this? Thanks. I re-test it in v5.9-rc8,
> the regression still existed.

This is one of the series vm-scalability tests that got a huge
improvement (up to 160%) when I did the complete page fairness patch
(ie commit 2a9127fcf229).

But since that fairness thing caused regressions elsewhere, it got
mostly limited, so we are likely back in the same ballpark as before
(although hopefully without some of the absolute _worst_ latency
peaks, who knows).

All these vm-scalability tests seem to be very noisy and unreliable,
and the exact details of the page locking can cause huge differences
for almost random reasons.

I think the main issue is just that bad timing luck and the fact that
the page lock is too contended under some loads makes for test cases
that can show fairly bi-modal behavior.

                  Linus
