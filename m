Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AFA2D679D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393596AbgLJTyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393588AbgLJTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:54:16 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8ACC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:53:36 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id z188so6079783qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kpO1u5hzYEH5V8S5yxIwbQt0kkL6XU1TzxqvExx1i4k=;
        b=ERm45IL/CRSJ7ej7ihQMRlmsjMj0UWbObRchoUkR0DpqcN1AgUT6ViR0I1oNQJ5Ipf
         arQEdra+dR99zB/dZ0VZr+dcYQOoSsSMsqpQ8FI+ASV731sV1V8AOHCjJvtL/dH8E7Z2
         EobL420DahxpHvJGKsNk02RZZ6hY4OmJoTWl9DMWiPwjJBOu1AOzgs0G61yODm0gQV0k
         VFlkHt12xfW9cChSwPfLwyAmK3zZxhWhiYs4u0khpM9FP00ebOcWPXpEiaoNWSRxh1B0
         OkBWVT09oHA0N8N2hVsW4A6kiKkt01i5VfILKKYTcoVuaa9GI1p9XOdu1/SHFpkfo/tE
         LdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpO1u5hzYEH5V8S5yxIwbQt0kkL6XU1TzxqvExx1i4k=;
        b=i74Hc9PxYuSDzf7EpeezJBzN2vQnWBaxgCqO8XxM6aAfNpjo2qVxpf2NVkm5NnELqh
         wZav5bv2+MNeF9MMgCugR9CQKNBWvh+H1wCDe6Nlew23+FcOOPg3iNamCUR5+mWflC+1
         S45LAgjDY5ryuun1fREM54VA7R7XklILw0WJS80HqMzi0x9zAztNQzefl2HrYsy7j+FP
         cbPQ85xSkYpIjzucbI31LwsJsp6JJ0fWDSfXRh5YilxZHlth0caL+IumgFlhl08ZDVpU
         ZBgpwCd/azgMMxVSmml5M3nXO3DZrBBg8zJqf6Nku3xQ5hvhT9/v/sLkFgBVWSzAPy4N
         1FGA==
X-Gm-Message-State: AOAM532TZJPt6nFVPWToNLm9oDnqBet9u53lTQha7MWOhURmO9jf5K0A
        musaun8n3dWC/eHjFzIvmcbZUg==
X-Google-Smtp-Source: ABdhPJxNyjiKIJggTURqLKx/oQq4Q7Jmk8h6KRW1wT9DgA7r5fSDFq6gBpCKYRbs0tGzBN5Tgj8E9g==
X-Received: by 2002:a05:620a:15ea:: with SMTP id p10mr11509186qkm.172.1607630015501;
        Thu, 10 Dec 2020 11:53:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b14sm4157697qti.97.2020.12.10.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 11:53:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knS0L-008vyp-Ue; Thu, 10 Dec 2020 15:53:33 -0400
Date:   Thu, 10 Dec 2020 15:53:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] mm/gup: make __gup_longterm_locked common
Message-ID: <20201210195333.GZ5487@ziepe.ca>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
 <20201210004335.64634-4-pasha.tatashin@soleen.com>
 <20201210040618.GR1563847@iweiny-DESK2.sc.intel.com>
 <CA+CK2bCVEnKKatQSxZcdcvNo+9rWNrGWXyLS3dnF-y7=5Ery7g@mail.gmail.com>
 <20201210174431.GT1563847@iweiny-DESK2.sc.intel.com>
 <CA+CK2bBbN9dxqD_ntAPACfjJmwahPEyP36cb7koVm212nzsuKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBbN9dxqD_ntAPACfjJmwahPEyP36cb7koVm212nzsuKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:57:20PM -0500, Pavel Tatashin wrote:

> Thank you. Yes, this series should be backported, but I am not sure
> what to do about Jason's patch. Perhaps, in the next version I will
> send out this series together with his patch.

You need to send out patches that can be applied on top of linux-next,
at this point the window to go to rc kernels is done.

When you eventually want this back ported to stables then suggest they
take my patch as a pre-requisite.

Jason
