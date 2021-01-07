Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABFB2ECD02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbhAGJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAGJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:41:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A9C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:41:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v1so1137254pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MnHOX4pskFuPG7OFd/dauJfsTs//0XTmeMTCTHeQlUA=;
        b=pbcMO3Hfa86cR+9g3QvViD8Yfox8sJjgu6v0clP/X4NFa+D8fWfFiaIRm5z4zMwoJH
         5MkY1oMsehW/4VT4ZMEsmbI+eCg2XChBl+IOLzGqR0/kLV855SGWRZB0bc3p/e8F6Wch
         dmN8cMwDSO1lt3IX5hNgoPq+ZIIBqOU1pQlq6gKgRSYY5KydSuRdU8ZCk7CODKnoQAOj
         lXYNKJ9IB/vXpo8cRbmWka3yz2pA828nnOIvIpgBgJsUWGEiBo8tf7Uqcbpx2VSBdsDQ
         nOUjG1DuYsxWklrvYep+phqDb1WpZk1M4tbRMxu4zcevDDnhKTW8UYFPdBA8FjCN9Trd
         qMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnHOX4pskFuPG7OFd/dauJfsTs//0XTmeMTCTHeQlUA=;
        b=uWR2EOpK6Sj0jBN5vbY2iLH7swdHxeaCJqBPVTTyIUoGHDDQKvTJDJln1KeMxyQi1i
         +kPQvJoAMY7zEdbQ/rkD34D51NR6z8aNZDCX96J7bbQ56vwt5JxBgnpRZINQK6yoOmBr
         6YArMgffzoX0YxvKpj4pQvYV1zNJbFHI9XlKdk0MM7cVJ8CPTE9+dr5R4i8CZFNc8ybh
         UJN8c45pmTCS3Rv4Mh454J+bQTuY4AclNNMUM6XqNGdmMcJJ3N/GbNJxze0eX3XzS/ht
         uBKyrQsY4w3Ylw5Tox7qhKyBbst4xQRKv2izDBqF2iQk6yWs/SKBXQnhxkwbaZYMoW9x
         LGWg==
X-Gm-Message-State: AOAM530FidRVOYjFtT0wMJO+J2Qc2JLfrQH6Yp4EL9bGh+1TUoK5rs5n
        HkplFHIa1VFNF9sP1MrTgHrio57WFOrKiAALClhrYw==
X-Google-Smtp-Source: ABdhPJzfEWXI+9UPdfiFcOispB7f2eE3ROIabUrQQzAk/DdUE+h5xMCHq2N+ZWkSpTaz4bqeCwJ1qKMZkdy/YK6P95E=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr1485575pld.20.1610012474258; Thu, 07
 Jan 2021 01:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com> <7b44eddc-cbae-92b6-5ac7-765cad2a6326@redhat.com>
In-Reply-To: <7b44eddc-cbae-92b6-5ac7-765cad2a6326@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 17:40:34 +0800
Message-ID: <CAMZfGtUcGLZjesq4ztqHXG2PekmJ2q60s3ymjBRmiJ141syK3A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/6] Fix some bugs about HugeTLB code
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 5:30 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.01.21 09:47, Muchun Song wrote:
> > This patch series aims to fix some bugs and add some improvements.
> >
> > Changelog since v1 -> v2:
> >   - Export set_page_huge_active() in patch #2 to fix.
> >   - Using head[3].mapping to indicate the page is freed in patch #3.
> >   - Flush @free_hpage_work in patch #4.
> >
> > Muchun Song (6):
> >   mm: migrate: do not migrate HugeTLB page whose refcount is one
> >   mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
> >   mm: hugetlb: fix a race between freeing and dissolving the page
> >   mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
> >   mm: hugetlb: fix a race between isolating and freeing page
> >   mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
> >
> >  fs/hugetlbfs/inode.c    |  3 ++-
> >  include/linux/hugetlb.h |  2 ++
> >  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++++------
> >  mm/migrate.c            |  6 +++++
> >  4 files changed, 71 insertions(+), 9 deletions(-)
> >
>
> Repeating my question regarding ccing stable on selected fixes.
>

Just add a CC tag in the commit log of the fix patches? Right?
Sorry, I'm a novice about this. Thanks.

> --
> Thanks,
>
> David / dhildenb
>
