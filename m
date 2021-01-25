Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7D3036A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbhAZGga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbhAYO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:29:42 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F505C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:28:21 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z9so9750948qtv.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gqrob1newlkQ15lRtU6auZ3RzaABmYXA8xpX2IglXFQ=;
        b=dGX57SKqFdpXq5Em8dpxESukUDK+OYiiN20VisCm8Wi+VFYCGEzLwzJQYwF1wsuX7r
         WjZJwHEvgvYAc4oAicLOOCAwPegzkAoCSLgLXVDWCGsrbRKY+vMoGhqIDIm/qcF3wyoX
         b+hwihpHfWpDuJsB4/bB0oipat6DwE7Oql4xR1XMqYNVs6VvbUXm35h4WKvxzkvcdadX
         kUDDTyr/b3yOo8C+AyPndWjFIf3sK4ivPmbG2qSZvbKM6s6BdVRmMkx02qk4qz5cKkBh
         0E5bdtMqcDbzuKXs/tLLt3dvNzJfdlDzLp1x5LEheVzj+HrgZHJimVBItPJDW19vNXXO
         8y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gqrob1newlkQ15lRtU6auZ3RzaABmYXA8xpX2IglXFQ=;
        b=g2ecFhJq9hh+KNWQaTzkip0QvRJZvhMdQ8N93NBUkTZK/HtT/DMBuKOylq6EvBuVdD
         dpIBvi/Sks9SH6eeALdu0j2D9WB2QAuC9ErEBPbJVNkcWh3Lywyp65CopH+8hVeFIri3
         M0wkLrXTxzJL01Aw2oq2H/q3pxQQ8G3EBiAdtgWDpHgtsUbJcEbpTMlqM4YXzrvQ6Cr0
         71I/WmlDqpeacNHZwS4Ylu9Sxxf/forHRPaSpwEAlCqQM2/RrDlnkmMzWnCiNRhBlBGH
         7qsp00uxnYCSMaHScTXVMeRA9I86gC67ZDFtHsbjLCGjbpStheFpkk64IB+ym8vxF8N/
         B3jw==
X-Gm-Message-State: AOAM5303jFZXcAKAfgQiZZZbRqmWiLC2nWyB+w6MHwmwgly6eTus4UR+
        9jkAAZxG8r3pS/rFPPqnlHdfEw==
X-Google-Smtp-Source: ABdhPJzF2m7RRft4yyKJebF8jzkPIF+Jv8HIYEWXVMaMo2dw3cdqZZG9ubwMIkYD4CRazbEmFlt1hg==
X-Received: by 2002:ac8:6edd:: with SMTP id f29mr654427qtv.213.1611584900594;
        Mon, 25 Jan 2021 06:28:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id m64sm12086816qkb.90.2021.01.25.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:28:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l42qp-006Vxe-HI; Mon, 25 Jan 2021 10:28:19 -0400
Date:   Mon, 25 Jan 2021 10:28:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 08/14] mm/gup: do not migrate zero page
Message-ID: <20210125142819.GU4605@ziepe.ca>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-9-pasha.tatashin@soleen.com>
 <20210120131400.GF4605@ziepe.ca>
 <CA+CK2bCu-uWWOxS_sPhfgzXTq-cqYFsHK_QFo7F+rStKpJJDRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCu-uWWOxS_sPhfgzXTq-cqYFsHK_QFo7F+rStKpJJDRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:26:41AM -0500, Pavel Tatashin wrote:

> I thought about this, and it would code a little cleaner. But, the
> reason I did not is because zero_page is perfectly pinnable, it is not
> pinnable only when it is in a movable zone (and it should not be in a
> movable zones for other reasons as well), but that is another bug that
> needs to be resolved, and once that bug is resolved this condition can
> be removed from gup migration.

My point is you've defined the zero page to be pinnable no matter what
zone it is in, so is_pinnable(zero_page) == true

Jason
