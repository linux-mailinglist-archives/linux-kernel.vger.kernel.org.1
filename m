Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9C27ED0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbgI3Pdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3Pdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:33:44 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C4C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:33:42 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id f15so594200uaq.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uO4l1Irl7Jc1Dt7f5WL2j3BxSE2iGdkPJ94cD3diLM=;
        b=LA4JYerDPZmq+2E8pGXpoAJ2R3R6DSDIFyoXhn37oGwuZ5e0jbNqwYQZruoOCXsvCI
         RShTjEmbsgKKLzzvoOOBIZaU/R7wbt7JatMDRzQvaaekkbfQcFSpULtcQ4A/cKq/vxaG
         FXErj58Js4dFB08C6gceZtiUM7h0QE6nd6OdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uO4l1Irl7Jc1Dt7f5WL2j3BxSE2iGdkPJ94cD3diLM=;
        b=T1TAVGEnjsDhObVj3Aow0kJ2ru7k4KESjwyEDW70r/q+scx/Zj1c05J1QpW58VyLeP
         QLhD+YcLPZPV+4mhg/F/9o5vy/7msXZ7dPwAOqm8KIQOY6weA7z2fUa6pixSHRR+DvNN
         aOpGZkQnta52eV7km3DKlCH2Lu5OUaHcYPMi9QuqKc/AAAregZ1BdJCQ/cnb6MgPVZ4d
         ynjZB5SBscGAmnc647i+x5YfywGHqx0X6k9UFe/aj2ZvT8hD+gJmjYION1thjzWf+d+g
         gtQHOYKTd6wVqx3RDMTB1WQgkURxAIlMsxamAkNKhEBL0CCo4KfTbXfzpatvsCHQiKWw
         M4Kg==
X-Gm-Message-State: AOAM533uy6gVxdbCRMRKvz5QXKRPP7I4qf77Eo0n2LnPfEmFnBksOs+y
        8u48Iycg1Uo/0b1vRihifYL5O2G921enMkLwoJcfIA==
X-Google-Smtp-Source: ABdhPJzyumaQn67a2uysWGSs3pQrDLQnwa3K/NizNBUQXsUBZVlCHdIlWthWT9umZ5q8w7kmZMHdnhq8Zg0vNAnpYNM=
X-Received: by 2002:ab0:6298:: with SMTP id z24mr2147413uao.105.1601480021939;
 Wed, 30 Sep 2020 08:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com>
In-Reply-To: <20200924131318.2654747-1-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 17:33:30 +0200
Message-ID: <CAJfpeguFZwkZh0wkPjOLpXODdp_9jELKUrwBgEhDVF4+T8FgTw@mail.gmail.com>
Subject: Re: [PATCH V9 0/4] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:

> The first benchmarks were done by running FIO (fio-3.21) with:
> - bs=4Ki;
> - file size: 50Gi;
> - ioengine: sync;
> - fsync_on_close: true.
> The target file has been chosen large enough to avoid it to be entirely
> loaded into the page cache.
> Results are presented in the following table:
>
> +-----------+--------+-------------+--------+
> | Bandwidth |  FUSE  |     FUSE    |  Bind  |
> |  (KiB/s)  |        | passthrough |  mount |
> +-----------+--------+-------------+--------+
> | read      | 468897 |      502085 | 516830 |
> +-----------+--------+-------------+--------+
> | randread  |  15773 |       26632 |  21386 |


Have you looked into why passthrough is faster than native?

Thanks,
Miklos
