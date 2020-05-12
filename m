Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2F1CE97C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgELAJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 20:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728309AbgELAJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:09:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F16C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:09:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w10so846819ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+GIuNeS/zRhNXv8DWJcBs5sdIAbLbnMHoFTqitLrys=;
        b=Ak93banedsJMiV/GLzQObSSQW5MNVGozwtSadLdbb2llutUOeMawnVzTXwPyZMhdn5
         zotibDunSZiYNCo1pURopX//M2oItuHBRSCOe5QbWLnCSD0k+LJAL7kMlmILXXDpJpO1
         SUoeWuk79IlnBSAlPr/pRc1vZh5tqtqot+UYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+GIuNeS/zRhNXv8DWJcBs5sdIAbLbnMHoFTqitLrys=;
        b=NjwXGFygqBj8ZxoCBI9IjisNDd/vmke4PfkW4iCK2w7K5r05UKJoV3XypgoolSrDdm
         jBuxvbYTEkYSvJi4rqvno9tH09U2UilLjW4eTMcvJ4brxEtH6rYRlDCiu7mLJaTL7L8N
         Tsyl76IRBKsVMqzJvnYSVZe1WhOIvI3Zui4s7SXE79o7wRlQRnHT5wjKRhPi9B7E+iC8
         nUhqdVKWVadH+PAkkVBDHVsbdeR1IWZhNgCuGN0uMK6s12rXq8IYGb5Ty5yWiUEyX7wJ
         Uxyt108QbyMa/XgC9W3PjrmyTT2RsmD/rKnYF6zTNtfyJewAlLfBWWXkdNRwm1BQg2G2
         nmUw==
X-Gm-Message-State: AOAM533EBqzo5SswSuMNd5FXA5PsUa2FMWPqsi92IJm3PJPPNf/aO+Dp
        zwuDF0HnPi0Rm5+hcwkwzvniiWoAtlo=
X-Google-Smtp-Source: ABdhPJyIvZ6NIGWzQxcs3GRLdcTvL7/kmQXEdQrFWObDgg/Hg/RIHs3Fnnfael+PgiPAavbDYwpEZg==
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr11580712ljk.93.1589242177934;
        Mon, 11 May 2020 17:09:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id k22sm11381938ljj.85.2020.05.11.17.09.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 17:09:37 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u15so11593970ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:09:36 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr12584970ljj.265.1589242176533;
 Mon, 11 May 2020 17:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <20200511215720.303181-1-Jason@zx2c4.com> <CAHk-=wi87j=wj0ijkYZ3WoPVkZ9Fq1U2bLnQ66nk425B5kW0Cw@mail.gmail.com>
In-Reply-To: <CAHk-=wi87j=wj0ijkYZ3WoPVkZ9Fq1U2bLnQ66nk425B5kW0Cw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 17:09:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioWmE+Xy+RfVpc3q9EMh4NhqPVvWZp5=GqtoU6nZfxcA@mail.gmail.com>
Message-ID: <CAHk-=wioWmE+Xy+RfVpc3q9EMh4NhqPVvWZp5=GqtoU6nZfxcA@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        stable <stable@vger.kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 5:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Not inlining as aggressively is not necessarily a bad thing. It can
> be, of course. But I've actually also done gcc bugreports about gcc
> inlining too much, and generating _worse_ code as a result (ie
> inlinging things that were behind an "if (unlikely())" test, and
> causing the likely path to grow a stack fram and stack spills as a
> result).

In case people care, the bugzilla case I mentioned is this one:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49194

with example code on why it's actively wrong to inline.

Obviously, in the kernel, we can fix the obvious cases with "noinline"
and "always_inline", but those take care of the outliers.  Having a
compiler that does reasonably well by default is a good thing, and
that very much includes *not* inlining mindlessly.

                  Linus
