Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3F26EA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRBFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIRBFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:05:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:05:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b22so4217753lfs.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6mUxr+o/bBCyV21PhBy9xwq4Kx+o7EoQqU8t/ozEuU=;
        b=LAR1j2h0gElCIkPlU8F1qMcYFmqxHfKZcMuQJTE5hBIWM/sdoqNYy6WEWnMKSyhFii
         DaG10gEB6IHCkFTxf7XhMBA9O1m0l7KAbS+rPt4YmT1yohTQC8dXk0Q+8tQIN+DCc3Y6
         xJ3dHBzw7ljYGfemeNOEI4CHfeZdRDdNd1s2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6mUxr+o/bBCyV21PhBy9xwq4Kx+o7EoQqU8t/ozEuU=;
        b=BcdKMhbvXlNDLhRS/uCU/iB/prHu2L+UPjtvcdckoVBbEDNRlbXPyUrcQYmAzQsffn
         ux0ZSew1/6dGXVlC5wRnpltFQ5/RBT6ffiZUa/ahVMmioSmgPSF34MC+Ne91d57b140R
         No3ZdmmodylgfKZ/KsdbxwV8Pd4QWpumCCTVttm/JHBm/iTztJlCCetZdVWQKY9O8Ewu
         Ug2h7h4Xq1VZ4zZLama0GSX6WoM8XA++uzE4uI0Mzo6cZ3wmn0pKWSNlBorMdjrTXCgC
         tyBSEvqclKBfEiwVoVslyk3+bWsHkdyBlVtr4WfrI1Y3YY18qNEMBPo1L/SMZ0GGPAPI
         XgYQ==
X-Gm-Message-State: AOAM533u8LWBVLcml5hWjqOhT7mJ+bQZhvPXU4swb3IjE8zRHs56ZZ3K
        P++kGLl5tYQ/CZkD6J2eocqeqk0U3F4tiQ==
X-Google-Smtp-Source: ABdhPJzP1xLNqCbCQ5Rd1yiu3aXrUNcstXu+9DvVeyuQGf2uqTD8DmLS422Dpyj2GiNPZKZoiHjNrQ==
X-Received: by 2002:a19:4083:: with SMTP id n125mr9682406lfa.270.1600391135178;
        Thu, 17 Sep 2020 18:05:35 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w4sm240282lff.231.2020.09.17.18.05.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 18:05:30 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id b12so4233112lfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:05:29 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr10817292lfg.344.1600391129661;
 Thu, 17 Sep 2020 18:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200917204514.GA2880159@google.com>
In-Reply-To: <20200917204514.GA2880159@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 18:05:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
Message-ID: <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     Dennis Zhou <dennis@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 1:45 PM Dennis Zhou <dennis@kernel.org> wrote:
>
>
> diff --git a/mm/percpu.c b/mm/percpu.c
> index f4709629e6de..1ed1a349eab8 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1316,7 +1316,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
>
>         /* allocate chunk */
>         alloc_size = sizeof(struct pcpu_chunk) +
> -               BITS_TO_LONGS(region_size >> PAGE_SHIFT);
> +               BITS_TO_LONGS(region_size >> PAGE_SHIFT) * sizeof(unsigned long);

Hmm.

Wouldn't this be cleaner as

        alloc_size =struct_size(chunk, populated,
                 BITS_TO_LONGS(region_size >> PAGE_SHIFT) );

and looking at this, I realize that I thought we enabled warnings for
'sizeof()' of flexible array structures to avoid these kinds of
mistakes, but that must clearly have happened only in a dream of mine.

Anyway, pulled.

            Linus
