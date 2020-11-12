Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213F22B0949
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKLP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgKLP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:59:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF27C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:59:48 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d28so5658256qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4jCOmZMfeGT0TXCdgSotnEbRECtZNT/yP78oj9y32ro=;
        b=adOBV9vUMW+wa1UMSZKmUYiV+rRIraVU+W5WWTyE15tii2COEt5s1IccjYh1mY68A1
         Ek2ViBTLYQtP26NJ6VsCw1klYQV31enkWJKN+c/YfingjG6AUCv96mPFnOGeox1ZHAmW
         MHwH0JThb7lG2U+iN0lNrZm8MDr2F38wRUtYQspHYauZi2+z8X4JdZF8XZsfMtUgKK7p
         DA72bQhzJ7w3OqFOeob7Djpkdrnte3cjSrTLKfEZrInICmbqH29lckCpdFBPdEyR6ODX
         B5QEZWZRwqNh0h24KKbrONYuBL0Kv2knueSS6yhaQIvh0g/O5EUef/EUJascFIZhHWGN
         QG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jCOmZMfeGT0TXCdgSotnEbRECtZNT/yP78oj9y32ro=;
        b=MFjgclCod0ByOewVevS8qP3AOk7c666KOHnyMec2NqZ5z6MzXy3K/AACdGAdfq7b61
         jRjdrVwhEMAeE9S22UE4k226/gXc4mFP+kxBs/7TJwrZHdUmiEQm+eUft7DARpFZ0Cya
         8kBk5aCTEZ338PhnSErG7rc0x+pQds3Y+cpCa06GGmdlYMgkt6FyonbzcZb5wPk7NFlW
         XoK7Qg2C3092CTAq/gLURP6H8lskuTstRsRwEyHGAXdJMRm+dRhyMaxPQqIk+VRPl0AI
         zM714a6lP/lNvS6RK+A5hoQXfZQVmyHDZOFFlP6gHVsQdI8udl63EYZi0WxOIJ6P8CHn
         VXGg==
X-Gm-Message-State: AOAM533a7RMo+wI4oqASXYoSJxcCOLS8SEHrISJbFdnjPoDcZvsshrA4
        a5ZzrtZ2ijIbEuQoCSkAKEAOt/AfIyAmDgbkWydZxQ==
X-Google-Smtp-Source: ABdhPJxFf5p6ggFclyyqMlQ1hU/zZuctmzK10pHxDVC/fJWkQ5dzeaoAwVmoVkHpC44DejNUOBKtMelXFEBJbwtznj4=
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr441705qkl.352.1605196786695;
 Thu, 12 Nov 2020 07:59:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <bd6825832c0cb376fc68ad61ffec6d829401ed0e.1605046192.git.andreyknvl@google.com>
In-Reply-To: <bd6825832c0cb376fc68ad61ffec6d829401ed0e.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Nov 2020 16:59:35 +0100
Message-ID: <CAG_fn=XpB5ZQagAm6bqR1z+6hWdmk_shH0x8ShAx0qpmjMsp5Q@mail.gmail.com>
Subject: Re: [PATCH v9 44/44] kselftest/arm64: Check GCR_EL1 after context switch
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> This test is specific to MTE and verifies that the GCR_EL1 register
> is context switched correctly.
>
> It spawn 1024 processes and each process spawns 5 threads. Each thread

Nit: "spawns"


> +       srand(time(NULL) ^ (pid << 16) ^ (tid << 16));
> +
> +       prctl_tag_mask =3D rand() % 0xffff;

Nit: if you want values between 0 and 0xffff you probably want to use
bitwise AND.


> +
> +int execute_test(pid_t pid)
> +{
> +       pthread_t thread_id[MAX_THREADS];
> +       int thread_data[MAX_THREADS];
> +
> +       for (int i =3D 0; i < MAX_THREADS; i++)
> +               pthread_create(&thread_id[i], NULL,
> +                              execute_thread, (void *)&pid);

It might be simpler to call getpid() in execute_thread() instead.

> +int mte_gcr_fork_test()
> +{
> +       pid_t pid[NUM_ITERATIONS];
> +       int results[NUM_ITERATIONS];
> +       pid_t cpid;
> +       int res;
> +
> +       for (int i =3D 0; i < NUM_ITERATIONS; i++) {
> +               pid[i] =3D fork();
> +
> +               if (pid[i] =3D=3D 0) {

pid[i] isn't used anywhere else. Did you want to keep the pids to
ensure that all children finished the work?
If not, we can probably go with a scalar here.


> +       for (int i =3D 0; i < NUM_ITERATIONS; i++) {
> +               wait(&res);
> +
> +               if(WIFEXITED(res))
> +                       results[i] =3D WEXITSTATUS(res);
> +               else
> +                       --i;

Won't we get stuck in this loop if fork() returns -1 for one of the process=
es?

> +       }
> +
> +       for (int i =3D 0; i < NUM_ITERATIONS; i++)
> +               if (results[i] =3D=3D KSFT_FAIL)
> +                       return KSFT_FAIL;
> +
> +       return KSFT_PASS;
> +}
> +


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
