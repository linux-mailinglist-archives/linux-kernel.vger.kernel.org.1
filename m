Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579FE2CC4E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLBSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgLBSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:18:20 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:17:34 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so5795294ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbYrYnF+KurepKINrBSoJHW5saproNT9jRib5mamPqA=;
        b=ltHzeqRtIlnnIborJfCkzJ22Oat0zUZd0BiN89Z/qIOVJPyPs0Yy1BU0tFkZt/vmV2
         fr5o43od8Q8LCNDhCJjsdpiwnzKqbqQ+1uMayEaLVkXvpCqqsvq0jpSPmrCKEpUzo1Gm
         XSjN0l4/M9lSvX5zXw8X2y65/IdwxG9cWMNdhRkUb4RCeSzS3WIi9d1bKD11nRx3Gxu/
         wXscvhBm8RFf/8xmUsy2tFFSK5q14niGiJOmTb+YxgqC22n4+TXU1H3rYCf2NFRt+Mbq
         kRlGCfAh0q+1okflQS//yQCOuFjVl6bYdUx6943oB8CHJ1hL72kPzMa4jbvKVGoZfkdy
         ouYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbYrYnF+KurepKINrBSoJHW5saproNT9jRib5mamPqA=;
        b=FpnyI77qwvSVqrOrXgG6TSsPuWZCkxJ0ckWLnMd4hSV9/HLlOCxlkr2Z2Niepsq4mH
         8lcbW8kK+0yuF6xuT2ZD3600MZuS7qZQYqzhcfGyc3J2vRoXVvhuxNAq/BEzmkq4XqyY
         uVMnMsmVaHU92LNgYzlJqcPtdBh1kvGF22SVCvhdIh+wFaPmttWG3IzJLtrwuicPeP+j
         tj9nBSkjnnHfh/V3+N+WTRTLqUKBwgvxpJsIWmtwtDiozoaQO7Ys9630u3QlR+g7TAk8
         QxH+QX9UJ12kH1GNvRI0vphHYJpODLkXAA84NTQMI7BxsyQp6fzw64DN5+QdMq6dEpmv
         hIuQ==
X-Gm-Message-State: AOAM531gRHtDxUAJY/NBgN7c2VHmNHkjNuClzGBeyRWWx87iT4MmsLkE
        Rv0XVgD5j4V/04CUzFFK3doT88V5HpYEKhODiLsn4bMTpyMULRHe
X-Google-Smtp-Source: ABdhPJyL8/Gl6aIiQMnUmPn+lq01BUWHv3MIMEyR/bYpSxrGLu/Ujt+d1e8CE783UdjpbSFMXIcQMlzIeQS8U+zwF+Q=
X-Received: by 2002:a17:907:9d0:: with SMTP id bx16mr1061095ejc.426.1606933053277;
 Wed, 02 Dec 2020 10:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-2-pasha.tatashin@soleen.com> <20201202162958.GK5487@ziepe.ca>
In-Reply-To: <20201202162958.GK5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 13:16:57 -0500
Message-ID: <CA+CK2bAKa8XWO0sypqn6Ac2=nHERRT3iRymnqW1dyRpw0Pi25g@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is enabled
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:30 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Dec 02, 2020 at 12:23:25AM -0500, Pavel Tatashin wrote:
> > There is no need to check_dax_vmas() and run through the npage loop of
> > pinned pages if FS_DAX is not enabled.
> >
> > Add a stub check_dax_vmas() function for no-FS_DAX case.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  mm/gup.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> I have a patch to delete check_dax_vmas that is just waiting on me to
> figure out how to test with dax. That makes all this ifdefery much
> simpler

Hi Jason,

Yeap, that would be nice. I made this change as a preparation for
moving __gup_longterm_locked into common code, so when you send your
patch it can remove both versions of check_dax_vmas.

Thank you,
Pasha

>
> Jason
