Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79D2FD90F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392536AbhATTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392363AbhATTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:03:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:02:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v67so35588888lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRwEI3btxtj96W25BROzNdz7dSErjaQvsqQaEByDHM0=;
        b=fslzBvPR1Y7FPiWJFUInGLF01YEuRrj3b2cwqpq5xIHuKS0SOYrSkKduJzKFpFUiy2
         WwEaDKL4/QBIHf2eM8UFJBukg1D6G5+BeVl/JIeuykTs4JyKCxKHXZJ5Cu7I63M1Qi0Q
         Y1GJrxh29gtzCs/T2x4dYzzhvhEfhxpjBFRgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRwEI3btxtj96W25BROzNdz7dSErjaQvsqQaEByDHM0=;
        b=Tmlni5shQ+SK9JTmYZV2Pqj7Q7Wn04xN7BtKt7pkl1YeSb1HUrhCn+PhxW7idrIhlW
         9vQFGvtnjEk+Q+Hj3ORtgBMs+y9nB8mKdSRNPRtMJnlc8fjAJ2OjojDy99bR+GoZAOZS
         tcEdttBp1Fm9vAmttC3jyDuQiXFd68ueIKRh/xsTqhNsloGlO1LwZmTFJDA97jB/cub3
         c5z+wR2cF6xdxo0qooTrwi70DhBnYSP1cwy6YfTi8Hxm0vas6dmApQBNtZy2yhk5Q6eJ
         8J1F3VyTVkRbVCS6Sb8Ok3LjIUbFQ9fSULtM2B3WeCMbptKDpJRgZbSOx0wva7oI6rMT
         zNLA==
X-Gm-Message-State: AOAM533H0wUFl4nloTdk6y/r2RzWcf3O15hiL3Z/NW6WZsbpcrHwCp9T
        B7ewXemE/3y7gySfppG1xH/hjDOi2sIdZA==
X-Google-Smtp-Source: ABdhPJxUDnpfemzdRMuhr26gZoHDG5omnBOiS1HAcdPCtQKlYUX5iUZX3icj1s3oyi02rv1SKoEoaA==
X-Received: by 2002:ac2:4ade:: with SMTP id m30mr1318086lfp.231.1611169343938;
        Wed, 20 Jan 2021 11:02:23 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m15sm272168lfb.96.2021.01.20.11.02.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:02:23 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id i17so2194470ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:02:22 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr4869975lji.251.1611169342502;
 Wed, 20 Jan 2021 11:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 11:02:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
Message-ID: <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Is there a difference between: [ const unnamed struct and individual const members ]

Semantically? No.

Syntactically the "group the const members together" is a lot cleaner,
imho. Not just from a "just a single const" standpoint, but from a
"code as documentation" standpoint.

But I guess to avoid the clang issue, we could do the "mark individual
fields" thing.

(It turns out that sparse gets this wrong too, so it's not just clang).

           Linus
