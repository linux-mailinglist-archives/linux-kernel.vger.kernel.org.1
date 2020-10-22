Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B90295DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897562AbgJVLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503040AbgJVLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:47:44 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:47:42 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id q136so1381287oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQ90kVlYCVdEBMkM5DxKx4SDCKnOT8r71z3S9jFcYrw=;
        b=IM7WAkzCbG3CrmjDRgKySlMHcg6geFJubdFIFWTCLNiC8GRrLOINQiJkAxazsg/m3e
         NtbadpAkKWOZoityShtNKDMNNMojYHzBVBOGjXoDPT8fz/VxeyXhuj975FVLGc3yrAGd
         UosVRlVe4RlwuP54X+HtTDjVMgjK0zmsT6b81uwZLpo4I986t/DquxK84O63u67LHELe
         YtNExNaH2go4Rf3t7EHqyTYKgycFvkaINoI5+EdZ28L5dhoSZwqsvNe1G2385rscGl2X
         cfenB59KJMdLWxvB+bI7GkoEHCg6q3VQzInrw5tICb/iKe+bVT48ntkGE458EVdpUD9a
         /JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQ90kVlYCVdEBMkM5DxKx4SDCKnOT8r71z3S9jFcYrw=;
        b=oJrREl3MUjir2e/Vh26UhgAeS0T6AZoBEHErwnCFsPGO/RGO4UTKYLU1+HX3rAx9oI
         RHk1XhUkTDVwzDW07QgApeBhQU/tOdz2jYGvEuq73TdBvyUk3pHcVLxhhKqwpVuujW8Q
         xjbuXO1ZZMuU/sU1yrsHMQtjUIrL0SQejhj+25hi3YiJgO6Jq+hwRMLAPfsWGcgILEOu
         QJ1Jzhu7Hd/dmL3uBJFmMzygSH2TeB1loJxHmhwVIwLiqzjM4eddS3cKPgeqTs0Pe2T9
         2+5SGGvIRojlEI5dxW5enE6KiNazVuTz00WD8aYxyvs77t8tHKiw2Y0YeTSJOZP12pPG
         s7SA==
X-Gm-Message-State: AOAM530q6FFc9pmlNTHsF4M39xFG+pLWe8gsNHSMMQvmRHqaoyt0AZAU
        4OP21PjqrFqAc8kZra9rdWkihtJJRoe1ttpOZ34nig==
X-Google-Smtp-Source: ABdhPJxmpFmQgTIRq4q31XPII+xQ30HJzq4zt4cN745Z9s7nth4NpHNOLcKZCr3+JUdDJzv6QVG8MCLjAlSDf+GcGWE=
X-Received: by 2002:aca:6206:: with SMTP id w6mr1303294oib.121.1603367261918;
 Thu, 22 Oct 2020 04:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201022112956.2356757-1-elver@google.com>
In-Reply-To: <20201022112956.2356757-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 22 Oct 2020 13:47:30 +0200
Message-ID: <CANpmjNNyhPtb04np4bm6SgUyGfQaPt1RVb4ktjF3Uv=95NHxxg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Never set up watchpoints on NULL pointers
To:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 13:30, Marco Elver <elver@google.com> wrote:
>
> Avoid setting up watchpoints on NULL pointers, as otherwise we would
> crash inside the KCSAN runtime (when checking for value changes) instead
> of the instrumented code.
>
> Because that may be confusing, skip any address less than PAGE_SIZE.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

Please use the series at:
https://lkml.kernel.org/r/20201022114553.2440135-1-elver@google.com
which includes a prerequisite patch that was missing.

Thanks,
-- Marco
