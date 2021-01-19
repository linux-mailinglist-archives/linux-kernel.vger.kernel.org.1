Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4E82FBF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbhASShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391454AbhASSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:35:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:35:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a10so13317107ejg.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ct+vcUpxOjScIL+qAWZyF8knx6gxVliNtyQsEHsrnBQ=;
        b=BZe8awveFMq5GincJDNVuax+pU2IN/5C9pNKCNqUs9yROKpwZH1EZi26i4cskhGgts
         LII0hwEUCFrmUnS9VhpzvWJaH/THjYoCLkOL5y59cRy9Pi8y8m7cle0ouKhiR+qVd48Y
         1oSq4GGmA983vt0d8xpUHcVPHW/ai9FuZwTL9vqIiU/gHm3IA5IuUXBOm5GA/XKdEobF
         rwKxMX2jZR+kjWjBjA/ZQh/tFExxv01CpNHBLazxFhAIQGrcXcvtxWNt0O385H6icruS
         pNEIfHrArsdVfXtKXjZp7ImGEY3/7TOtRniIqG5iFaGU2sjo1pdfb/EbSos1zRgaftyp
         PqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ct+vcUpxOjScIL+qAWZyF8knx6gxVliNtyQsEHsrnBQ=;
        b=CSFxSPioXApaKJ16ebTozA/qQWxcGuOA+yWtX/MZnKyNl9reAvQJF9mJVrhcllC1oM
         gf6IrdgAyU71sXmFVk6UwSev5ZzfOTgzUz3dpxTjYNH8WmLu5iLyErGojDwOizDxWAyS
         9xLW68PkYYzCIhnsi5pd+9m5bAjZdoT+5CGh4TA3UI4Ls4uUNwpZn+Wl5Y/cDABvShjG
         Zh+ce9GQQglvCMkPt2SxE4WecYknnXvq2AS6gsVFnfV6tdYx7FlCES4HBZ1Qt+zkv1dk
         kYRj7TmCVlNbSIcAwBff4M352GdfwA8B7mmRyTMnp9x2CCicO4Xa8EP3lbcQKWL/VWCS
         fwFw==
X-Gm-Message-State: AOAM532vPOw/uk/HWj17eEkqRCrIO1g8isGi/+zfWUKUc8vBddXc1gfW
        6DdcewWRbNHfrDSSkqxmH7aSwSb7XL47U8DV3AhZJw==
X-Google-Smtp-Source: ABdhPJxq2+sfTG3ORVXYvyp4uAxt4hNSEd/oukNuDPHO3IHBTF8PXk9SD4PxTgPj0Ma3BgJmPR49bmjsQLfU4aQP2Oc=
X-Received: by 2002:a17:906:cedd:: with SMTP id si29mr4046472ejb.426.1611081302258;
 Tue, 19 Jan 2021 10:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-9-pasha.tatashin@soleen.com> <20210119183013.GB4605@ziepe.ca>
In-Reply-To: <20210119183013.GB4605@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 19 Jan 2021 13:34:26 -0500
Message-ID: <CA+CK2bBKbht34Hkg9YvhwYAiAjd3NMd_+Eir9wfx+07V-Y2TTA@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
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
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 1:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jan 18, 2021 at 11:39:14PM -0500, Pavel Tatashin wrote:
> > Zero page should not be used for long term pinned pages. Once pages
> > are pinned their physical addresses cannot changed until they are unpinned.
> >
> > Guarantee to always return real pages when they are pinned by adding
> > FOLL_WRITE.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  mm/gup.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
>
> No, this will definitely break things

What will break

>
> Why does the zero page have to be movable?

It is not even about being movable, we can't cow pinned pages returned
by GUP call, how can we use zero page for that?

>
> Jason
