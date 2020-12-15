Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581D12DB78E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgLPABC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgLOXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:44:49 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A5C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:44:09 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id q25so25340017oij.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMk7SZpHhf+ZRi/9XRqaSvGITvxxA084fMeyBbrwPkI=;
        b=JTpekMpAsEiOdX/ypVa/2Vb/gs39skDO/K70WK0u/tyOhRMBBlnCh1UdiFmocnIq+J
         flWJKhvv4JCoLFgPvbCgiqVNqNwRoSJ9unRsOM6ITKAPBb7IFE923RZJawPnSaZipNTQ
         LZJbOMHHQHOr+noAU34okB/7/TFZ/gZfE1Q/3Zb7qWDxEQn49ruEzvhajFfZjFr0qq1D
         RieIyQ6gc+6U1JoWIgmC3LQ4KABbUF+OlA0vgh9vSsPVKP8eRaAvdeQY+Ci/Jdr6XLtL
         EEASy1u4t/pIpuCnMl3WKuzliJprN6Tf4FxXhExRRa79xgPLkNYmc2aKxaA08tJXE1MR
         Ttjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMk7SZpHhf+ZRi/9XRqaSvGITvxxA084fMeyBbrwPkI=;
        b=nkv8+crn1huLd4+olJtol1+HB1xTGTFMbQFCQkQWzrVIY+LurRA7XNj+Dnaz+AgTfK
         tfHwG6cD+KDvo0moHY6l/596WW0IaM1DtIrl9XKIjOc4rPz7oyS+YVLFVe8fhYzDb/5x
         uv2Yq/nUVs/hCeWtl0tv0uqyMW9hjcMFVQ2RFupnd5CZzsBduloyD+MLrC91VFqaUNPr
         EZlyPqAlF1YgkopxFx/vk36Oou1L9bLqf+6lodnhlZDJSmr5kHlipzBs1hzxU0+SfTf0
         S5BJO4q66a2gbpd/yco6/SJWuHNUz1XokwSfWJHbzBEc2C50JqGODzl0eyBIafmptTw/
         5TiQ==
X-Gm-Message-State: AOAM530e4NHI3UsOubq3sGhLfyGgFpOTxtV4QZKQu6YnII8kszuUY1uO
        7K0iw1ghPrhycTOmbUM68r9xAfZX87F8bwrSok9heQ==
X-Google-Smtp-Source: ABdhPJzsujCOinIWRtM4qJjuUTKg3UpxNhJ7Hwv153fDS2kQ2tpD1jfGyFbECxcga68GkpxkGL1pR0y0WcLzW+S48eg=
X-Received: by 2002:aca:3192:: with SMTP id x140mr670980oix.172.1608075848207;
 Tue, 15 Dec 2020 15:44:08 -0800 (PST)
MIME-Version: 1.0
References: <X9lHQExmHGvETxY4@elver.google.com>
In-Reply-To: <X9lHQExmHGvETxY4@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Dec 2020 00:43:56 +0100
Message-ID: <CANpmjNO5ykmE5kWJ0x08-dTDOLe+Wu=2yQ0OmfdQEbQfHByeWg@mail.gmail.com>
Subject: Re: [PATCH] kfence: fix typo in test
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        kernel test robot <lkp@intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 at 00:31, Marco Elver <elver@google.com> wrote:
> Fix a typo/accidental copy-paste that resulted in the obviously
> incorrect 'GFP_KERNEL * 2' expression.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kfence/kfence_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 1433a35a1644..f57c61c833e6 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -665,7 +665,7 @@ static void test_krealloc(struct kunit *test)
>         for (; i < size * 3; i++) /* Fill to extra bytes. */
>                 buf[i] = i + 1;
>
> -       buf = krealloc(buf, size * 2, GFP_KERNEL * 2); /* Shrink. */
> +       buf = krealloc(buf, size * 2, GFP_KERNEL); /* Shrink. */
>         KUNIT_EXPECT_GE(test, ksize(buf), size * 2);
>         for (i = 0; i < size * 2; i++)
>                 KUNIT_EXPECT_EQ(test, buf[i], (char)(i + 1));
> --
> 2.29.2.684.gfbc64c5ab5-goog
>

This patch could, if appropriate, be squashed into "kfence: add test suite".

Thanks,
-- Marco
