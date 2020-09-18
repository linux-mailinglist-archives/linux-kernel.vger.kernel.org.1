Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B892026F97A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:41:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C52C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:41:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so4659817wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shufKx5eku0Isd8JdGv9o7lMkOjjIZQhALDCFPr9wG8=;
        b=jMjmQEvjgFFIcifb5X5DfDKjDwBe6m9GSre09/+c42/6Z/Xo0iBf5ninjNVTic+xcJ
         tZy1xj5BMJ18HIQniE9IIJS4ruoVeNBNA0h00ZfLWLQjDiEEfQC1430Vg9CrX7F75Gsj
         JoPotqJfb7TtpX80wlRpDbIl+eBS2tRSyEATK6nwZHTK3D8EMVmjKjTlop1gatdvOKvr
         O+02BtJLzf1KNGglp4wMMbebM+SGyOu0omhSg2Mc1Hx+aGxMTJfspKFv0t6+tfJIZP+8
         GfLbIfw2mvBfDtDYISN/RWSQJBRG4sSN02kqbjnohdLSbpDfgeXomb/DzkIjH2Rd/2UW
         QHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shufKx5eku0Isd8JdGv9o7lMkOjjIZQhALDCFPr9wG8=;
        b=HdzjioPV1EY+igvQdTffJIz7O0ref6ueHFp3lSEM2XK7Y9zEl0hADX4IVhFKlW4BCX
         ZJOX3KbFd9PTYlCT4ktzS6+bMCaKpXQbmdtCVf065vEUGwUGuRQIkrikdpLIcMB0dPRT
         rygverhO/CnL+AtH5Q7Upovn9k4UV9COdSRlE+2G8DcOjxVrb8SATwRVGIHGTAyWY3kG
         HSS2X8et+aDN2/mJsPOvBJgf0BjH1IDjJj5JtV2OxsYa8hxhh6JQACUsxCGwRAT8Vr+l
         SctxkOlw0jX+KZlU3UEpUy6yQyHALkFt5yYUK6/9bGzMmXNmE54WPjonebrOTOJat5vp
         wRMw==
X-Gm-Message-State: AOAM533dBeQ8BobiiyHgxDjSVLGG9tt4IUAP3v8qWpC20nc9aOWrb+qs
        XxRZk2jEP7kgIob/+eSiR3pySHTP1mi8F5MUuAmFfg==
X-Google-Smtp-Source: ABdhPJzAPvLFupR3Bbk2V9wPg73c33btEOd57AZPcmiW9SKeMtRpvi87yFJ2Z2vgKFd4kRqMDJxW4EWDIAUJ22BGbj8=
X-Received: by 2002:a1c:b388:: with SMTP id c130mr14511635wmf.175.1600422115149;
 Fri, 18 Sep 2020 02:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <28d17537bbd029104cf7de4f7ca92246449efa50.1600204505.git.andreyknvl@google.com>
In-Reply-To: <28d17537bbd029104cf7de4f7ca92246449efa50.1600204505.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Sep 2020 11:41:43 +0200
Message-ID: <CAG_fn=UACdKuiKq7qkTNM=QHcZ=u4nwfn7ESSPMeWmFXidAVag@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] kasan: rename tags.c to tags_sw.c
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:17 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> Hardware tag-based KASAN will also be using tag-based approach, so rename
> tags.c to tags_sw.c and report_tags.c to report_tags_sw.c to avoid
> confusion once the new mode is added

I find it a bit excessive renaming the same file twice in the same
patch series (tags_report.c -> report_tags.c -> report_tags_sw.c)
