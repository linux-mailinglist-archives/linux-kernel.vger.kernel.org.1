Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79E293BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406359AbgJTMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406224AbgJTMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:39:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E423C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:39:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x13so997592pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnygfgLF8jMqb/pqWEkYkyd5vX4PuOJ5AsXjq1S0C3k=;
        b=DY6DgfCcbCst8r9Iymwn9tp8rolyWYt7T5RwyTpTNjGgTRVKj6GVYdDJtviSU3RP49
         3rcEwq+x92rZaKaaMvIyHhSBh9zeR9ROeRwVfkwo8c8Od2WDOwKwiRZrpRi4M0voxUUg
         UwU8uhCFzHDpFUn4n5329jMOukgLinJQ1dHCd6lC+CUNXLZFPyyx8RdXOlzKqaUVo3Jo
         6qokjgixvqC4HVUr9JpDLTWzKLrwWf8gmY2/4unAFQoRsGzukr7zE4/QfYKnlaPsqN9l
         HxofoHXKYBWLRYplplYkQLiPubeLevkt67jcUBykCDs2YB5fMsly2J+0J24QBKoSvGdV
         mF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnygfgLF8jMqb/pqWEkYkyd5vX4PuOJ5AsXjq1S0C3k=;
        b=qlL+Cg8l0+YOCWCSXZAHCTSYAkLkcRKM8T2NM+erRMfrt3GTx4cTwEOZHFWfziCQio
         jbpZ5J9qcRQmG3A+VQ7BAenpNEPbBHtMCGdODrtoeKNr4BfJs4iKsIVcOOsLJirZECCM
         NCLR+mAjavL2vzWXHP8CicYaxwvOG/IRo2A2W49MqIbGZm9Ndw7mCOVI2ec4brKCX7D0
         2F5VAkrxRhEOVB7a8z64PlUi0lqWgKj0LoO1jwVs5ZZ6pkCXfW9ut9kRYORoo+TmepWN
         jsEsPfMFYd4lvD/2eZe2rniGpEm6bz0IY/8+DZYMUmv8JF8ATPzze3JwzLwwJ2S8EOpj
         yY2g==
X-Gm-Message-State: AOAM530Kd9hcQ+TWXQbeqbd+b5U9zWGNRl2G2MUQyl1ESmalGt1F+sup
        Ehx6eeWw9QLeSROjjne6tjUH+A9Jy13qXN6bRiZ+/g==
X-Google-Smtp-Source: ABdhPJyxAhXDeanE5yrdeLhRf+0+xOYpa0lxAL/vZbreBeA6Gc2c1euRRQLhOk7MNdCCPHuuDFpfayyTw/qFXtFcatw=
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id
 e16-20020a62ee100000b029014225013972mr2480974pfi.55.1603197575998; Tue, 20
 Oct 2020 05:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <001de82050c77c5b49aab8ce2adcc7ed7d93e7ad.1602708025.git.andreyknvl@google.com>
 <20201020062248.1966-1-hdanton@sina.com>
In-Reply-To: <20201020062248.1966-1-hdanton@sina.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 20 Oct 2020 14:39:24 +0200
Message-ID: <CAAeHK+wQWv7w9w2TgdvNFp_5KdjMF3+R1vLNDTJiWMZQ+hBbzw@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] arm64: kasan: Add system_supports_tags helper
To:     Hillf Danton <hdanton@sina.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Oct 20, 2020 at 8:23 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Wed, 14 Oct 2020 22:44:35 +0200
> >
> >  #ifdef CONFIG_KASAN_HW_TAGS
> > +#define arch_system_supports_tags()          system_supports_mte()
>
> s/system_supports/support/ in order to look more like the brother of
>
> >  #define arch_init_tags(max_tag)                      mte_init_tags(max_tag)

Well, init_tags() does initialize tags, but supports_tags() doesn't
not enable support for tags, and rather returns its status. So using
"support" here would be wrong from the English language standpoint.
