Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243F92C6C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgK0TxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgK0Trl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:41 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDEC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:23:09 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id a10so1798946uan.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lj/Md7KmedZSUw1wBs8z6JnileNDupkEL/4bRaDI8ME=;
        b=qyoDSzbd6iG6EreTYzKr3BIzRhujEtYvEMyQrSIwnqgnZwGROdD6LQKm31ruyVQwyP
         0qHpOkcfADz1VmJl3dvR+NLjr4WF3+bEFkMCidKE5nXlxo8XsIo0pQRE22kzUL5tSwXs
         193UM4iyHr2Qbvp9Q6CLYS64VGTYBBKSwzTctbTSUyksEgs04Wamzuy6yCtxXQNnfDWp
         CLMnx71bmnPx97iI1NDq/e77GgG/ofqZJ9YQvFLUSw9dc292nIEYgbulYXAqKn3owkc7
         sEVYjdaAoAB9irQMSJSt5cu0jAYOF9JQfpX4M7aQ19f6K71itNJS8B0Eo75wp9YKmho5
         oqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lj/Md7KmedZSUw1wBs8z6JnileNDupkEL/4bRaDI8ME=;
        b=AIbZlY8Q95cnwLyE9M2ToK3XGJAcT60VX6M6DFEPU5EHg6wGhoo0LEKvc9ip2ku8OH
         vbRMBo9LM9YVthRc67i3uOmsUpA7wNXbGITkLLwgQ2WMWf+1ZBeGJvpul/OaxPRQYb5y
         5rv2Ad2ODwvvxfYIlB4JJCy+vQxVt1hAP1CqMNGkWY2r/EpFYV4tV8ejMXUuvVCIuK/H
         xN0Yt9kGloO/6rHafvN+eYo5Jgd1aI2wXcSGmi5Sonakws2ZiJ73r9VV7SKWKu/NMB0x
         igJ4i1FshlVIm6FbW/jADFtRRWytkgmZJf9eVRHS5MW82XONgBkVm2J9wWUJkhuvpxrp
         Q+5Q==
X-Gm-Message-State: AOAM530OqiXU0XOoet1G2kQxxAA7eB8+wASeY+2y6hw4RGYtbdKGtK7h
        Vbj+wtzEe9eutlwRhln+2iG76HOqOxSEyt10nso=
X-Google-Smtp-Source: ABdhPJw5PL0NjJ+q+bKhtgVgiyH5lumDyAcOPabAX3a2Ivub98v2NL4GqQtf1FzjvWtW2+hs5GIQ5zZCbMX/bNMWVUA=
X-Received: by 2002:ab0:2986:: with SMTP id u6mr7115267uap.118.1606504988446;
 Fri, 27 Nov 2020 11:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20201112184106.733-1-georgi.djakov@linaro.org>
 <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
 <02f682e2-0e9b-76a8-04fa-487891e18bdf@suse.cz> <3ef3d770-d74b-5588-6672-f092c1526461@linaro.org>
 <bdf8727f-1191-34bd-d8ec-69b2a3d50c1b@suse.cz>
In-Reply-To: <bdf8727f-1191-34bd-d8ec-69b2a3d50c1b@suse.cz>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 28 Nov 2020 00:53:11 +0530
Message-ID: <CAFqt6zaZ8NCUUMpXA_-r2D-c_J99yrhjfRrpPFYhcebASeHebw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 12:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/27/20 7:57 PM, Georgi Djakov wrote:
> > Hi Vlastimil,
> >
> > Thanks for the comment!
> >
> > On 11/27/20 19:52, Vlastimil Babka wrote:
> >> On 11/12/20 8:14 PM, Andrew Morton wrote:
> >>> On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org>
> >>> wrote:
> >>>
> >>>> From: Liam Mark <lmark@codeaurora.org>
> >>>>
> >>>> Collect the time for each allocation recorded in page owner so that
> >>>> allocation "surges" can be measured.
> >>>>
> >>>> Record the pid for each allocation recorded in page owner so that
> >>>> the source of allocation "surges" can be better identified.
> >>>
> >>> Please provide a description of why this is considered useful.  What
> >>> has it been used for, what problems has it been used to solve?
> >>
> >> Worth noting that on x86_64 it doubles the size of struct page_owner
> >> from 16 bytes to 32, so it better be justified:
> >
> > Well, that's true. But for debug options there is almost always some penalty.
> > The timestamp and pid information is very useful for me (and others, i believe)
> > when doing memory analysis. On a crash for example, we can get this information
> > from kdump (or RAM-dump) and look into it to catch memory allocation problems
> > more easily.
>
> Right. Btw, you should add printing the info to __dump_page_owner().
>
> > If you find the above argument not strong enough, how about a separate config
> > option for this? Maybe something like CONFIG_PAGE_OWNER_EXTENDED, which could
> > be enabled in addition to CONFIG_PAGE_OWNER?
>
> It might be strong enough if it's mentioned in changelog, and also what exactly
> the space tradeoff is :)

Just a thought ... putting it inside CONFIG_PAGE_OWNER_DEBUG might be
better if it is used
purely for debugging purposes.

>
> You can also mention that SLUB object tracking has also pid+timestamp.
>
> > Thanks,
> > Georgi
> >
> >>
> >> struct page_owner {
> >>          short unsigned int         order;                /*     0     2 */
> >>          short int                  last_migrate_reason;  /*     2     2 */
> >>          gfp_t                      gfp_mask;             /*     4     4 */
> >>          depot_stack_handle_t       handle;               /*     8     4 */
> >>          depot_stack_handle_t       free_handle;          /*    12     4 */
> >>          u64                        ts_nsec;              /*    16     8 */
> >>          int                        pid;                  /*    24     4 */
> >>
> >>          /* size: 32, cachelines: 1, members: 7 */
> >>          /* padding: 4 */
> >>          /* last cacheline: 32 bytes */
> >> };
> >>
> >
>
>
