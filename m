Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD32CDA79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgLCP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgLCP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:56:40 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA83C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:56:00 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so4119574ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gVQmR6ld/lYpsHK76ZuRZXd01EGXnxILe/SFcJOW2w=;
        b=eYNFtbruDro6dQJWGgCuegmzBpPQ1LahVDbKosAhd/jN2Cwudb8DQbTVXaBLRxfb8o
         Th0rdj9064ZJNEbCx5jr4Msx0qQ/j1MEUEcx9QPYlUlHwi5ei/IuvUdhJaTQ6GCeiOsb
         bgNNMQzUuNCxGp/71Du5NA7g2S+KmbGNQOgPQBG3hJuZAv3+qsUV8dCHb0ACSCH/q2Wt
         3gViBUy5WgJp1DegkcsSg7E0l5cJ2Ts+L3tMNDMRizt8WuSPT2YP9/0H3hEGjMTc+DhM
         LTynTdwdGRKYQ4jcKqZ56dTMgPnpUOdQTL7DVddSaI7TqFdTJbJYZxiCR2BZQzmmZTGl
         3OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gVQmR6ld/lYpsHK76ZuRZXd01EGXnxILe/SFcJOW2w=;
        b=tLonGLgDOMUopSd9wOJpb1jTPCSZV9Yj9OTxw8v/qKn1AiFEAN3X/saBTUHVLbkV7K
         33Xtaad3nibDgtE84Lo4Bmkcj++mUqy/xcP8x/VJSOSZW8uwWkmcycHoGYmzkvO5kAXs
         lHdRwAthroSXXmxh/p3BwhpsUvahNkTdXiIYlMBgdHW3iGSxn9tOWgNmZOmTAh02J0+I
         tXfyiSWBFkybJ3sCpfiys4fnScutd/y3S6b0SP/71ui0TzZARAvJW2i43gWYxLcKUn5i
         YRg+8bdkLKJe9arLYlyv5m3kc3EfQ/LRC95yEBXHrlLVoI2TXJoESX4R4pHfIGESALCu
         d8hQ==
X-Gm-Message-State: AOAM531MQQLwFMogM4XfwNx+RNFuo4+uBhinqRoqRf1odfATYaooVQS2
        5In9S+U/fM8u2p/zkXxWhhQVrfSkhb/LQXg7jm3J0g==
X-Google-Smtp-Source: ABdhPJx4jNqDXKZJ7ETQGpqkj49u2SxuSrzCLNoPj2MITdYbco0cQP8gTTPag0zTLJ3vffEXV31zz7RTpiFNDGjFKTs=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr2983758ejh.383.1607010958929;
 Thu, 03 Dec 2020 07:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <b44584e0-bee8-3f3b-f9e7-c1cbd981296e@nvidia.com>
In-Reply-To: <b44584e0-bee8-3f3b-f9e7-c1cbd981296e@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 10:55:23 -0500
Message-ID: <CA+CK2bD+8p6LJR=haaaAyXfMhpaZAB+_Mj_664qm_fyWm1iZRQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I like the cleanup so far, even at this point it's a relief to finally
> see the nested ifdefs get removed.
>
> One naming nit/idea below, but this looks fine as is, so:
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thank you for reviewing this series.

> Maybe naming it "movable_page_list", would be a nice touch.

Sure, I will change it.

Thank you,
Pasha
