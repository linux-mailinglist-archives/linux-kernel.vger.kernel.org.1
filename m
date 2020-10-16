Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B32908D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410374AbgJPPu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408776AbgJPPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:50:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4718FC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:50:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gv6so1744128pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AggGaVcXWrDt7LOaJ51+MlVSwgTWD/C/vq9jiJpyPk=;
        b=cRZGgrF2cTIxnmmVM/CTpG/kuezx8elx78s9FPcypq/Poglv4E/ofL5kM0jf6zLVYQ
         ZVtTMJqcJOAx1iLxZlNDso+hiNJQ4eUqPxQVp+09e3qHKnwaS62IHsKJNH6j0Dm5AAYe
         5MUw2kkOvjTEFukIY3XLuABttTSxNeeukt54E7PQFDmwGw6wr7FhmL11egycLmfK9g92
         pCwm1JDipbqeSuzsnXkXpAUPo/YtZeVLxYmXl791dc9U4xACQ4fpXIX56eAjrVC/J/u/
         IHPZuszLZJ5Wb8TdRP0eVIdN5rbAgSPqxYWJy1I2B+7Fg6sso1SnvjTGsN0V1IeoBivE
         VeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AggGaVcXWrDt7LOaJ51+MlVSwgTWD/C/vq9jiJpyPk=;
        b=pZ7fnOvKho0vVc23nJMQV/P0HmpiXnaKDtj9Nz1Oqfb2fP41/Hik8DRyw6vjfQyvom
         7zM9f+zpD0BtI4yn8OtPhA+kunl3k9DuFQttcE83byvN0cO5ZTJm0ooQtAtXj9IuKtDF
         noQLDGc1NZO76T669sHj4BeP5G4tvKELQ/PYJWMcbqCIs975q61602px2HoyBhUFvfAj
         J7i+JpX/leSmsxkDeBI2ANP9JLfFuXO5n8usaBGA+oPg6u6FfR5wPkicx/aYdcTu2rxL
         VL2dBkkHYbWah0bGr6hUqyxRFRvcC7HVP0OYfQEqokGpB3BczWl7E7+cDG4v9fPAa8Bp
         ipPw==
X-Gm-Message-State: AOAM533RfyK5HVDc7JmaXF5xW2/TyGpEnB2HXB+eyhQyO9rPw8wlDY/d
        mNNsVJCpJ0Cs4qfY0IdSot/DZMgEvvuBEWIeYFN4tg==
X-Google-Smtp-Source: ABdhPJxSr6lGCeQFnWTUm7Kzi2II4QnqXIVspoTBOYMhWq36DGJj5igdwFQJ9LfLYX+j4UHUfLIQjdQ5uay+Xn6JkW8=
X-Received: by 2002:a17:902:9681:b029:d5:cdbd:c38c with SMTP id
 n1-20020a1709029681b02900d5cdbdc38cmr947918plp.85.1602863458402; Fri, 16 Oct
 2020 08:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 17:50:47 +0200
Message-ID: <CAAeHK+wxqe9bdJm6o914=_GqsArVOGazYEQRt6FQbXHCOduJOw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Kostya Serebryany <kcc@google.com>,
        Serban Constantinescu <serbanc@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 10:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset is not complete (see particular TODOs in the last patch),
> and I haven't performed any benchmarking yet, but I would like to start the
> discussion now and hear people's opinions regarding the questions mentioned
> below.
>
> === Overview
>
> This patchset adopts the existing hardware tag-based KASAN mode [1] for
> use in production as a memory corruption mitigation. Hardware tag-based
> KASAN relies on arm64 Memory Tagging Extension (MTE) [2] to perform memory
> and pointer tagging. Please see [3] and [4] for detailed analysis of how
> MTE helps to fight memory safety problems.
>
> The current plan is reuse CONFIG_KASAN_HW_TAGS for production, but add a
> boot time switch, that allows to choose between a debugging mode, that
> includes all KASAN features as they are, and a production mode, that only
> includes the essentials like tag checking.
>
> It is essential that switching between these modes doesn't require
> rebuilding the kernel with different configs, as this is required by the
> Android GKI initiative [5].
>
> The last patch of this series adds a new boot time parameter called
> kasan_mode, which can have the following values:
>
> - "kasan_mode=on" - only production features
> - "kasan_mode=debug" - all debug features
> - "kasan_mode=off" - no checks at all (not implemented yet)
>
> Currently outlined differences between "on" and "debug":
>
> - "on" doesn't keep track of alloc/free stacks, and therefore doesn't
>   require the additional memory to store those
> - "on" uses asyncronous tag checking (not implemented yet)
>
> === Questions
>
> The intention with this kind of a high level switch is to hide the
> implementation details. Arguably, we could add multiple switches that allow
> to separately control each KASAN or MTE feature, but I'm not sure there's
> much value in that.
>
> Does this make sense? Any preference regarding the name of the parameter
> and its values?
>
> What should be the default when the parameter is not specified? I would
> argue that it should be "debug" (for hardware that supports MTE, otherwise
> "off"), as it's the implied default for all other KASAN modes.
>
> Should we somehow control whether to panic the kernel on a tag fault?
> Another boot time parameter perhaps?
>
> Any ideas as to how properly estimate the slowdown? As there's no
> MTE-enabled hardware yet, the only way to test these patches is use an
> emulator (like QEMU). The delay that is added by the emulator (for setting
> and checking the tags) is different from the hardware delay, and this skews
> the results.
>
> A question to KASAN maintainers: what would be the best way to support the
> "off" mode? I see two potential approaches: add a check into each kasan
> callback (easier to implement, but we still call kasan callbacks, even
> though they immediately return), or add inline header wrappers that do the
> same.

CC Kostya and Serban.

>
> === Notes
>
> This patchset is available here:
>
> https://github.com/xairy/linux/tree/up-prod-mte-rfc1
>
> and on Gerrit here:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3460
>
> This patchset is based on v5 of "kasan: add hardware tag-based mode for
> arm64" patchset [1].
>
> For testing in QEMU hardware tag-based KASAN requires:
>
> 1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
>    to run).
> 2. GCC version 10.
>
> [1] https://lore.kernel.org/linux-arm-kernel/cover.1602535397.git.andreyknvl@google.com/
> [2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
> [3] https://arxiv.org/pdf/1802.09517.pdf
> [4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
> [5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
> [6] https://github.com/qemu/qemu
>
> Andrey Konovalov (8):
>   kasan: simplify quarantine_put call
>   kasan: rename get_alloc/free_info
>   kasan: introduce set_alloc_info
>   kasan: unpoison stack only with CONFIG_KASAN_STACK
>   kasan: mark kasan_init_tags as __init
>   kasan, arm64: move initialization message
>   arm64: kasan: Add system_supports_tags helper
>   kasan: add and integrate kasan_mode boot param
>
>  arch/arm64/include/asm/memory.h  |  1 +
>  arch/arm64/kernel/sleep.S        |  2 +-
>  arch/arm64/mm/kasan_init.c       |  3 ++
>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>  include/linux/kasan.h            | 14 ++---
>  mm/kasan/common.c                | 90 ++++++++++++++++++--------------
>  mm/kasan/generic.c               | 18 ++++---
>  mm/kasan/hw_tags.c               | 63 ++++++++++++++++++++--
>  mm/kasan/kasan.h                 | 25 ++++++---
>  mm/kasan/quarantine.c            |  5 +-
>  mm/kasan/report.c                | 22 +++++---
>  mm/kasan/report_sw_tags.c        |  2 +-
>  mm/kasan/sw_tags.c               | 14 +++--
>  13 files changed, 182 insertions(+), 79 deletions(-)
>
> --
> 2.28.0.1011.ga647a8990f-goog
>
