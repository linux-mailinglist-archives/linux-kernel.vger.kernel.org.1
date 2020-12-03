Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE3B2CD9C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgLCPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLCPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:03:25 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38DC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:02:39 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so3850247ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oBk06us5wVqdWMU+iMlK5adDApddIAgqhzs8YqwqZ4=;
        b=J/SCOeMKyQzEy6hV/vdq1obRRZ71jIXpN+DVY5fhw9NYL+fY5UT75nbp3VPGxsTCav
         W8pvlrZtJSrH7Lo17eDrHhEj7T6ND5H8YfhF2KSCMoOAIidzP+kD8Ifab6ZWf1ZdTJoT
         oJqtDQVRvaz9Hj12ZHM8dYP2yBgaZdqR9nPFDFguWJ7kYc2nj5vAs9D2Gk9uXtafnO0P
         nrmrV/CsQ2u1A39EcsqOoEjEGPjVr1L6vykZ8o/kG7XmOkwCsanbI2eNgsBZzULgXgsb
         SpYIQDNn9nU6uM847b+9UVqXCWMCOLTshhnvLCQxofcVwkRhBDqw74sp4aGG4zKSwCgo
         Cglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oBk06us5wVqdWMU+iMlK5adDApddIAgqhzs8YqwqZ4=;
        b=qz6rHHgyagO0SoouDv5Qkchc+6Zwi8DoVARfPJdd1cnJxAWhSGrE8+t6cKYefdYSCY
         LuhPyVzYX7174jwZ/BV8y3dySN/MLK7K5ks+MHcJCLL6ib5qIFSm6NXAV7C8mS+m2jXx
         4HJuxpl2B2yBaeDkWc3+KN1qXi7zjWILEojo/aNOMQjo2/HcOAtVji7yHYa/0aAj9Mwf
         mORtgKu1ELMdLrmDMY7X3yah+7jgun/8ssoBzpwPuz3GeSJwQq8KDURTsKjhjbFXtoUt
         KMDi28oa1HOE+jgTRqurbE5xS3yUJ+hLOQvHDUfN4Voe63bF225gfQ1kY2QsSL6mQtLW
         DEyQ==
X-Gm-Message-State: AOAM530EuYTUQolZR7A+cgdisdy1wYdltXFAW+4C70hj6fSdLQUmO2vb
        4q8vQoJsZvps9BJH1lwq4+Gx+Bo8nN0W9u3+dqsWHA==
X-Google-Smtp-Source: ABdhPJxoHdMGimV/GKPmQkcxnmmWd4M1Lv76VdAbfdEa6XT+0s8FgIiPFgBcYdq4M5pYZ4gIAMkrC62+uAvzY/njBhQ=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr2836575ejb.314.1607007757813;
 Thu, 03 Dec 2020 07:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-5-pasha.tatashin@soleen.com> <20201203085744.GZ17338@dhcp22.suse.cz>
In-Reply-To: <20201203085744.GZ17338@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 10:02:01 -0500
Message-ID: <CA+CK2bAqXcMjxo9F5_0HP8kPbDjnewxcTpVNBbaVZZjhM4FMEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_NOMOVABLE
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:57 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-12-20 00:23:28, Pavel Tatashin wrote:
> > PF_MEMALLOC_NOCMA is used for longterm pinning and has an effect of
> > clearing _GFP_MOVABLE or prohibiting allocations from ZONE_MOVABLE.
>
> This is not precise. You are mixing the implementation and the intention
> here. I would say "PF_MEMALLOC_NOCMA is used ot guarantee that the
> allocator will not return pages that might belong to CMA region. This is
> currently used for long term gup to make sure that such pins are not
> going to be done on any CMA pages."
>
> > We will prohibit allocating any pages that are getting
> > longterm pinned from ZONE_MOVABLE, and we would want to unify and re-use
> > this flag. So, rename it to generic PF_MEMALLOC_NOMOVABLE.
> > Also re-name:
> > memalloc_nocma_save()/memalloc_nocma_restore
> > to
> > memalloc_nomovable_save()/memalloc_nomovable_restore()
> > and make the new functions common.
>
> This is hard to parse for me. I would go with something like:
> "
> When PF_MEMALLOC_NOCMA has been introduced we haven't realized that it
> is focusing on CMA pages too much and that there is larger class of
> pages that need the same treatment. MOVABLE zone cannot contain
> any long term pins as well so it makes sense to reuse and redefine this
> flag for that usecase as well. Rename the flag to PF_MEMALLOC_NOMOVABLE
> which defines an allocation context which can only get pages suitable
> for long-term pins.
> "

I will address the above with your suggested wording.

>
> Btw. the naming is hard but PF_MEMALLOC_NOMOVABLE is a bit misnomer. CMA
> pages are not implicitly movable. So in fact we do care more about
> pinning than movability. PF_MEMALLOC_PIN or something similar would be
> better fit for the overal intention.

Sounds good, I will rename with PF_MEMALLOC_PIN

>
> Other than that looks good to me. Thanks!

Thank you,
Pasha
