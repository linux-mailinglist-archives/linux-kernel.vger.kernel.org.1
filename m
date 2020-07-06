Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE412155B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 12:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgGFKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgGFKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:39:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BFC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:39:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so5906486pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puTM9R3OCUah22RUChJJRjd+zkSRZtSw3EsyABHeng8=;
        b=VfCMPwJFLQ5/ozMboU3NCR6LUp9lThjhLle8XQMRxQV8B4tYMFvbRAkYP25GdIa7f8
         ZcQ0cPF9bXuvs2NvRpUP7p48zKyYynRilb7Pys90DGroAN1zlQVUa+gBNDvF8nEPILmx
         R4BQzD1nWiWW9r2pEfHIXUU9sQhAuvwq0HY0+xBEP4t4JfVYwNCEHGvoxHvt2kZnvSqP
         wbogfdeYStGWzq+VwqW7Zi6iecLTnWHTuniAs2Z42RPD9f65q6GjzayGF5lBl8qd5wGK
         /jHDyTUdg0T1HjxS2z5MN977yQMkQVJolci3o36Jblajpd/9OLpHSkcNGUny6YEC4RVI
         i7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puTM9R3OCUah22RUChJJRjd+zkSRZtSw3EsyABHeng8=;
        b=Jm17nf01Zpq+5CmpfU5HyK/5Kf2HvKx9F+zbtCD9sivf62s1yjw0yLzHiC0RtFqKNJ
         pyqK2FYN5QdwfINa9JFU01lVBD7b7VCJ86eNhHwvJdW5eUBOPMBRe/dR8VfzL5Uu8Q3c
         PcRqCVqQOuLgLPEMDHJUldlgP+wilH3SqMR/8wg7nFSLYfqjgG+Amhus7kB1ZjBLG1j7
         6dh9Yxy4PL/BJHmyJDpx78xpFJCSOa7srSPXLNjQsz/yyjT/rQHqCe/UfiD3H2pB2f1c
         nVswpTNheIJZWEBl0RymtPk0DI6dJtEjggzWVLIW7+3VmMQMTp0NFqShHFf3uJ72TT/G
         xhuA==
X-Gm-Message-State: AOAM533Wq5C8SeMh2l+f4w7MrXTHP7tcuBdzwMZdyd/MUNzpz9aWOttg
        WqTHBCMqtd0XTXHkG0rqNebfewdLSyEV6rlkKf4=
X-Google-Smtp-Source: ABdhPJzQEGKwwKvWdvmQDbELYbMKvGuUhUlgJ/NROER/RbrYqSnqxvHXNemOSyNJd7M5Ck3HMqAarmf0D7+yZBhDD3M=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr25285213pjb.181.1594031965778;
 Mon, 06 Jul 2020 03:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200706095100.19157-1-geert@linux-m68k.org>
In-Reply-To: <20200706095100.19157-1-geert@linux-m68k.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jul 2020 13:39:09 +0300
Message-ID: <CAHp75Ve49Ucy9nMy1UBYirWX2niJ=6tfEGzmD+DpfRgb=JdZAA@mail.gmail.com>
Subject: Re: [PATCH] lib/test_bitops: Do the full test during module init
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 12:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Currently, the bitops test consists of two parts: one part is executed
> during module load, the second part during module unload. This is
> cumbersome for the user, as he has to perform two steps to execute all
> tests, and is different from most (all?) other tests.
>
> Merge the two parts, so both are executed during module load.

Does your change prevent you from unloading the module?

-- 
With Best Regards,
Andy Shevchenko
