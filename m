Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5E291097
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410922AbgJQHm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406218AbgJQHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:42:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8F7C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:42:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so5947611wrl.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nuuz9yi8Y031tKgDWok/ahu1bW/JJ2vJv28TM2RgTI=;
        b=S8DTt5VgS5NmR9ckDdJlmI2YSnCm5/+Kf/Qsnm+fzcI2WeLBMhr8ZdDOzTMH21TKof
         mjAFbWH2oGUYeNQjEuw6jbvnD4afwgeUk7YL0VOrSAdV6h5nEU7KhYjUlt+ctOBvux9Y
         nwMa036rpr+SgzuU5mouaZows2ZQ3RzC6txnlZwlCW93tzv/fw/OFv8TJ8tdxOAUayrM
         VpnMA9fE0olI8hz7aoFlRrpkVdTutZ2dP1eijwFz5naBlzSFbfHsGq2YiyXhh5hMo2Ih
         YTpdmoZ/yNkZDqeoAjuCqDoiQEPKXplSRD5Df7eGCOc8PpLEdL6XRKZcU8Fx8hyx+JyN
         +4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nuuz9yi8Y031tKgDWok/ahu1bW/JJ2vJv28TM2RgTI=;
        b=Kyqc1C8JrlS/FFXcaQ9bfTxg9g6Z+ktbQU9kiTe/gkRkfNv5MfWzx7npLvxwJ64xB7
         pf5UDWJ1bauDDdRZ1mMRlarq7hZFVkuCxOOVgvGSA8SDe99/xSHwj9GwlPMrrMFkZDLe
         rn7CY37+O7IGBs/NVvdylr5dAPKSxaHjgwSmAzSevvRUpLAUlO1DGVNbZEFbBo5vFNzh
         yAOoOdoVTUsRQyOhJdrFDExegOIL0iyh2+xgE37w7RZmf5XYGrwi+iQuDFj9l7abLvXQ
         Qu+b+jdUwd/sN8CHAUsKgU3fjupmn+tPzBSy2UBrgmHJ6Sz7eYM2wdWHlqkZfVa23Ywo
         Mz5A==
X-Gm-Message-State: AOAM533MCtQWG8hjetPqFqo2rfr51ZAGkg3YUS5J8N2t3/O1v3SoDpNQ
        UF5rM1sBaiP+qngdnSw7VBKlNM+F/40Y05AQBLrpgA==
X-Google-Smtp-Source: ABdhPJy9A/6uEDOmpUZ9DKM+fvbvAWksxv9VVCkLa8R4yNFNugKzpc8LHRGHDXZQA4LSXICJ4BplKBwvQHYoqFvltu0=
X-Received: by 2002:a5d:488e:: with SMTP id g14mr8889936wrq.203.1602920576419;
 Sat, 17 Oct 2020 00:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <44861eaca17ffbb51726473bc8e86ad9e130c67e.1602876780.git.andreyknvl@google.com>
In-Reply-To: <44861eaca17ffbb51726473bc8e86ad9e130c67e.1602876780.git.andreyknvl@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 17 Oct 2020 15:42:44 +0800
Message-ID: <CABVgOSnMiNHZoj36NfHTuQ3xLOu-W7FqMnE93cgJv465Kv1QUQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: adopt KUNIT tests to SW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 3:33 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Now that we have KASAN-KUNIT tests integration, it's easy to see that
> some KASAN tests are not adopted to the SW_TAGS mode and are failing.
>
> Adjust the allocation size for kasan_memchr() and kasan_memcmp() by
> roung it up to OOB_TAG_OFF so the bad access ends up in a separate
> memory granule.
>
> Add new kmalloc_uaf_16() and kasan_bitops_uaf() tests that rely on UAFs,
> as it's hard to adopt the existing kmalloc_oob_16() and kasan_bitops_oob()
> (rename from kasan_bitops()) without losing the precision.
>
> Disable kasan_global_oob() and kasan_alloca_oob_left/right() as SW_TAGS
> mode doesn't instrument globals nor dynamic allocas.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

This looks good to me. Though, as you mention, writing to freed memory
might not bode well for system stability after the test runs. I don't
think that needs to be a goal for these tests, though.

One thing which we're hoping to add to KUnit soon is support for
skipping tests: once that's in place, we can use it to mark tests as
explicitly skipped if they rely on the GENERIC mode. That'll take a
little while to get upstream though, so I wouldn't want to hold this
up for it.

Otherwise, from the KUnit side, this looks great.

I also tested it against the GENERIC mode on x86_64 (which is all I
have set up here at the moment), and nothing obviously had broken.
So:
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
