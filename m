Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B382BB150
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgKTRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgKTRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:21:03 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BDEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:21:03 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so10798578ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlV8pwcEGIYETl/1da0CIt2CMOjh6NH0hFTF8FaV9w8=;
        b=aPLZipbFsCt2Yos6Yko2GrdSgzPihXm60TQPOA7NGZ5VvB7ocksqPeYdNO3e2q29NU
         Z8ZKmmpTjwzES3DfJ3UOJGbnRii1eNywcHonAkHLcguNFmjUlxXQnC0/UwyCvYQdxogq
         lqfTsnMWVxdHCIZ0bFWiu9c/ZkeBmZ5QTNKuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlV8pwcEGIYETl/1da0CIt2CMOjh6NH0hFTF8FaV9w8=;
        b=SF4TlCNtVWyDqf92TbCPt8Pm/cBSkvjDh6qPSInjt06ySdBTU2qhF58Afxp2+PVKNA
         Epy5C3+r2FaPOSdQmfF/g+hUQFiBkJcAs6qS6SaADT17+RWbjIongnLGIJS7c/Qk5dz4
         7k/EukpXL1MC4+oLe6FsNQyE1cSFBElBAohiRBdatMD4SLcqayzeoyuDMzLJ7RRnwqjR
         VHlskAAGxJR+XCv1FV484vUU3tIKEtF0ekNulct5nst46Sh+FipdW7P3A+DDEPXhOsoV
         dHryMTD3I0z3aehPTlbGUdEIRoZViGrl55Uv2TRK+GyZRRDuqxBbLHl7TPtMVTXTjeS/
         GsaQ==
X-Gm-Message-State: AOAM532YBEQVn/p0mkfjJ3fg8l9t/iKqqRUt6HJf4wwJsSwXe4u4y92a
        1dFWkqHReqcICljotXfsYLvvh90Gpd9Pkw==
X-Google-Smtp-Source: ABdhPJw9/swDjS/7Gq/QHfBOLyjOZdj2TmUt2B6gmbNZQ4Z2ZlPMliUbMedi2RONH3HohijO5bkqrA==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr8324781ljj.3.1605892861710;
        Fri, 20 Nov 2020 09:21:01 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id i4sm340411ljj.6.2020.11.20.09.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:20:59 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id a9so14537041lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:20:59 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr7580125lfy.352.1605892859115;
 Fri, 20 Nov 2020 09:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20201120143557.6715-1-will@kernel.org> <20201120143557.6715-4-will@kernel.org>
In-Reply-To: <20201120143557.6715-4-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 09:20:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whp=cyfq6kuVWHRbMxOak0-pJPdHsX7ghYaS6i6ETd_fQ@mail.gmail.com>
Message-ID: <CAHk-=whp=cyfq6kuVWHRbMxOak0-pJPdHsX7ghYaS6i6ETd_fQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] tlb: mmu_gather: Remove unused start/end arguments
 from tlb_finish_mmu()
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 6:36 AM Will Deacon <will@kernel.org> wrote:
>
> tlb_finish_mmu() takes two confusing and unused 'start'/'end' address
> arguments. Remove them.

Ack, but please add the history to it.

Those arguments were used, up until 7a30df49f63a ("mm: mmu_gather:
remove __tlb_reset_range() for force flush").

And the thing is, using a range flush in theory might be better, but
for simplicity it's now doing a "fullmm" one, which is why those
arguments no longer matter.

(And I think we track the range better now too, which may be another
reason they aren't needed)

          Linus

                 Linus
