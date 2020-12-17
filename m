Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987DF2DD5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgLQRNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgLQRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:13:12 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:12:31 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id n18so9430110ual.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lc21cq0ymggpuStIBav4pWq/h6ih3KgGZXha7oGAj9I=;
        b=xzgq2RDmDvQdWkRXgZQeLWKLHkZ2GVoPk5BNc12QN79DNUAN26PsKWuWZG+Z0JZLvo
         uXrBKH8ftZvNRDx+o4HYqmvTP+X49sFM8Jn83MHS31LoGfvAqu7gB1Zhl8pzDdNrs45a
         874rDmw4huPKXUChuOIq2h8Res2w3pbLqHnZICNHpaPHxyAo21fz3//qMlyeewXVesMl
         /nj7m3yyQrXlxDceF//kFWW/zQ4dacFpQRNhqI6psUlnrfZplugzeCNp5voJgS+S6JO8
         LwkOe0sLwu0SvR45RkNWP15upO4bsoDAGDpc8AmBnaogXjOhho/Mh/jVDemCdp96toad
         7DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lc21cq0ymggpuStIBav4pWq/h6ih3KgGZXha7oGAj9I=;
        b=EumlsTg4H3zd4z3opWQgpDfB/YlCwM4R8xFMPuabOEZtd4g3BLviz/9N3enD441b6i
         /kpkYL2gC2B2SYg4I4ihYWHk3O5B+3WZKn233evwg9TFB7kq3HVwoV1aM6g6Ls3ollHo
         3AWf0bXko2gKMjXWtzJ9E/5Jj8MPqoR34aHzlWfa+AUrQmvZYglqE+hN5CscYBQ5M383
         +NaP5nuqcN1aFfrFPiHIXY1hxnp+TpjCRVnHw8TOQDqyzfDHUqKa+5La8xxbgxR7ZtTa
         ngV6iqZVrmEYLjOuDAk9nuig8uZzwY5r1Uld1agRiuxLFM5zsujNqfV4whJ1xBoxZjHG
         0ySg==
X-Gm-Message-State: AOAM531DfV5LNHQjIv88yRoAMY0aWimJJqBdX+iRAxFAAn+6du1/Zrxq
        tHjlHOTv6UTRuaEKycfBXr1XZGqTml7X+DDO8pSpkQ==
X-Google-Smtp-Source: ABdhPJxsrjSgmF6i7SHQNyLNx60nOHm4gQJBNrgSBnDWWv1rsZIrt5HMWv8RROwO44wXNX2R+lqGG/p1bar838U25l8=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr10422527uam.19.1608225151200;
 Thu, 17 Dec 2020 09:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com> <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
 <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFoWh8Ms3hqgWwkQgx2a9PZa+GLcYhgXX68K0ZC5JJAzHw@mail.gmail.com> <BN6PR1801MB2068B9F13F0E21BF726562E5DEC40@BN6PR1801MB2068.namprd18.prod.outlook.com>
In-Reply-To: <BN6PR1801MB2068B9F13F0E21BF726562E5DEC40@BN6PR1801MB2068.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Dec 2020 18:11:54 +0100
Message-ID: <CAPDyKFoSr72bKd3qzYi9QZT5L3DewjEYjRExE+V4XmdiqHLkXw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 at 12:36, Bhaskara Budiredla <bbudiredla@marvell.com> wrote:
>
>
> [...]
>
> >> >> An extra check can be added to see if host was runtime suspended
> >> >> ahead of panic write attempt.
> >> >
> >> >What if that is the case, should we just return an error?
> >> >
> >> Yes.
> >>
> >> >Moreover, even the device belonging to the mmc card can be runtime
> >> >suspended too. So if that is the case, we should return an error too?
> >> >
> >>
> >> Yes, same here.
> >>
>
> Please comment if returning error is sufficient here or
> can there be an attempt to wake the device through either of the atomic activation calls:
> pm_runtime_get(),  pm_request_resume()?

Hmm, I would start with playing with the below. mmc_claim_host
supports also nested claims.

mmc_claim_host(host)  - this will call pm_runtime_get_sync(host)
mmc_get_card(card, NULL) - this will call can
pm_runtime_get_sync(card)) and also try to claim the host

Kind regards
Uffe
