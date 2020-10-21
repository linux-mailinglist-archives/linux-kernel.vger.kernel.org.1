Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8AA2950AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437603AbgJUQXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389934AbgJUQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:23:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E2C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:23:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so3837959wrl.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4m5OGqF4NPdHanEmTmPw4aLKvxOe0liWFVFEuW15OI=;
        b=Pi63MkxMK/0p7JPdtzSwLf/F0ZiDYyQ6EZ82YI7vR3kzyAnmAWqMjPdoewVU8iachq
         pGr0SdlqVs7p55tYLrA+md3rLUQe5N6Ix8n874fwo5FBsk9+krys+bRTeUz9Sz6j1DBV
         Z2pc3uMNBJykItTq/husiykGu9+/7TryQtiIVbbD1sqJOcoXNcrrrCcz8KwANvkn48iS
         Qd7LgZCnjoP4+mh3HoBEEfBQyAZXFVxCXmofLBS9ri6gryNWBIBY2n5uiXwXvXBzO85M
         QX7LxTTSz2m1NaE4TYZPovXZPKJo19bBMmu8Hnh1BHXaqFyNiaW2e8a0hm8mldPMmOgu
         Li+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4m5OGqF4NPdHanEmTmPw4aLKvxOe0liWFVFEuW15OI=;
        b=DMPjQRnGf0AfnXpBVUMh50xfJA+QhFPZyCD9P9y814krqIFJ3BSTvFoHq9WKjz/dXw
         aKojFmzMdwIVWUV43l2g4JwGn7iuGYTliH3iXb/wTAc5MTvy3m9qeT/kXVfcfS8VIdJG
         pe8cF5udHMmyk3+uoIeLl6fA8DjbMllOxrkpw1KF2KpBaZ2uh655mYTSZ6dFgWxpocKS
         KkeVm4sd2C7ipxiymchzWab/2dCZoXgEpfayZj7i2Qi1mwTgwadiCFcp2OUVkw/xI0ko
         jmgpFjx8NdSUNPxALc/T8c3NmClk5SvaFuvmxSFamclHsWkQl56kwL8/bT/xncmLuKGK
         NajQ==
X-Gm-Message-State: AOAM530W7mTZrESPj4l0M4RZD5yh02iSLYcvqUB4EaQvovOmIRgShCMZ
        bdC/gcSIc10ql2ik0ysoewsZGvZSClDJHtsHwXr4aQ==
X-Google-Smtp-Source: ABdhPJwS/j7TEvIX1nZSbzcgqjETbWAtuN5hHSbXzKpqmQNM8oG/TjZNa7SutWftz28x8UN1j69T+nCsFeIvmGiljrY=
X-Received: by 2002:a5d:6407:: with SMTP id z7mr6018608wru.271.1603297400876;
 Wed, 21 Oct 2020 09:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <54b2b36d-6288-3260-3426-85d7467ace19@infradead.org>
In-Reply-To: <54b2b36d-6288-3260-3426-85d7467ace19@infradead.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Oct 2020 09:23:09 -0700
Message-ID: <CAP-5=fUjjyXiU-T-Tq-4xbi35+9kNBt_yDc6SjA3xuwiNpQ0Ww@mail.gmail.com>
Subject: Re: lib/test_min_heap.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 9:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Ian,
>
> I was wondering if you recall why lib/test_min_heap.c has
>
> #include <linux/log2.h>
>
> I don't see any interfaces from that header file that are used
> in lib/test_min_heap.c.

It may have been there for test value generation in some early draft,
but as you say it can be removed.

Thanks,
Ian

> thanks.
> --
> ~Randy
>
