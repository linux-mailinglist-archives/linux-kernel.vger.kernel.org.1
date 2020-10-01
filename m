Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA22803AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbgJAQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbgJAQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:17:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89FC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 09:17:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n2so6186750oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7z4RZb4xHZvdkDhdzGHiqdJ9avmcc+//+6dEVs9Wkhw=;
        b=HLHjU0Kuon8b0GM8tARWJSMK6NABhtf8WNgW2nf3koqCK8mBGpp7rhE3gcWkAglCu9
         bnX/O3P/ylSYBd75VPD/0dUnVOYb2HqhCykICayY8EGFOtx7K5+7U/ZnCVz/83cBh9F/
         TVEsiMrDJpRi9FPKphd4dJLOUVQ1E9+ukFgleTkcpnYCOLf0FBtanbLfZnXoF4Xn0nGZ
         1zVRxK6H6Ja1UjuZBXU1t/vAxI/KZSS/fSZxprO/FgCIdj5Gnh7kWhQF76a5oF0GWdjf
         F5XOSpT/oPmpSi9pfWF9zGXccvZ3HxCNUCgqFHUtDDIkVeqeIYlPYWv7BvfhEg/2NZYp
         tsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z4RZb4xHZvdkDhdzGHiqdJ9avmcc+//+6dEVs9Wkhw=;
        b=M3ygIGvGnpcCR33BLDc5haRKYeFU2Ed68NLUk5jFCRV+KaqnfNHwjO440arjgmI6FI
         4aj3WGgpudwhciAkZEXNl5SESqUT6V1N1jfNefJiRvqrgyro1ABERJwu1zgBrrgVvbl0
         GeoBSdB8GyPJemIqFCDJ0cLgeoa/27zx2Fq1q95PPyVOExTSrItfyqYDoCZQ6SAd0Mue
         rk9+2HRz6c/o4DwnOpCL2630bhivdwlfp/oVIIAmwBcfKEtC8/JbTITZcnzlxAmn49q6
         ah4BmhvpDddR+aSds5Bd8P+CFtvv2SYGWhvpQzB0U7Upw1Vdz7RI2opASIN85fk6r8Rr
         fBFg==
X-Gm-Message-State: AOAM532sVkPXb63ewPt9esds6i6CoqI2B+lU1pFECtljRFIPWRepm4GW
        hezN9NGqBOiJ2YgSzGrffJOyVMrycWRDl1IO9EU=
X-Google-Smtp-Source: ABdhPJzKVlVxbmrcE9M01GASsemfNIdCM4TOFqmm835CPdI7Vc0+hYTPTEnqy9IjIyR2jcBm4Wf9GBvDjq07pW69+80=
X-Received: by 2002:aca:4142:: with SMTP id o63mr420130oia.167.1601569061882;
 Thu, 01 Oct 2020 09:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
 <20201001123032.GC22560@dhcp22.suse.cz>
In-Reply-To: <20201001123032.GC22560@dhcp22.suse.cz>
From:   Sebastiaan Meijer <meijersebastiaan@gmail.com>
Date:   Thu, 1 Oct 2020 18:18:10 +0200
Message-ID: <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, riel@surriel.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Apologies for messing up the mailing list thread, Gmail had fooled me into
believing that it properly picked up the thread)

On Thu, 1 Oct 2020 at 14:30, Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 30-09-20 21:27:12, Sebastiaan Meijer wrote:
> > > yes it shows the bottleneck but it is quite artificial. Read data is
> > > usually processed and/or written back and that changes the picture a
> > > lot.
> > Apologies for reviving an ancient thread (and apologies in advance for my lack
> > of knowledge on how mailing lists work), but I'd like to offer up another
> > reason why merging this might be a good idea.
> >
> > From what I understand, zswap runs its compression on the same kswapd thread,
> > limiting it to a single thread for compression. Given enough processing power,
> > zswap can get great throughput using heavier compression algorithms like zstd,
> > but this is currently greatly limited by the lack of threading.
>
> Isn't this a problem of the zswap implementation rather than general
> kswapd reclaim? Why zswap doesn't do the same as normal swap out in a
> context outside of the reclaim?

I wouldn't be able to tell you, the documentation on zswap is fairly limited
from what I've found.

> My recollection of the particular patch is dimm but I do remember it
> tried to add more kswapd threads which would just paper over the problem
> you are seein rather than solve it.

Yeah, that's exactly what it does, just adding more kswap threads.
I've tried updating the patch to the latest mainline kernel to test its
viability for our use case, but the kswap code changed too much over the
past 2 years, updating it is beyond my ability right now it seems.

For the time being I've switched over to zram, which better suits our use
case either way, and is threaded, but lacks zswap's memory deduplication.

Even with zram I'm still seeing kswap frequently max out a core though,
so there's definitely still a case for further optimization of kswap.
In our case it's not a single big application taking up our memory, rather we
are running 2000 high-memory applications. They store a lot of data in swap,
but rarely ever access said data, so the actual swap i/o isn't even that high.

--
Sebastiaan Meijer
