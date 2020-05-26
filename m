Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B481619F3C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgDFKnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 06:43:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44957 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgDFKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:43:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id 131so11345600lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvmRlJZD/otx8so6QDvSPODmkrR200UpnmTufaBUT38=;
        b=Vr1zqOOW396ZD0mf9Mug4eLYzrEA29MI0brRL948nuMriYg6BZv0Tb5RtVP6HvLQQH
         n+e/kbCoWSl3s6VqA7yKKJHaSKSKJqip1oXY0eWCGFezbHQijF0Q2SHcBSnkmFgWDywp
         mljDJtyNhK8MPCl/YbBGGN9I6TayIpHMX1YCwWfvYG0ukJ/QSEL79rwxSPOAPax6PMRn
         4vW4+hciDTqgLX/xTT9pOaPbnjoSanmMFnvRqIpLb/OUyiBUul53Gr2NXF3faCXkd492
         UxelXakVnmE/s7zRk4mH7EhS5uXRSH7KMp2DFIXjE9f9xMBzwakQJR0SLqlLX7ithd8M
         AAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvmRlJZD/otx8so6QDvSPODmkrR200UpnmTufaBUT38=;
        b=aF4Q0V0VCTp/FjxI4JEhrmesTuDCdgffb+MleshjMAzlefMjR4aMFqmV1qlyzEtVrc
         m4YlFTVousIV/Y8rGMVo8nkmTdiXrMHmYMqy4fMbF8QZeQTMUHBIfb8yrvxCfxzAKxFD
         2KWOwsmwT4715auzLxPFnengcB8CkgBTctMG3cT9xkinFtfpIzb4U1m51z6+IS+eUNqW
         lbQWCQDesedfq3Kd6HI4yLkKk1S1E+ajLY4MX4nq+ywHWzhhBOPXytX6wJy/YvvZ9RJD
         BZHDvmXBvhfmEoVSbM/qlZUOIcWsDxbfDn7nYv2ak+00S+tbZwvOGmT8KZQ/fGNQcigE
         CXKQ==
X-Gm-Message-State: AGi0PubfMd30tNUBcFlvax52sFpudfPtV/VgfMqeOSWTpWTOcpFgVsOZ
        DHVOw2p8RohMXkHgkGLfamDc5MVaV6/zUrSNoY0M2Q==
X-Google-Smtp-Source: APiQypL+PYJMVdhXWwODi3JLfZmWHtnhhJ1Bmk3hkaHHuLbTYE3Lvtel0nEM+hl0UytOiKrvXfhQVd51dtjxYjf9wL0=
X-Received: by 2002:ac2:44c6:: with SMTP id d6mr9122969lfm.26.1586169811657;
 Mon, 06 Apr 2020 03:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200405234639.AU1f3x3Xg%akpm@linux-foundation.org>
In-Reply-To: <20200405234639.AU1f3x3Xg%akpm@linux-foundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Apr 2020 16:13:17 +0530
Message-ID: <CA+G9fYsUsGS6ybozk3A=8aG5VFpF-+DJGNAim4o=Xi9CB43tDA@mail.gmail.com>
Subject: Re: mmotm 2020-04-05-16-45 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 at 05:16, <akpm@linux-foundation.org> wrote:
>
> The mm-of-the-moment snapshot 2020-04-05-16-45 has been uploaded to
>
>    http://www.ozlabs.org/~akpm/mmotm/
>
> mmotm-readme.txt says
>
> README for mm-of-the-moment:
>
> http://www.ozlabs.org/~akpm/mmotm/
>
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
>
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
>
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
>
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
>
>
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
>
>         https://github.com/hnaz/linux-mm
>
> The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
>
> A git copy of this tree is also available at
>
>         https://github.com/hnaz/linux-mm
>
>
>
> This mmotm tree contains the following patches against 5.6:
> (patches marked "*" will be included in linux-next)
>
>   origin.patch
<>
> * mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma.patch
> * mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix.patch
> * mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix-2.patch

While building Linux-next master for arm beagle board x15 the following
build error was noticed.

mm/hugetlb.c: In function 'hugetlb_cma_reserve':
mm/hugetlb.c:5580:3: error: implicit declaration of function
'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'?
[-Werror=implicit-function-declaration]
   for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
   ^~~~~~~~~~~~~~~~~~~~~~
   for_each_mem_range
mm/hugetlb.c:5580:62: error: expected ';' before '{' token
   for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
                                                              ^

-- 
Linaro LKFT
https://lkft.linaro.org
