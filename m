Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571A023B195
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHDAMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHDAMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:12:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36311C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:12:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so21391155lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJMGz9Kc8WVCp/t/OHF9s3yH7VQ2GD7HHPuH9GhBwQs=;
        b=W94vDVEvD6RunkvlHbkEgBD1oo7wrZKgAqzHxEZ5TGmSkPoskFLl0lduJT1bLMcylJ
         i1qFErpOiOciZfhkkPxUK1SDkfZzxdgDygWPfoKVaHB2rsGxxYYshcNghQNuDF7TETgY
         /NnTENgvzaGKZn83r2WPrXJssI/dZzbilP2+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJMGz9Kc8WVCp/t/OHF9s3yH7VQ2GD7HHPuH9GhBwQs=;
        b=JIaAcbgdnsvQbjSqhmiuzdetUchrztHdxzl4ttKRWiMi2g5/Z2oTumkjJ626jBZ4pN
         xvTcxv8Wntib7eLLXrxV4ZvBmQHncy4oasDG/ggneaBjEgcHz82VOXKkozwWwQpHmWPN
         mNGA2Cyd3Ctx8Szs1sdecPGP7OvglRdCL7wm5m0Y0Grj3Tv/X9QX+g4neJe24cZfg/1y
         PcIn7YEp5qbV1fRkSbBszDCJtMfyjINjThO4UptRwxLj6UDxti/ftUvc1Cobydu22Ak7
         nyRuUG+qU6hT3eMpOEYaR6HId6/S44GAqq3Zci0W5YJ8mf1bh9n3cZtE99LoColhmm4c
         wUDg==
X-Gm-Message-State: AOAM533tn0WgplHLngI8bMqLQm8yCwA263KjG3H2QDj7zJfJvlXwWV2Z
        Jfo0MrJiQKoowiZnPkikt2Um8DMhLUI=
X-Google-Smtp-Source: ABdhPJz3XakMB6rWITnAzgK4J8GoQtE16/RRExG7GuNXaK8YaijTVWHafkv9zrXG340LCiLLnYG8tQ==
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr9283668lfb.196.1596499918148;
        Mon, 03 Aug 2020 17:11:58 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i11sm5463288lfl.31.2020.08.03.17.11.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 17:11:56 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m15so20731105lfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:11:56 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr9791274lfp.10.1596499915813;
 Mon, 03 Aug 2020 17:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
 <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
 <cd478521-e6ec-a1aa-5f93-29ad13d2a8bb@kernel.dk> <56cb11b1-7943-086e-fb31-6564f4d4d089@kernel.dk>
 <025dcd45-46df-b3fa-6b4a-a8c6a73787b0@kernel.dk> <CAHk-=whZYCK2eNEcTvKWgBvoSL8YLT6G0dexVkFbDiVCLN3zBQ@mail.gmail.com>
 <af6b61c1-e98e-f312-3550-deb7972751a9@kernel.dk>
In-Reply-To: <af6b61c1-e98e-f312-3550-deb7972751a9@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 17:11:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0RHwerxA165qshpyET4WgpmrTU7pqxzEaD4J74Y3uww@mail.gmail.com>
Message-ID: <CAHk-=wi0RHwerxA165qshpyET4WgpmrTU7pqxzEaD4J74Y3uww@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 4:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> What I ended up with after the last email was just removing the test
> bit:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=cbd287c09351f1d3a4b3cb9167a2616a11390d32
>
> and I clarified the comments on the io_async_buf_func() to add more
> hints on how everything is triggered instead of just a vague "handler"
> reference:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=c1dd91d16246b168b80af9b64c5cc35a66410455

These both look sensible to me now.

                  Linus
