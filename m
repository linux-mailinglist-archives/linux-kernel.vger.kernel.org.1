Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A317E2F9D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbhARKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389895AbhARKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:30:52 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CACCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:30:12 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d11so7238811qvo.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbkyeBFzYjwcxmtCDsWtL2PYj9SLKn4d8JmpXs8sh3E=;
        b=tjNg4zLuiHYKUmMd9wTCaeYjPKYuz406OIRlULLrGG4LazqZOb0t0msKpGYcBCISCv
         2FWHP4XwEbGMVvmCDAeIK9aLIechdZLu+Tv2eAbRkaEby34bZL6ftTltFXmb7RBmJCr4
         IKxWe5/P7YxZBPWGCNYoif5ExBAguUno/+sqJlagBau7qMHtpGvZAknWV3+yoa2HHtRg
         J7I17NhhITAtaX6B9K3ldFfrCoLAmNQVraaofWQsyG3gUZ98TjfK7/G4j3aDrf6UYELn
         5yMQRwxxZay+CHAE2TtnJsr82g4EMksFBkPUHWJOlxzjsAB+HFeNLI/oyNYkOaMNXrwU
         HADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbkyeBFzYjwcxmtCDsWtL2PYj9SLKn4d8JmpXs8sh3E=;
        b=QymawAtVENFwiHjrP1DJ3uqoFPedSV71Vsg14zSiW7xyUvoBIR3fIjMLr1Y5X/s6xL
         khxRbnT1T3BGSMl8qGxi8emxlYiBSQI8tcL2LgP3uuInn1KRHI9aIEJjlJW0/0s6dSQE
         ewd9ylC5RZc5UxH27A5SqDjzLMolJX+v10HQHzQM1LWOAEUB3TmWnacsvTa/NbV/k5wJ
         YDUq8fb8Ems2HfSxX0snjKlnAN1LDWVuPcJbMgkR1CKdqI/aTBI1ooFGlO0os7IeJCB0
         FTDt8u1bdwuShBDmMsm0I0QZeyXmaMSfu1OgZ3ohSJmxFduuq2gG6UcBUZiC8rZHZE0f
         +yPw==
X-Gm-Message-State: AOAM531bOIZnuHAXe3HK2mFowqQ3XURxJS3h+3VpCbXpmBGvURc2DQ54
        mlqxCgTWlaDh+ZODhzedbjj5W8ZSnFthqd5DgmiYWA==
X-Google-Smtp-Source: ABdhPJxNVfHpqGRcpDo0ubVe4rRwyWUYKLnwqkKYqdlGuBDjJFMMWUgIXNeUBFEout8H2TogDE00I7zqlHVcEFS34oA=
X-Received: by 2002:a05:6214:1511:: with SMTP id e17mr24033003qvy.4.1610965811211;
 Mon, 18 Jan 2021 02:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20210118092159.145934-1-elver@google.com> <20210118092159.145934-4-elver@google.com>
In-Reply-To: <20210118092159.145934-4-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 11:29:59 +0100
Message-ID: <CAG_fn=W6vHmFs+FhCja_4XkSOUqkWTGOrw73=YY5Rz-O=SpU9g@mail.gmail.com>
Subject: Re: [PATCH mm 4/4] kfence: add missing copyright header to documentation
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
> Add missing copyright header to KFENCE documentation.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
