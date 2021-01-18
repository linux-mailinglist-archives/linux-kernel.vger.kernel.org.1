Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D586B2F9D38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbhARKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389867AbhARK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:29:47 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEE9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:29:04 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id n142so18213402qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYvmTRg9VE7k01lzg0q32naiEw2p5pLxGQxdorBtVnw=;
        b=ITpteuLdN9P2EM3yXBkYiVxnmYQMTkkGuDqMEf7PJD5obNPhZMUIx9QnbqttizFGoA
         CJOYybtXOHi0lKFTL3lz++jy2oG1qgwZxuJVLIIZMd4hBtJjSNk6oCfpIv5g6t/AMTYX
         D7vjc28T8Y4qeQHXotzVuXVg7VetKM1FRaLqGfiDHi1z1Zv4KvOYq/TgfJKyQviXK03r
         CtNa6T2zVCD2Ml9t2eWkkQCJg/ZQDKeMmjype/aNpRicSXq8ewTCe5Nwjtr0wBYvfB+M
         QBuQGkXgAsk9q49xiVUi5gpC9w5w5tTCuHcF6yWUnvIyjg02l+BNkfzMriwmpNqzaZcH
         OiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYvmTRg9VE7k01lzg0q32naiEw2p5pLxGQxdorBtVnw=;
        b=pij6eaZlsjhEUNyWBWLFKIrhg2nYrgKNiqUYe2WLWEmsQgVIPbmJyKQXtlf1pie+xj
         SZyh+LSP9iJdWzZcFnLlKFfJMhBE1ZvjLpkLtsacw/eNbfSHGhhs74NEmx9N0CCQMHc/
         sV+FTV5+90q2rgNRZ5IpOjjfnleoVPwKI2Ka7HMXCZ/mi/GvldnNv6GxYBuer4Z0wdaN
         wMy1j+WJ1FCPlBOtB/xu701U5PlXGnd4b/+v6yGcJqojKsnDX8c2KkRs4k/I2/xIbGW2
         l8T+PtpXJsUWnnSAKBp3a9MQ2YiqZHb3OQM1b6CR9atEHOLdFsPedNEukr7kAIURvhNf
         +VtQ==
X-Gm-Message-State: AOAM530AqmznR0b4AJlwc+hxfY0X2bDjoOSVSs9AcTSNHL+JfQQAU3kG
        HiR5TsaLb4Pz6TOLF3EbF6wewa0QEjJfi0e350R4LQ==
X-Google-Smtp-Source: ABdhPJwBtnK8SvAQyF5oxlYc4Br2Xlsuy6W5BMKJAts6RASYaE3KPSjaXbcRteqqb7fgWeyoK7KsR2qBMpzcozDmmDY=
X-Received: by 2002:a37:9a09:: with SMTP id c9mr24291484qke.392.1610965743584;
 Mon, 18 Jan 2021 02:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20210118092159.145934-1-elver@google.com> <20210118092159.145934-3-elver@google.com>
In-Reply-To: <20210118092159.145934-3-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 11:28:52 +0100
Message-ID: <CAG_fn=UXo-o5HvwHtLi_axC8YzCmhjByXT9Xn9k0PAQ_DyPw9A@mail.gmail.com>
Subject: Re: [PATCH mm 3/4] kfence, arm64: add missing copyright and
 description header
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:22 AM Marco Elver <elver@google.com> wrote:
>
> Add missing copyright and description header to KFENCE source file.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
