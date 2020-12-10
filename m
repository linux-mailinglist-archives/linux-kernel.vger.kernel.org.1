Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6612D679F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbgLJTzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393645AbgLJTzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:55:36 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB82C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:54:56 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id c7so6845238edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiqhdpxyPB2qhSSL8lmFRULkbulVtgbgM3x8Yn9WIks=;
        b=AQf++TUte2ltHpibq5Gju3qOiL3gtd1QwSaE59Zg0LsQw0zfjWW1HRIjo9mBANVxxH
         g2yUJArXsTS3kiJYk8vnpJm/oDoorxtLFcUedB6/Ott4sfP1HkYEs9t7U26t6bey9sTA
         Er4F3CqzLKP85p3pj8B2B6a7zErOigfFrDZZ9E7gNU686C6eHUdLXUmgUjC2P4bVgU/t
         Oll8359JTX5UYeF11kTF1p01Spfeg705guksa4L+rg+PsJ7z3XD0xgGoF7BtmGAl7g7Q
         /+qZmbbMRwbJxIZ7nzM/qn2BqIpL3ylAOl0oe7DirzZefatNhRi/T6dEcsk+MYr6sXSa
         cF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiqhdpxyPB2qhSSL8lmFRULkbulVtgbgM3x8Yn9WIks=;
        b=V4L/q5Nr2z6a8BPYM8lar9Bitz6vFSuIAZD/NBbu/51Fde8/5mr/9XjG0hjviZpsmK
         37rxKliC11AJbPudItctIPW41ZAOnCDNr4rTzb+cE+kTdc3jPVZJk1yh9MU4wpAXF1G5
         /0P2zBii8J3e5QJrCFEHjDOrYYA66EK3OLq9zDOTNh1PYL47xl4V6Volezfx24F4pSGd
         TKELqcX4a90FZB3DAvCbe/3QrEiI0i1xlABx/0FC5I2DrwJpkZAOPFFMVW1rAazY89Qk
         9zKaRrf+RAv7VZORljABPzsV2o4l/49hlJJCQW4jDezxF2LepDLst6//5W38feK5O7E6
         XBkQ==
X-Gm-Message-State: AOAM532/hdeD3dBksHHHrcZOZPsFbPzHwrT/2YKYbcCignRLetZ0qPnn
        3h3Ju4+p4mSg16Jd0dMmwVECs8Ojuw3HTPOpW9REKaIVdfVE6g==
X-Google-Smtp-Source: ABdhPJy6P/1OMDVVi/Mgffhj7q+Ecrh69fmJZ7dv7K4HV4Uijlx/0siUn7Ux4OH+Kcm9DmIKFaYocoPNZYKKhggZsDE=
X-Received: by 2002:a50:d757:: with SMTP id i23mr8539200edj.116.1607630094894;
 Thu, 10 Dec 2020 11:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
 <20201210004335.64634-4-pasha.tatashin@soleen.com> <20201210040618.GR1563847@iweiny-DESK2.sc.intel.com>
 <CA+CK2bCVEnKKatQSxZcdcvNo+9rWNrGWXyLS3dnF-y7=5Ery7g@mail.gmail.com>
 <20201210174431.GT1563847@iweiny-DESK2.sc.intel.com> <CA+CK2bBbN9dxqD_ntAPACfjJmwahPEyP36cb7koVm212nzsuKw@mail.gmail.com>
 <20201210195333.GZ5487@ziepe.ca>
In-Reply-To: <20201210195333.GZ5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 10 Dec 2020 14:54:19 -0500
Message-ID: <CA+CK2bCgEwa=dP4mUPkYy9vF+feXiWGQPM0gv6wZTd3j5Y6nyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] mm/gup: make __gup_longterm_locked common
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 2:53 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 10, 2020 at 01:57:20PM -0500, Pavel Tatashin wrote:
>
> > Thank you. Yes, this series should be backported, but I am not sure
> > what to do about Jason's patch. Perhaps, in the next version I will
> > send out this series together with his patch.
>
> You need to send out patches that can be applied on top of linux-next,
> at this point the window to go to rc kernels is done.
>
> When you eventually want this back ported to stables then suggest they
> take my patch as a pre-requisite.

Sounds good.

Thanks,
Pasha

>
> Jason
