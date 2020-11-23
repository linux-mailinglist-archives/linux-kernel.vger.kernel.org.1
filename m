Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023F22C136B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgKWSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgKWSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:34:22 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51855C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:34:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b144so3404438qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1u1sy4wI1CG6DZFHVu5ifgXp/o8YW2xyOy2wIPWsfUg=;
        b=gih3TBU2ie34aPD8GCBnr1hlEWJpANCJd1L/9e5q6wM6g+ySzsAsQAkZeX5ov0bm8w
         KMqGD2zqx81lskimJnNbWmiTfCUUH6V6jfRnz+RYqcsGIDgL+0BgOk+8BQ3zc2dgAbkX
         rm2QbI1sEI16WUkwm4BhRtfJkKA3OWLu9si/MKlfvUaXUekcsf3+iI++DV3ZhOfCd59z
         C8P60qh9BjLwDE4nOsf4L3CDrVjlYUdZ9vFSnY+7pMSSeEqky1SG/4txkpavUjNXUQZS
         iubB+g078hid8l+LWwEwpfH7l5JQjzSnu65jBT+60rf46aLEzD5Kf5G8050vlyTy+aBi
         EccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1u1sy4wI1CG6DZFHVu5ifgXp/o8YW2xyOy2wIPWsfUg=;
        b=uBfnr3116iVW8zfEj5oo76AGhV7Npdbi8r7wPhoki3jDbONjm/eO8zGHCSvXPHo6Ot
         tzW/uP05gsO4kiJOdlgdYVSe03qPoYnQAe702II09cLl5PkunqQLj0gfwHs9aBpmeiKa
         jV0GiSOld4uJbboAwrrfgj/uyHwj29bNUTPQQ0+mNZOM66mETDrxIEjofEAYfzpqLpIN
         LVTXsD3Og7tvEO2Kv+dPKX//7l/OFg6WJJqGxm102ti4UE08ICmL4WG9HSvBvQItBbBs
         MQjh2LWPcOdIYTHCA21vpV/IhQyiNZL/fu+GFTwV/sWUcw1pA+SFVknD/VMcjmSlQFM4
         WgvQ==
X-Gm-Message-State: AOAM532M1ETWgaALrmnz1py0t6i0n4ggdGxgt0r7gJ7UG38Yf+t0pSP2
        +3vFlhB/AIXjgQZGkYeL3Anhnw==
X-Google-Smtp-Source: ABdhPJxC7o5Vri3XQELAZq9SSztQKpp5Dk2Ag9BZU5OCfm9BfrhI8Xz3WzsV/EejngMWbFSZKb34oQ==
X-Received: by 2002:a37:45c6:: with SMTP id s189mr813608qka.472.1606156460610;
        Mon, 23 Nov 2020 10:34:20 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x21sm4956921qtb.14.2020.11.23.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:34:19 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khGfK-0001k7-Mn; Mon, 23 Nov 2020 14:34:18 -0400
Date:   Mon, 23 Nov 2020 14:34:18 -0400
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <20201123183418.GB5487@ziepe.ca>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <20201123090129.GD27488@dhcp22.suse.cz>
 <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
 <20201123171502.GX244516@ziepe.ca>
 <CA+CK2bDx1Q5QWw=hXMs=OWwCSVrFu-xizY8YOR_MqLsvMAZm0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDx1Q5QWw=hXMs=OWwCSVrFu-xizY8YOR_MqLsvMAZm0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:54:16PM -0500, Pavel Tatashin wrote:
> > I agree with the other emails, ZONE_MOVABLE needs to be reconciled
> > with FOLL_LONGTERM - most likely by preventing ZONE_MOVABLE pages from
> > being returned. This will need migration like CMA does and the point
> > about faulting is only an optimization to prevent fault then immediate
> > migration.
> 
> That is right, as the first step we could just do fault and immediate
> migration, which is silly, but still better than what we have now.

I was looking at this CMA code lately and would love to see a
cleaner/faster implementation.

If you really understand how this works maybe it is an opportunity to
make it all work better.

Jason
