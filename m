Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708962F6A93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbhANTKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbhANTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:10:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:09:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v67so9626443lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSFOf/M1xL/264JjP2cMg0iIIXj3yETLyQPUyKa74CY=;
        b=B76EQUji9gAB+zfxLKnpsCS1bruYEs8UE0K86b4ZZ4HnOVw2oDoZYKkLBaeiIM4QAz
         mONjjhdOwqqd67GGb7qSRXqRwSu3nqhcWj+4vkHjI362HcGbcUGfkK4a2r5IbTPwXyAU
         LX7ngQUjtOv+ApPsZBRKt+ekd7K/wWpMB+Gjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSFOf/M1xL/264JjP2cMg0iIIXj3yETLyQPUyKa74CY=;
        b=rNnFZg2Ub8CRl8FfJvsiQ4c9yIdgHsGaywNeIJkiSL5at0ywWojTOPl/V2eYVKRZRY
         7KQI88I/4SRtmcslJLktqtCf6qfjiSTDC1oBNDmOne4qo6IdoA7trBFauGScMcqyMwIe
         9Cpy4ztc1ZxQCpGWLfcSNu2WjDLb7bNaX0LOEWsm0ZevkIxqW9TqE0Bw0WR5gouJG2m/
         fp0QGZqlaoOjLh14DI2DMYAR2g7t8ocl0QZciS5t2KR6xMrNm0sTEjxy2Ui6PkUpP8dB
         y9aKBbU8el6ld9VoUiQrW8EyT4GOqpLo0c7p6RwaANXDldAM1dzZbk0MnYgMk4U72oQt
         ddOw==
X-Gm-Message-State: AOAM5301SQp+Q0NZJ+i9xWrLPOKLdJJCk1F1P5zshgQfc7QCLgMFZZB7
        0KVXg/tP5Uo5U4C28FmxMcWvQIHaiDxCFw==
X-Google-Smtp-Source: ABdhPJx8jzU6TeJ1XCicWxncSdPzM6DiYZBV+RukSOcMOzrmqbeZrJqT9WdN/2DVhEiMHAgNdrrrqA==
X-Received: by 2002:a19:844c:: with SMTP id g73mr3724563lfd.462.1610651359243;
        Thu, 14 Jan 2021 11:09:19 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i26sm305040lfl.309.2021.01.14.11.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 11:09:18 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id f17so7668709ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:09:17 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr3659547ljc.411.1610651357370;
 Thu, 14 Jan 2021 11:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com> <20210114190021.GB13135@willie-the-truck>
In-Reply-To: <20210114190021.GB13135@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 11:09:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
Message-ID: <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:00 AM Will Deacon <will@kernel.org> wrote:
>
> I tried that initially, but I found that I had to make all of the
> members const to get it to work, at which point the anonymous struct
> wasn't really adding anything. Did I just botch the syntax?

I'm not sure what you tried. But this stupid test-case sure works for me:

    struct hello {
        const struct {
                unsigned long address;
        };
        unsigned int flags;
    };

    extern int fn(struct hello *);

    int test(void)
    {
        struct hello a = {
                .address = 1,
        };
        a.flags = 0;
        return fn(&a);
    }

and because "address" is in that unnamed constant struct, you can only
set it within that initializer, and cannot do

        a.address = 0;

without an error (the way you _can_ do "a.flags = 0").

I don't see naming the struct making a difference - apart from forcing
that big rename patch, of course.

But maybe we're talking about different issues?

            Linus
