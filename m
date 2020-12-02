Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6472CC4E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgLBSTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgLBSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:19:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:18:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d17so5779640ejy.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQeaA1Dq0iwRVoOoOLiIPsXTl4jei7rYdf1cRqUtg1k=;
        b=Z9Mc5pQwDfDSLftb7VgHE3kifMC0VqSFW2ybnui5COkbMbGbI+iTxBcAxY6eLjzMko
         QoLz1zVv+Ez25Z4oae6/ppwnGGxyZegi3ojhTmzEMvNn2PzMdbl7BSv4kQfQ3b1/7Cx+
         Z6R0jZYiUBsl5UI7WIr4e5Ggidt3Kcjl5kMnoVFzSk0VXJEopVko6K0SeuqHFmNTSKPP
         1fM091l0ic5k4RttR3MEwPl1qmMqU1EW/IJAlrtuWoz2ua7as8qCAvl3/BFqknaGvmt9
         mkX5t8Lm5jqq+t02fjkNUuYgDhKlavJ2/ECrm7h0Z3iFJ7F4uT++qyJSCO9cbeucCOJc
         m/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQeaA1Dq0iwRVoOoOLiIPsXTl4jei7rYdf1cRqUtg1k=;
        b=tlUt7BVsXx8Q9D9nykz17y98fnbOzYPzlrHjbWhPP9t0AhpJnJbsc0e1GTn2qeaA3q
         NjWoIxtsZ/00PTfUMbHyagS1CD5a0uFLLQ4Ih7d3xX4/MMzKwlaxFhwUKDpcfzljWo+l
         97LWV9NWqya6lrROskXB6SSINDnZ9dZu/hARPxbZcZvu4sQN86kMKJBgmJeH5hiQjCio
         AHnp/co/ujEPs6woSIGFPaUNdqqxu26FM5SUMyMAwNhm/CtbihI024xSsKq0fqialpYo
         iqrrLULbG/p63F1ZYztR5LK/Fq74aPpRGmwvIatxKNzgGv+jnJJZ18yn2LPOJPizbAPb
         kTRA==
X-Gm-Message-State: AOAM531SyxzA4q5F3oV2nLRqdO5ZBZo8oZUM6NM9+e9MFQnvLntYEMLV
        On6haSqH0zz4BJr39dbv5599+K7rTXlj39njHeqx+EGlbqABAA==
X-Google-Smtp-Source: ABdhPJxGdklfBMtFTsl2nxnm3FfGKnRqwgHC/+GISnJy7tiqSoWFhVB4HpbuKFuM4aH5VgzUQfvoZGi5Cj2cw78OALU=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr1029058ejb.314.1606933102474;
 Wed, 02 Dec 2020 10:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-3-pasha.tatashin@soleen.com> <27224254-7e8d-cf4f-aebc-1ffe32ca65be@redhat.com>
In-Reply-To: <27224254-7e8d-cf4f-aebc-1ffe32ca65be@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 13:17:46 -0500
Message-ID: <CA+CK2bC2ac==fv13h7vF7AmkE8SXmoA1mT1QHvD_T575vSM5xA@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/gup: don't pin migrated cma pages in movable zone
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
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

> Looks like the right thing to me, thanks!
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thank you,
Pasha

>
> --
> Thanks,
>
> David / dhildenb
>
