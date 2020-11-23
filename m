Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E992C126D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgKWRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKWRyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:54:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:54:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q16so18009719edv.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuMYUJdtH/2nxOl3I7w6Zr/wW7lBFGJLSxs8ekU48XU=;
        b=EZyroN8QsWMlG8MTbc4cEihy9jePh/EDRLIjidMYCh0AaOGMIsSZ+OIATwGTb7DrBg
         B0Y1wY8pXvHBi6kX0TuUMi2Fdaf8/jL0YYRk8gQBTf34tAYfi7wTZVQbICJ6erlFoTnn
         gInq2VWGc7qr88/qrPaiO2j8C7HaCasgFulEZuWEY+s4HTf5C89bIQH2CuSqqzHDwZLb
         SW1ZK7U1VKG+c+pTLi3qwYcop/T7aXkxdii36ISw06hkxzwkbqUfwSvgdRcVscA/1F2K
         HXzrUVMZ0qTJB8usXug7XfUu9DDeABr7dCAv3/Yq6EpSpY2b6FOKz09hxaYomrGi6hPi
         VJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuMYUJdtH/2nxOl3I7w6Zr/wW7lBFGJLSxs8ekU48XU=;
        b=bQITNgf+zK036dCUSYxjMKNbTr9HoNdI58V1D4fy8lrC3rpbU7brlJ9VF4PWoqOULQ
         z4h7dsjl0IEfQvnCWhKRHUXcMV9zwkhD3562Ff693CzxMaus8fFhUfE7kA9sVPt4k3Qf
         wjMoqMtynyMtvi4b4gt1peTjie7MTFcvhl1RfUC6aqBD0YmDpm7AWT60ApKtx58dfH5W
         FHXHQbZh5FmGEpNk8yzgnV1cjPpN9rL0fVmtjP7D0KqEWzRC2V11EpE0uxuhk4D7nmxo
         NOAbYC6ZNcrGktTi+7bsqAJujfsaWd1aSw8j61KSwaTyF33MLLIZNiNpxcp+B603je7Z
         Rbqg==
X-Gm-Message-State: AOAM531pDKSDu/e3VX/bB+hDLIPcAbb9bQXlngI1/JBZkYDuSS6EUwcj
        MLpFLpgjhIvS2T9jh0G0XkfZF0t5efycNzrCfAtkbg==
X-Google-Smtp-Source: ABdhPJx9togWcreQZq9uZt2NQSkdTVSANgXKGsHDuOkAlNfI9HveEvIYQVujmi34Dwt3OzWxuuRhLbvrCyUCRDN8+Jw=
X-Received: by 2002:aa7:d54b:: with SMTP id u11mr309610edr.341.1606154092463;
 Mon, 23 Nov 2020 09:54:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <20201123090129.GD27488@dhcp22.suse.cz> <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
 <20201123171502.GX244516@ziepe.ca>
In-Reply-To: <20201123171502.GX244516@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 23 Nov 2020 12:54:16 -0500
Message-ID: <CA+CK2bDx1Q5QWw=hXMs=OWwCSVrFu-xizY8YOR_MqLsvMAZm0Q@mail.gmail.com>
Subject: Re: Pinning ZONE_MOVABLE pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Nov 23, 2020 at 11:06:21AM -0500, Pavel Tatashin wrote:
>
> > What I mean here is allowing users to guarantee that the page's PA is
> > going to stay the same. Sort of a stronger mlock. Mlock only
> > guarantees that the page is not swapped, but something like
>
> You've just described get/pin_user_pages(), that is exactly what it is
> for.

You are right. No need for the madvise() flag at all. (The slight
difference of being able to mark memory pinned prior to touching is
really insignificant).

>
> I agree with the other emails, ZONE_MOVABLE needs to be reconciled
> with FOLL_LONGTERM - most likely by preventing ZONE_MOVABLE pages from
> being returned. This will need migration like CMA does and the point
> about faulting is only an optimization to prevent fault then immediate
> migration.

That is right, as the first step we could just do fault and immediate
migration, which is silly, but still better than what we have now.

>
> Jason
