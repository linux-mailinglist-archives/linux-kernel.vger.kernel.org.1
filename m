Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3112F8DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbhAPRKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbhAPRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774FC0617A4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:00:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w1so7420608pjc.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CFvZTpCZJzYQ5mYlVxp5BmoY9i8eIizwAZi0uxfmFQ=;
        b=ZE2gHlbTLpV9XCSVPFeiGYWGKbVTaIn8eW1EI3CnMFm72GGvIk2CQeoThnn0RDVQub
         M1bDe4jmEMd+fTlLo02Fb3A8s23IrQNge7peswlkQ2oFVk9uNCqFvXLl8DdiWsQZgQJO
         b+DzCG8Nuitw1aURrXRQbiX57vK/jzKdXQWOQOqB54UPcdf/oYJOqp62tjD+9B9MxSXS
         L/C0aSon4VMkoojYfBSL7mB2MzG2vVrMC6EocvwQoExJoWGQw/wYtMgzfy3ewYARLgQd
         uQzC0Gt8lPTMVIj3jTJ2NJ2jhi/5JcQW0xttfLK40670Lol12um39kQ7WUcPjAetwv55
         YkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CFvZTpCZJzYQ5mYlVxp5BmoY9i8eIizwAZi0uxfmFQ=;
        b=W/o7Onc0e/bCRYUWVhu335KE/fVuj7lwhJqsEhcG1btCx0Sws4Qj+MsaC+e54HgPMT
         oe41TXaJg0S7NXLfYKCKYNq5iThcCqmoAfojsQIraQATvyr4FvHhf8HqoHgUAB28Cnry
         y23TUzqsPlnaygWmbvdGHpZsDfgrE949uEHxU4q1iXiptt0yQBdCb+vFFIuPuow4ZLa9
         AmA7ZTTpFc6HIfNwFf4gXU4wKhqIwMcUst2JOdmBd3hGFdNoO2V+kaI49wE+bkz23XFj
         0DBFFpFVky86CYeEuHqpnuQPKT17PDXpKN28jSQK7B7x5kJly5uEfmw8zpWKWIAHevRX
         m7tA==
X-Gm-Message-State: AOAM5321waMEjTBcfTt13xiljxHjn9v29amRkJT/Mh9d2xiSbq9r4TgG
        kNZFLPNWmfK/3j6wPfw6vl7VC/HGD82aqw1P/PkdWg==
X-Google-Smtp-Source: ABdhPJwNk6jAYnzK+W+QTRlSs41oyMLK0dWdqIZ+nD0HxlsLQ1jGw17exP26luLBaxP7jhUXaIY3lkoyNC0c96TsNvo=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr15763146pjb.41.1610805600760;
 Sat, 16 Jan 2021 06:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-2-vincenzo.frascino@arm.com> <CAAeHK+xt4MWuxAxx_5nJNvC5_d7tvZDqPaA19bV0GNXsAzYfOA@mail.gmail.com>
 <4335128b-60bf-a5c4-ddb5-154500cc4a22@arm.com>
In-Reply-To: <4335128b-60bf-a5c4-ddb5-154500cc4a22@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Sat, 16 Jan 2021 14:59:49 +0100
Message-ID: <CAAeHK+zsY7zdkj90K2zgXOScOj1WbackfBPv6gjJ77SfdzDi4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 2:37 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> > [1] https://lkml.org/lkml/2021/1/15/1242
> >
>
> Thanks for this. I will have a look into it today. In the meantime, could you
> please elaborate a bit more on kasan.trap?

That's what I call the boot parameter that allows switching between
sync and async. We'll need one as we're dropping
kasan.mode=off/prod/light/full.

Feel free to name it differently. Perhaps, as kasan.mode is now
unused, we can use that for sync/async.
