Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2962FBF18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbhASSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbhASS3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:29:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41ADC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:28:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b2so22714475edm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEivdsLh035xUwd80O8uoWTflxLp0NXnOA1sF8M3+78=;
        b=MZzAE+lcoJitaKLsjfwICAcGqTemrfvFhimcvi4oG08ftrrRPeijQsl1WSuCgpj5pH
         KYQSqhemslpy00yUaKBzaldVVL8J5PGb9ucoc8nklBVBOXd/T4RjDFyngbFiJTo99Ho6
         5yib6gLuXqtlWtbUkyKMxeKBB9Og3upzBSrJvp+OAmN7cSMR1IvqmISSnMyj8P6ZLD8A
         GWPSxWq/E6CLhQzK57oQNnKIBhXja+5g3NGQ58PhNaOSXLDFggCh9PWeD3IaOlgFqoio
         8jsxGA+NsKalohFP96bDgXGgHmSaXtiVxI6/OvZ5jPJift1+w1ja1OD6l2F40X3QVeZB
         sJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEivdsLh035xUwd80O8uoWTflxLp0NXnOA1sF8M3+78=;
        b=Gr534WmPmR+LXbDpf8mWsbmw7RP9qN2QmsmNSFXyMqKa7vMYgcgCDA40wbwHuiTZ8g
         evUEoOJZMZegPjx+pMkMWG9QabBspQW+yz+OfpOXpAI1QdKWXSBOY0AQ4V2+57oYXwKe
         t9FrpZWAB4uwwwoc3A1uxUBLSpOVuawYYU9Mies458v6nmjuV6s2YC/jQsOM0u06qCMk
         kNkMBWV49r7W0CJKnP2DeE6dC6yHAxusgYOw1xxAcpF7erUKeEflWUykN7XQ3NsFD4w6
         i2gq4AM7261DdBoTH8Avmdj372MaSOBso9rryG+Gb2ljHqwVy0GJoaFZ7SDbJ2CwCQYJ
         Ce2A==
X-Gm-Message-State: AOAM530/uBuhMDbSIIQD4vhrV0TMQC53odbXYVfBec3Ea8ClyBdptg5w
        gYHk/uFIE/Wc8Li+4Wp6yT5G3e/pDzwJvErvsKeUSRxf30Y=
X-Google-Smtp-Source: ABdhPJyIsCE/h8KXnasJlCc79A7cfT2d9l0qv5z4TSIJoVr5CTAM59t6fXq9KkFRvgJmTJyeyJLvPxOfWc7tngLckm4=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr4448005edd.62.1611080901331;
 Tue, 19 Jan 2021 10:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-5-pasha.tatashin@soleen.com> <20210119182200.GZ4605@ziepe.ca>
In-Reply-To: <20210119182200.GZ4605@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 19 Jan 2021 13:27:45 -0500
Message-ID: <CA+CK2bDwFuwgNa3mYHTvBJWYTM+gLaeKS4TBYCjqWzag3kEagw@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] mm/gup: check for isolation errors
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

> This should have a fixme too, this is a bug.

OK

>
> The patch looks OK, but I keep feeling this logic is all really
> overcomplicated...

I agree, I have a simplification patch for this logic, check out patch 12/14.

>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thank you for your review.

Pasha
