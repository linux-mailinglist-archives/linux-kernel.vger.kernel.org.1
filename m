Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226272C11B2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbgKWRPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733152AbgKWRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:15:06 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C9EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:15:04 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id u184so3068308qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kvBGtFT9p+lNN1wnKJ27cKqo+mVo01rfpUdq4ICcnCo=;
        b=LlizgBvVF6PIc8dJ2FLojBbEJZlK9COaX2vyuLyDC9PG/wNw623YnlNybC47WpFuiv
         PtYA6ubE3P7QBehYPVwSYRflyWgHrmkjugD+nCjHntymPepmKyLUTwugEfYW3Nw2P2SP
         hrxib78j7pTNqBYSvjBMrV4x4viFURYxEkgDpKYhm9Y92yo6qzxSvybp8ECcjZpITAZf
         qvC3hDeripEmGZQW/kh5aGtYhMpLHrN0Q+LEDhznEStp4gDxzc8nVB5YJ8yF6rmFEmEQ
         HmH6JVP9m7vwxphnbgUdVGbN4ebQq4wbUeA/lVItKFo6EAa2EvHcBZ7mmhOo3Tww4s3V
         OQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kvBGtFT9p+lNN1wnKJ27cKqo+mVo01rfpUdq4ICcnCo=;
        b=kpf7rlPYA1OfglvOvoRJgXw8jm74z6ki5r4BmQuQS2spKGqQLR7+oUuuS4uS+9j7L/
         3ThisOm0oQ9ZdSl0pSc2wBdfZAa2j+484WxZP32Wgc+ud5YoDSzuZvFJc+/CCnw2GjDA
         jqLG6SvHC09tyF7+DSJT39pRBrtgiEVG9kCyA0iOUx2PTI0kw7XAm7zfu+NzOidbFfrV
         04Of4O7IZRZycsLjzotnRBAcrO7QIbkyvc+wlpccytUmUa4wFG9JnmmK+ouKTH0YqGVW
         g46Is7PdVj9xDXtdLT3xbW8OdG+/Lx3mebWBJ2fH/DZcNMf/dVDgjlxx2xRrBTcMeJnt
         4spA==
X-Gm-Message-State: AOAM530RXWCdNIjHpmhS079EO7/IeXg33oPnEotMWl6PGSZR6W1XYqhq
        W5U5FU8nMYXuOHi5/HnDwpRJdg==
X-Google-Smtp-Source: ABdhPJzzfbE7crG1AGzIBt80F3rqZ7Bc00frJCBVtjv7Axg3xfzI1getpXUfvt7Qln7neCKN55RBtw==
X-Received: by 2002:a05:620a:ec2:: with SMTP id x2mr484822qkm.328.1606151704157;
        Mon, 23 Nov 2020 09:15:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z133sm10523570qka.20.2020.11.23.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 09:15:03 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khFQc-00A6rX-Ou; Mon, 23 Nov 2020 13:15:02 -0400
Date:   Mon, 23 Nov 2020 13:15:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <20201123171502.GX244516@ziepe.ca>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <20201123090129.GD27488@dhcp22.suse.cz>
 <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:06:21AM -0500, Pavel Tatashin wrote:

> What I mean here is allowing users to guarantee that the page's PA is
> going to stay the same. Sort of a stronger mlock. Mlock only
> guarantees that the page is not swapped, but something like

You've just described get/pin_user_pages(), that is exactly what it is
for.

I agree with the other emails, ZONE_MOVABLE needs to be reconciled
with FOLL_LONGTERM - most likely by preventing ZONE_MOVABLE pages from
being returned. This will need migration like CMA does and the point
about faulting is only an optimization to prevent fault then immediate
migration.

Jason
