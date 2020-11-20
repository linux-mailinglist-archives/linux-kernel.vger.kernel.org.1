Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213C22BB157
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKTRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKTRWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:22:35 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:22:35 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p12so10818555ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJiWiVz3XEtfB340YUAxHz9Jx4tPyL7hwJbDeBWMeWs=;
        b=heQNRa8Csj3E6NB+Q4DRQwoPU3qvq+xUHSFkM0rXW/zURKVwAFjN9NhCXh7h+Ta4Ru
         KDZeTPcH+DxVEEpNfAMX3DRMyI3g7UoPnL8IMF9TX4W8gqPWmwLA74ehMcm04Ose0d/I
         08qolcsQpT9+dZhzyfD/ezfmvRVT8wkY//17I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJiWiVz3XEtfB340YUAxHz9Jx4tPyL7hwJbDeBWMeWs=;
        b=N0OozIX6g7Wdeygcp86TuUWW1MQ7GWtwGzvAQIC1Lj3ni2dKtixkyRYpq4jt0eBUzs
         Iq+3aMAUIkqSJz4+rKRwvsaR4zvF6ti/gxMZoxXsAY+4ryCbY7Zp/SowIisdRoo9rVsp
         RxIJ4idtklOApL3tZGXCOrdCNu1Jq6GwEW4RfPAphd9yV9JM4DMTzAVfImtBjRzMlPuc
         ECVl/xSbN8hTc98fDxQW8CsUtDS45Ilcr61f7bW8xRk5z57tTi/SR4MoCURUITG10D5v
         pCvib5m1gEfyKU/zYRFwUF5vHRY2yvFEoK7mrRg4MJdn8iZbQp1pjElrMmZIFziWe/m1
         Sj8A==
X-Gm-Message-State: AOAM531SjO7pvVr5qC4PAlBKJaxTiYusFf0L9LsDeJqKgD8XqEeRU4AJ
        SsjsjI9IS2+gxN1fGmRBuN0dFqLsEnhtzw==
X-Google-Smtp-Source: ABdhPJzlXC91Gv1iJc1qfd2jGFviTuJKlaM+6lS4Xsh9PZ9afKIN2AplabestKarvItE+WKO0kROHg==
X-Received: by 2002:a2e:8098:: with SMTP id i24mr8579631ljg.152.1605892953297;
        Fri, 20 Nov 2020 09:22:33 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id i187sm336106lji.24.2020.11.20.09.22.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:22:32 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id s30so14544492lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:22:32 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr7896957lff.105.1605892951907;
 Fri, 20 Nov 2020 09:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20201120143557.6715-1-will@kernel.org> <20201120143557.6715-6-will@kernel.org>
In-Reply-To: <20201120143557.6715-6-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 09:22:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghWFQCW83Xr16C3q+y5xZNM9frH4V9AqauedMEJ1V4wQ@mail.gmail.com>
Message-ID: <CAHk-=wghWFQCW83Xr16C3q+y5xZNM9frH4V9AqauedMEJ1V4wQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 6:36 AM Will Deacon <will@kernel.org> wrote:
>
> Introduce tlb_gather_mmu_fullmm() to make it clearer that this is for the
> entire mm and WARN() if tlb_gather_mmu() is called with an 'end' address
> greated than TASK_SIZE.

Ack (but with a spello note - "greated").

          Linus
