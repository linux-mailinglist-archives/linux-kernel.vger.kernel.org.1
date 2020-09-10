Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2A264F26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 21:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIJTgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgIJTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:36:01 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E2C061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:35:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l17so7500327edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5g2VKT0NX2V9vUtFME4ZGEhrr3w5KhEAQNj+WuBjkQ=;
        b=eRaklC5d1OINOyJjswenVydz4ubWff2ZOHUDzyUYBYlhwIvLhATs7LPbmS8S82Z4lp
         dBBLs23oLG1A+i+tpvyMGegBDoBUu7NJEunvws8RCEl+p7/XPm3dFQhGLP+zwto9hZ69
         aTuANMTAwk4X7SoipEiYWxdEojWxpdVCrajzFV5zC/15j7GkeIt4P6Jdj5IAwzERgxWN
         ZzLU6B3a+nGAnbO9O6LclWovDfKhopwc3XhQQFjROWvXdnV2bLinzSsSbbGj/O/R6ge8
         /TDkuxc9tcNX0yee/XK3UWd/vTfdgi+Ld7e39taLQmlJQPaajw1F4ds4WpnQlTzke6W7
         lE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5g2VKT0NX2V9vUtFME4ZGEhrr3w5KhEAQNj+WuBjkQ=;
        b=HGptNBRK32r90da8CZtu6hoLiIKWHtf+5pRN06cSqdcUXQG4N8xcFDVyX0S43zJdwA
         qHOFbPHYkTgXyx99NspguLJdIZXWI7+ajOemr+6nC4s91uPblqpogdD8MmV8ZfqEXQNk
         uUjOzKPuGmblsMmjfHwvmm2g3IgsSO7cU+nW9dWAmuhgsek8XowKLlKoKskX/OFRwDQw
         AVtI26XVwQpYpiCp5uijfgfgMJ24sLM+x4rMPlErHys5X25Mj8YLsVC/jFquRIybhqpW
         4ER7tExnmoVar9I2io7qLTGzAHsHXtFrVYD/k9vxZLZB+1TNwG8+OzRWB/PT9Cy0nHn5
         NF8g==
X-Gm-Message-State: AOAM532qAGth+ro2vn3gaRjIJupWsr6wZEHbg2ufDqProgKFC3Yv6Sm/
        dqhGro9WLD4d+1oB1+wz6eAdkfbuwKjrrBIJeiCXtjUolw8=
X-Google-Smtp-Source: ABdhPJy8lW8ACRd6m8wxRF741QmPd/9at5g6mpJsh4fXdHopAzzHzh6/Rlsqaq8CbAwrVltCpTGsysH1d6lOYQ8FkEY=
X-Received: by 2002:aa7:c554:: with SMTP id s20mr11006793edr.230.1599766548307;
 Thu, 10 Sep 2020 12:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134802.3160311-1-lenaptr@google.com>
In-Reply-To: <20200910134802.3160311-1-lenaptr@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 21:35:22 +0200
Message-ID: <CAG48ez3x51kkDt19ONXbi8Se+2swMgwfmaj7AFbBqmss=D38Ug@mail.gmail.com>
Subject: Re: [PATCH] sched.h: drop in_ubsan field when UBSAN is in trap mode
To:     Elena Petrova <lenaptr@google.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:48 PM Elena Petrova <lenaptr@google.com> wrote:
> in_ubsan field of task_struct is only used in lib/ubsan.c, which in its
> turn is used only `ifneq ($(CONFIG_UBSAN_TRAP),y)`.
>
> Removing unnecessary field from a task_struct will help preserve the
> ABI between vanilla and CONFIG_UBSAN_TRAP'ed kernels. In particular,
> this will help enabling bounds sanitizer transparently for Android's
> GKI.

The diff looks reasonable to me, but I'm curious about the
justification in the commit message:

Is the intent here that you want to be able to build a module without
CONFIG_UBSAN and load it into a kernel that is built with
CONFIG_UBSAN? Or the inverse?

Does this mean that in the future, gating new exported functions, or
new struct fields, on CONFIG_UBSAN (independent of whether
CONFIG_UBSAN_TRAP is set) will break Android?

If you really want to do this, and using alternatives to patch out the
ubsan instructions is not an option, I wonder whether it would be more
reasonable to at least add a configuration where CONFIG_UBSAN is
enabled but the compiler flag is not actually set. Then you could
unconditionally build that android kernel and its modules with that
config option, and wouldn't have to worry about structure size issues,
dependencies on undefined symbols and so on.
