Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32712CD9C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgLCPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLCPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:03:48 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F35C061A53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:03:07 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so3964405ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVisqqss1RdW+JeFuc9oo5r214bIOsor8pJgNyDFL1Y=;
        b=nSC5qntQpRFGIXZzT4l1MnQW4JGCnwb0U4SAwsQ3qwScnLWFNaL3Pxi/jwK5qsTMxC
         0Q1zV4MMa8U+s1okYC6v0EnBllDNxEprIhPks/aSE8mvpjp7t6pNvyrkkGhMuoZWCrnb
         OcGFwiWiQLORuQfYJG8OmoT06Ds1cLWV8awPU8mWeqtZ4sBQvk9HHpNj1D5e9K6BOBuA
         eE4HwiPjQs5XqQBX4O9S1kR9qbIlpPBEqhBGQJlXWrHuKGCq6q9E6xQzaB6/MIU+DJjM
         mZYO1QzJlMRy+HpFxKgWXxIdreNzHV2u2jidtSBb1qjuqU5twEyG5NpK1NxFMgK9C7E2
         35Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVisqqss1RdW+JeFuc9oo5r214bIOsor8pJgNyDFL1Y=;
        b=ir80ezTA+xsk5H7ld40JHEbyr0kt1LdRkydNBTDIUy732V0ybyMhpflgJnH5ZEiYwj
         Pnw71gmist1FbimaVizDEWLOo/iBrBvYWKzdaEYBYqqsGDWVu/Z4wHCdm5Bd8DqAtDmc
         c4getVX0/AqYoh8grO8aoLfC7J9E1xGjq0wKdUip9UuyY0Lgpola9Lg7rn0aYeVtaVrt
         K+9ABoXFLzdjqCuyWxEkAZ+DwCzQfuTURBN2HPiM1gGT2VbMV0YvbzPXJVoa56wW2x5b
         7j4wpXX/3sFP8q9q+2fRqfbCb1mNxMLajQpbV8fMYA7H6pxzsAEcP4tgP2h4Texes0Dq
         SFAg==
X-Gm-Message-State: AOAM5311ipTmOQUQfjldUPWfnOF6yZxehh33HLoi4Bj6zXy2smfPYTeY
        H/R804VtnCtMWwuZT0VJQ2K1Ptiu8LyQB12dHD+XXg==
X-Google-Smtp-Source: ABdhPJy8elkTNU12MV8GV9rblp8n76rtXKWcSDQG/45fkFLVCH4KlsP7Te0Cv7nYrlfnwsb2bKAp+L/IB0AQgwaPoso=
X-Received: by 2002:a17:907:9d0:: with SMTP id bx16mr3019932ejc.426.1607007786634;
 Thu, 03 Dec 2020 07:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-5-pasha.tatashin@soleen.com> <eea5da76-e753-e7c8-60a4-c3e7e58649c1@nvidia.com>
In-Reply-To: <eea5da76-e753-e7c8-60a4-c3e7e58649c1@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 10:02:30 -0500
Message-ID: <CA+CK2bDfmZF7BKUmF9ZUJQZobHWRpfop+eKKqRvvTbna6KzNvQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_NOMOVABLE
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

>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thank you for your review.
Pasha
