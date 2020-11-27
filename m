Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBE2C6D09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgK0VzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbgK0Vxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:53:31 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:53:30 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so8932819lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gsiey81k8cDOQM+mj3b3JNwGZB94I/7Rb8Z0uInJpXg=;
        b=fZeoWSDlbaaCaIlRt0xyf59srp3H2MK3FxnukZR3t/nMMyfQqQ5hZwbZRCfe5yqo66
         roYxyLD/+NC37WEA+pod5zCYu0q4668ohY8T1lnzviXKDQneJXpTQxh/C47XunP20Aff
         dOlT5BV54b/PzezOPbePMz5+KOpHsKzyC+a+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gsiey81k8cDOQM+mj3b3JNwGZB94I/7Rb8Z0uInJpXg=;
        b=lF7Dl4J9SpDoR9yk0RDfD/fdPhuGUCWuydq1UXo2ngVZCWWh/+3cTVjKpe3SZd0VMm
         7SzWiSXo/y1ARnuwrDrglRSYuIawy3EYbqHK36wBzraO+EfTtJ8cmhLAo+LN5/SkpZcE
         sXJcD+eksnIsJ5hnVMjTlvamWebWJu94qlqUJIrsIyMJ4wR/Uk46pv06VaRVQQ+hCTqA
         EZT36XRdlWIWbywU3BqjmSQRfzlKUe8lwCo5LVnJ4Ix8OCcGTOp1UAxZ4X2sz5dsK05V
         mi11lwM6/e3b4ByhSwmMZyDxXXyHHm5Naw8o5Wk+mK7TRFMFgqxvQfjYIJ/QcAAUMKC7
         wRWQ==
X-Gm-Message-State: AOAM533o4TrJLbYdhChzEulUf7e8QlFmT66nN6s3tXaTPEARltWCpunh
        /6imnQ7d94pzTQso7qBRTEsb8fU8lZHyNQ==
X-Google-Smtp-Source: ABdhPJyAKaMvEkT1GN6kng50hvQPx5CM+IzcmsioTspzwKXvAggYjlCPHaeZAOQzrXaV9dMH6Lzh3Q==
X-Received: by 2002:a19:42cd:: with SMTP id p196mr4461618lfa.228.1606514008520;
        Fri, 27 Nov 2020 13:53:28 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i6sm863421lfo.70.2020.11.27.13.53.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 13:53:26 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id r18so7405269ljc.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:53:26 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr4594670ljk.102.1606514005721;
 Fri, 27 Nov 2020 13:53:25 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
 <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com> <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
In-Reply-To: <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 13:53:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
Message-ID: <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 1:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh, this is a red herring. It's "make" output being misleading, and it
> just comes from the FORCE keyword.
>
> And no, those don't actually change the end result for me.

.. and that red herring was what made me think that it always
recompiles the 'conf' binary. But no, that's not what is going on.

profiling shows that it does spend a lot of time in the compiler
(which was the other thing that made me incorrectly think it was the
conf program getting recompiled every time), but it looks like maybe
it's simply the cc-option testing that causes that:

    33.68%  cc1plus
    16.71%  cc1
    14.75%  ld
    11.36%  conf
     7.51%  sh
     7.21%  as
     3.01%  gcc
     2.44%  make
     0.58%  mkdir
     0.39%  rm
     0.33%  gcc-version.sh
     0.24%  collect2
     0.23%  cat
     0.22%  grep
     0.20%  cc-can-link.sh

Oh well, I clearly misread the problem. Maybe 1.5s is more reasonable
than I really expected it to be.

                  Linus
