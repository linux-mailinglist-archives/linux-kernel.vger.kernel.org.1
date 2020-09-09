Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C0263302
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgIIQzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgIIPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:53:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F9C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 08:53:17 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so3203874edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYTAx4l6f2u8KbHrEy5Rn6tgANLlely6K9NrAKkKaD4=;
        b=RfcRjolnslna7osjOO1TXCoghzNi2fKgyFZPEMSQax8YEU8v4535p5x6dM2zbOIX8K
         aGJX4vT0l4XB4cYXiNDKH+3JzRNjm3eijcTc7SfI9q1BpSt79VwY8JZjA17Leq2ZJjYD
         tOpHiKVDtUz2jt2C6HN0AItE24CYkZLmi72A1fJlHm2sL3JbaocWOehxQ156RbPQE4DY
         LBdCPb63BwhCd9tiQqsumCNyOc414IoPmrhnv6Dx6RngxPr4gNNW9DYbjhlC3gMkccSL
         0WNDOoOdeaTUr5BMaP0jEDoAul/y2Yq5eI7X8LXVuiR4Tsj+mAF5IlR5CJZySYjOgH/B
         gTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYTAx4l6f2u8KbHrEy5Rn6tgANLlely6K9NrAKkKaD4=;
        b=bBCGtyzeiRoXxi8nnYyYMm2Du8Ox8IhKedHRmHaXLLGgxGXotimKi16IL7E9s+fetH
         H8QQMN47GluI20NPFDoymJrX25ivgxMmmVeZTU08A6ObC0GJvaRVacaUvd/cNrjMAvD/
         YnQywxtuXVgRAPZffkt2mf6g9B7iBQGNtdN2dgFk6y0+NmiIJk7hErNEnRvTP71csxku
         f2XxBkcXFrrFWC+doTe/pEKsl9LyAEIuPgH/zGAtNUnXkiGklu/0CX80JVIcUqurWCEg
         nJ3q2dUQ+syrr/U5DMSZ4/LhEVhUjY7zutW1o4ikufGYNiqElHiMEb70SfEf27ejZu6E
         ZIkA==
X-Gm-Message-State: AOAM5313ZYR7RWPrTtmEHKT868aMCj8WT5FAryIi7ZdIveJS5XOfFsEl
        DrmUz6deoKiaBuU9/jABRlLJOuHars3DLSi/BauNykXCVdrmOw==
X-Google-Smtp-Source: ABdhPJw/klL8m+jTWg8TN2b2YPUs5PNhV2M3PAJmM/yRQZlC76+0uLWD3k61ammc5irNXocl1b/iC7V5ejqeyp86R9g=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr4647541edw.251.1599666793751;
 Wed, 09 Sep 2020 08:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904160018.29481-1-steven.price@arm.com> <20200904160018.29481-3-steven.price@arm.com>
 <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
In-Reply-To: <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 9 Sep 2020 16:53:02 +0100
Message-ID: <CAFEAcA_1YnBg3HVmtrSMP8u7GqHY8mtDAJwVcZuNUhwA+q9q=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: kvm: Introduce MTE VCPU feature
To:     Andrew Jones <drjones@redhat.com>
Cc:     Steven Price <steven.price@arm.com>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 at 16:48, Andrew Jones <drjones@redhat.com> wrote:
> We either need a KVM cap or a new CPU feature probing interface to avoid
> making userspace try features one at a time. It's too bad that VCPU_INIT
> doesn't clear all offending features from the feature set when returning
> EINVAL, because then userspace could create a scratch VCPU with everything
> it supports in order to see what KVM also supports in one go.

You could add one if you wanted -- add a new feature bit
TELL_ME_WHAT_YOU_HAVE. If the kernel sees that then on filure
it clears out feature bits it doesn't support and also clears
TELL_ME_WHAT_YOU_HAVE. If QEMU sees EINVAL and TELL_ME_WHAT_YOU_HAVE
is still set, then it knows it's dealing with an old kernel
and has to do one-at-a-time probing. If it sees EINVAL but not
TELL_ME_WHAT_YOU_HAVE then it knows it has a new kernel and
has just got all the info.

-- PMM
