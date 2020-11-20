Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B552BB1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgKTRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgKTRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:45:25 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277AFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:45:25 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p12so10889090ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nq90uK5aI7OXvasUP3ijD18zoEJFHakQHaYxV9BwXq4=;
        b=LkrjTMl0RWRdOFf2X+Cd7vTR3rSj2NExUbzsJY6JXQRn95Asao/TaE68ikkYma4kZW
         F/i4ySVbTgLT3TMlWyN1i3eMkqOTy5AQbL96IjPwrXec4glaaZHTaYlkbTwtET4bWAhD
         uiMhKG3BEkJepderSibZK94ovQsk+tr9d8w48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nq90uK5aI7OXvasUP3ijD18zoEJFHakQHaYxV9BwXq4=;
        b=Yjwp4MiuuMkU2FPv/tiFhhe3jw9UsCalLeGGfYO56wZlMtDxmrFo6ZJQgWJEQRf/zm
         BFq1ZNnGjAHKsrqx+lxnFF0lZy8VCCT1B7YcSE+rNbBjTuA+DruVJQ7JXXB6ppZe2iv8
         IBp5vSt/hQwTd7SI4pbQTPLHiKuWkqLSQhibY1gcTbuClFQ2ft+vOiMzCYlWljrm96Kd
         rEXUaI5oBB/mQy3A9RBEXFKMhkxARVltk3KGhc2YowM3kMAjg4sHOq7w/yrmQ/ubQoTa
         wbCiCoi3ByP39LC3l6lqQEigYcE5mm8Lp6vDcEGjZ5uFhQ/i8veA9DBcTdzTu9orC/AR
         N00g==
X-Gm-Message-State: AOAM531mTtrtAOyYtFgFduKXe8qEibx7ISdxGNZIHykgxRdOF6RDluAb
        2TipV+tLuafSDTRyuanwoPMoNILB9t0/+w==
X-Google-Smtp-Source: ABdhPJwtoWu5laTXrzopNC6DQkMc+jlFW+mYhTIuYxocjEaEkmRlBPauSTEMYFCJ+hkFu6isTWH6LQ==
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr7686229ljg.176.1605894323218;
        Fri, 20 Nov 2020 09:45:23 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p24sm410916lfh.241.2020.11.20.09.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:45:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id f11so14645946lfs.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:45:22 -0800 (PST)
X-Received: by 2002:a19:f243:: with SMTP id d3mr7702755lfk.534.1605894321954;
 Fri, 20 Nov 2020 09:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20201120143557.6715-1-will@kernel.org> <20201120143557.6715-7-will@kernel.org>
 <CAHk-=wjKjnT=yNnRgfPRknOBYF4oJHixbT10wDqXpjQ1qiW7SA@mail.gmail.com>
In-Reply-To: <CAHk-=wjKjnT=yNnRgfPRknOBYF4oJHixbT10wDqXpjQ1qiW7SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 09:45:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih_FMR1TiWVvSYi2f8mvXozqYYfZqPqLNc-OJZVDSqJQ@mail.gmail.com>
Message-ID: <CAHk-=wih_FMR1TiWVvSYi2f8mvXozqYYfZqPqLNc-OJZVDSqJQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit toggling
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 9:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This code sequence looks bogus to begin with.

Oh, never mind.

I was reading the patches out of order, because 4/6 showed up later in
my inbox since it had other replies.

You seem to have fixed that bogosity in 4/6.

             Linus
