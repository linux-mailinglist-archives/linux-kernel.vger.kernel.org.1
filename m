Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0236C28F4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgJOOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgJOOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:41:59 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51433C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:41:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f10so3116823otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P881tWlvRdjOUKzZkLHYnQuoFJ//OFLM6pqz5XqJ0Y0=;
        b=vE0eTPBnSXNiINasMQUFywAglF77XO05/Nj27/lfv4vHR8X1epIMbVDwWp3fUmG81e
         6E7eEtQyFdyAVDX1pOA8PTS//vIvEdnH9mTXPw7by+G5J3pwbAO/F2TCNXfNHBlI6iqL
         dXnDfWE6neAEw6bqKNaPv7++j3S3G2TWh1Q9nBzl4VMw5xBajkUkNa8QwtJzagpBrP8G
         jeAJQ+UvBUzyRM5eGeBXPnLGcif7fNNXShuyNLNp3AVo9GKw0WNvZK56i7nj1oxWdkWq
         h+VIDBZzbzkP8n0rbY0bT0shf/7dle2c7aYCEi7PdkYJY3dBf/bjktx2Gh3m7voJhSE1
         aWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P881tWlvRdjOUKzZkLHYnQuoFJ//OFLM6pqz5XqJ0Y0=;
        b=d5TvB6mcoamzTBJiF2c4yfY+lfia1+nNWZTomtUlxyfhZbYSBo6kpxd80IVDz/6A8T
         UEP9oVHa1UALWdAmu+lBmB0OB5Ir2QRhw7FtoePlwW4qeac98pCLX5FxnsIFmBkgOXVu
         1nv9gWXoE02+gIQDpaFfu82R3/367q6H56SckwuNb6cMOeNYJffFY/mCN8nMssGdh3JG
         Z2UgoiNx15PAEi3y4uUj72p2MylG93ooFHwPe87JGgjwGB6tGuVwlpI2CmBNrsU40FwQ
         kWZhtKpNnX0FoH6TnTPODcHbbUctz0b4TcpKx0QZZmttS5cEbycu6N1Bf8E0BXdk6Xuu
         Z16A==
X-Gm-Message-State: AOAM532uXiCS7OJeZ5zwOyrxrOoMWsf0XqOS34A4WUmJiLAIeRm7Xyjg
        Ag5YgdEywYsIAOahqwDyECv5GXcVIr3t3dfBL3U0qg==
X-Google-Smtp-Source: ABdhPJxeD69uK/WOd7mMJ5EHO3FBe0XlcJCzarJJHq+SUu5D5oRkFBcvqg8LMItlZGVc6gmUn6U/GGdOvuhubW+9zlQ=
X-Received: by 2002:a9d:649:: with SMTP id 67mr3039830otn.233.1602772918284;
 Thu, 15 Oct 2020 07:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 15 Oct 2020 16:41:46 +0200
Message-ID: <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 at 22:44, Andrey Konovalov <andreyknvl@google.com> wrote:
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

KASAN itself used to be a debugging tool only. So introducing an "on"
mode which no longer follows this convention may be confusing.
Instead, maybe the following might be less confusing:

"full" - current "debug", normal KASAN, all debugging help available.
"opt" - current "on", optimized mode for production.
"on" - automatic selection => chooses "full" if CONFIG_DEBUG_KERNEL,
"opt" otherwise.
"off" - as before.

Also, if there is no other kernel boot parameter named "kasan" yet,
maybe it could just be "kasan=..." ?

> What should be the default when the parameter is not specified? I would
> argue that it should be "debug" (for hardware that supports MTE, otherwise
> "off"), as it's the implied default for all other KASAN modes.

Perhaps we could make this dependent on CONFIG_DEBUG_KERNEL as above.
I do not think that having the full/debug KASAN enabled on production
kernels adds any value because for it to be useful requires somebody
to actually look at the stacktraces; I think that choice should be
made explicitly if it's a production kernel. My guess is that we'll
save explaining performance differences and resulting headaches for
ourselves and others that way.

> Should we somehow control whether to panic the kernel on a tag fault?
> Another boot time parameter perhaps?

It already respects panic_on_warn, correct?

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
[...]

Thanks,
-- Marco
