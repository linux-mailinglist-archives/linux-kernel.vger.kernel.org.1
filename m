Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91C2811E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgJBMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBMB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:01:26 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C1C0613D0;
        Fri,  2 Oct 2020 05:01:25 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u25so1088016otq.6;
        Fri, 02 Oct 2020 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ibilTAtq7c7ViJ+NUjN/YiXyYNav9cZNhWApxQvHAD4=;
        b=oRCA71AdVYnUOTVk48MNBj1jb/RIQeaF9OwWEIFdwtbCq3sKZS5O7TwTucjI4nFqId
         TZioI3D5vkqWOrsC3jCDQtujEQlYRKZp13wW7VLj+G8oQgxabkALkRHgA7UByl6J2Bgl
         TD0DYG7L6ilSumfNFs/9ybbrL6f0llB3grYDmqBzbKCbFvk1m6lnkBbIr6RBO0nJjmFW
         VUYZNqhXc8N67IcH3CU7Vb05SXn/f0OxlQKG4XqhNLi0pwGkv6Epa19TyDw0ZKmhYY8a
         +qTu4BYKoSdxZYtJotsVDZh8KbWCySxkKvAYA4PhezLP5tkEsbnO8g2vkBDcPgLWvt5r
         6EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ibilTAtq7c7ViJ+NUjN/YiXyYNav9cZNhWApxQvHAD4=;
        b=MvaGlqJtLSitFI4yvAkIBwhLenI4vlcuxm7Sp5U7s7AkCyt693YN4OCHT48lLCQggC
         m49D998TG/xw27Kjjo0Gscui9ln85ar8eKdDKMPA2At+dDnRdWUEGbmpm8PZjiYAOeI9
         7hlWg+toqWlOrpCc9WHo9IHltGefJ3I9eOrb/uW6/0gc0o7g7pxh1q/jK8euzhiXcQLt
         eR4dO1Vs9wuQ9f898PscUEBsT8gTyiOnYB41xrRsy4ZONho5GSnf+BOMUuj8zi1zEQy4
         9AYIRA3qxkm215VJRBS40f28syx28XxWFCgv2IS/3UNNrIFBfEUh+Pnfsb9FiLcWTDnL
         wcaw==
X-Gm-Message-State: AOAM530anbU+OLIseuEqhJRfAuojMsY+HW3gW+zn1aHunYZlqYBIvK8r
        SjKHeFoskPctboG9fPH+rFWJ/+HbHeUZMkLr0Ss=
X-Google-Smtp-Source: ABdhPJx1r/kWpxsSsRe5Yh1mrr5jY9D0ECBN3nz+u5bagOSxvJeIuiT8smS1e3kp6v6rNvmb6kD/q3bNE4a/bGhs5ak=
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr1522386otn.9.1601640085321;
 Fri, 02 Oct 2020 05:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com>
 <20200930173719.GE2628@hirez.programming.kicks-ass.net> <CAKwvOdk+Rp0QGJmX07XxD8L7WVgco98LHFTu-R_2R22+UMVerQ@mail.gmail.com>
 <20200930.152652.1530458864962753844.davem@davemloft.net>
In-Reply-To: <20200930.152652.1530458864962753844.davem@davemloft.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 2 Oct 2020 14:01:13 +0200
Message-ID: <CA+icZUXjYTJO4cC1EAhbdqnd19HjAwyFM+iSTW37xJM5dFHQuA@mail.gmail.com>
Subject: Re: linux tooling mailing list
To:     David Miller <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, nickc@redhat.com,
        maskray@google.com, segher@kernel.crashing.org,
        linux@rasmusvillemoes.dk,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org, postmaster@vger.kernel.org,
        peterz@infradead.org, behanw@converseincode.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 12:26 AM David Miller <davem@davemloft.net> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Wed, 30 Sep 2020 12:29:38 -0700
>
> > linux-toolchains@vger.kernel.org
>
> Created.
>

I am subscribed, too.

Will there be a(n)...?

* archive (for example marc.info)
* patchwork url

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1170
