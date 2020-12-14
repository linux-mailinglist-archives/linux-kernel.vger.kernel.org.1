Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268C2D98FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439991AbgLNNg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439600AbgLNNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:36:46 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625CCC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 05:36:06 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b64so11464315qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 05:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aSX7SZ34+utf+RIxSxOaDvrohcjpjOIx1rXwhtSGUWk=;
        b=Q2T0WIutJ+KnkQ+kPpVS+ZXIFPM3+uqjlwRi8rGHuCOgdnFgixHZ19jaapgZQZc4dv
         mM5s7muH4dPGs7c+Mc561ekdxd1Lcl4wPLt61CbpAcNC+ysA1jsmE5jOHS3oFjn2yHQQ
         6qrOfyeWdRRgxddLFOXs9tUa4ktfbX9cceFJWY5Am+H4E039f51JACknkU694TI1ctST
         xWzDMsQ/nkTd3OAsHN0sWnMXSdKwkRv0dIPmu3YiyP6cTqRbNogWF/SmmM7Nb1vPQpG5
         jquwiq7zL6pY1whY6t/ZEpaDoM9GTK7YTs6eiRgLqiPNLERLMeUDP1CZDOA0Nu5x95ZH
         lrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aSX7SZ34+utf+RIxSxOaDvrohcjpjOIx1rXwhtSGUWk=;
        b=R6UULCeMQ8jPmYaHrY2YWbrkFs2m/8qYgtejhu0GnrCzzBqxW8OYh4fSBK9ySdmNGT
         dc0OSdpgGJZkLbzN5nuHi1aDYO2BsuprKimVoR9A3EAyeNh3TVVRG9RJrL8HZ7HlFBSx
         q0XqxEN+ZrbJnTF56SOIbWDabftsRXech9/8bj/tmw4t8HZmuYaFNtkkx+mI4ec/5Py+
         NmrJRxOpT1Bv8t3bQYHuUc/Fi/AmA6kHzHielESY0wUjkZcdvLa/3NDcV+ubshwMm9ka
         pd30L89otSM9r0pJM63n9Y0pBWKBCxcONAOB7BLTJFc6xJAg9knNEYYefRqsF3kF6TAK
         /Zzg==
X-Gm-Message-State: AOAM530SrPCegfwSvNLhrYQTc0Eal3IX4fcPsNwyY8Cg9QZRbPDGuooy
        U9IgB1Xgqr7v7uGHchseR3UnNmO1G2CTpw==
X-Google-Smtp-Source: ABdhPJwX7KgX9z0LpyhrKrmdAXAQlfWjO4BubE1fX04pxg+mf4spVzTLz9Tp6Y4EKzZ14AjqLFu/vg==
X-Received: by 2002:a05:620a:95d:: with SMTP id w29mr31337314qkw.147.1607952965645;
        Mon, 14 Dec 2020 05:36:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id i17sm1366425qtg.77.2020.12.14.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 05:36:04 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1koo1D-00AHmi-4n; Mon, 14 Dec 2020 09:36:03 -0400
Date:   Mon, 14 Dec 2020 09:36:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201214133603.GF5487@ziepe.ca>
References: <20201211235005.GE5487@ziepe.ca>
 <2D10D596-3159-483C-81B4-CD187806ED46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2D10D596-3159-483C-81B4-CD187806ED46@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 08:29:11AM +0100, David Hildenbrand wrote:

> > Racing with another GUP in another thread is also not reasonable, so
> > failing to isolate can't be a failure
> 
> Having VMs with multiple vfio containers is certainly realistic, and
> optimizing in user space to do vfio mappings concurrently doesn‘t
> sound too crazy to me. But I haven‘t checked if vfio common code
> already handles such concurrency.

There is a lot more out there than vfio.. RDMA already does concurrent
pin_user_pages in real apps

Jason
