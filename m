Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5E2B3EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKPIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKPIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:35:03 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97639C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:35:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v11so12299663qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym4xSRuAu4rLOMrnZ+nG0o8cFYo3n4YWrOLq86Ly3eQ=;
        b=VfqwXe9DcHIh7IvAKsFD2iC9+kbnpybWPLbVQ1R/lUajR2xgcBn0b1DYGrkbIdnSiu
         pEv4nKI5BJZGG25B8wH0CAm8ZpwdsOReC9LWexGMtvJ9Y3C+nmTRxV54z1sYeHUZp34x
         tYL72rX9MVDNCDmBz32Qa3Fy2iEWqQ0LtwvYLZGxkn3nCQ114mvlyeQCwy8hycazVL8u
         Qur2d0i/EB5ktUXVXu4rx/vuc9cuE+ABHKgPcG5RWxy1Vzz/JU4WbhzJ/jfPYbNhMiQa
         33hMFixpZ9RgNF87+fSAkJFCXVRvN0lFJdNKAxxQh39TSmQVY+nvZ4TjuiSskQA72zDX
         2beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym4xSRuAu4rLOMrnZ+nG0o8cFYo3n4YWrOLq86Ly3eQ=;
        b=qpcXhXJw1YKGedOlLJLNjQi1N7bNd8KalYvV4TC4L5CwrJCHgUs7cZhUjLE/j8STtc
         /jv7O+hhztsA6NSTmfF8OBxJifboyuB32K+q7lyK7ialgNeILIQZjQ85VoYY0WgxQCX8
         i5PWLxF4j1OFKmK2gipbuMC8oa0wXUwbHJ7Tv4ttQr4R2NEUwUF0BiaEZp1ScxSiGhwx
         7FiPVBjHSrCgeTDKLSjxOU02Sc7C7iYbFKBHMFPIz1uX5t/BjvuNF5pbwJlR0UanSdZx
         SOTnHWUPoCUpC6lvFVHFgPMH4EExFC9juWzw2A1e3sS+FuS57P1LNj3pvbLSMNltlKEH
         ADFQ==
X-Gm-Message-State: AOAM533IOKn2af784ffXtTR6ddptDBhGdd2WJNdLFOmdZdCp7xZ1d5uP
        HK3F6Vh6dlSm8rvgHqNFtPgVP34LpX9XhZezvfGetA==
X-Google-Smtp-Source: ABdhPJztW0l4vsJzn2bVe6XRYEO92mrk6rGCuf9xyeYYpvwtue0CT3/47nFZHRO6y+9jkXhxv9FspwgGvw49h+FiXCY=
X-Received: by 2002:aed:2744:: with SMTP id n62mr13520025qtd.67.1605515700574;
 Mon, 16 Nov 2020 00:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20201116023846.awjtbzh2o2yj4fvn@mozz.bu.edu>
In-Reply-To: <20201116023846.awjtbzh2o2yj4fvn@mozz.bu.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Nov 2020 09:34:49 +0100
Message-ID: <CACT4Y+bh_QfSNVKVE=zODNKL5_8RLdcLf-j2ky0FJE_1hUi_hw@mail.gmail.com>
Subject: Re: Collecting both remote and "local" coverage with KCOV
To:     Alexander Bulekov <alxndr@bu.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 3:39 AM Alexander Bulekov <alxndr@bu.edu> wrote:
>
> Hello,
> I'm trying to collect coverage over the syscalls issued by my process,
> as well as the kthreads spawned as a result of these syscalls
> (eg coverage over vhost ioctls and the worker kthread). Is there a way
> to collect coverage with both KCOV_REMOTE_ENABLE(with common_handle) and
> KCOV_ENABLE, simultaneously?
>
> Based on the code it seems that these two modes are mutually
> exclusive within a single task, but I don't think this is mentioned in
> the Documentation, so I want to make sure I'm not missing something.

Hi Alex,

Yes, it's probably not supported within a single task. The easiest way
to verify is to try it ;)

It is possible to collect both coverages, but you will need 2 threads
(one just to set up remote KCOV).

Unless I am missing any fundamental limitations, I would say it would
be reasonable to support this within a single task as well.
