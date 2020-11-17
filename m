Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC32B600C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKQNEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKQNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:04:41 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0809BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:04:39 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so28969285lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lOoRt7gRUVygfU+Sl/VWrnk6H3xPmjMwBcvxXe+wyCQ=;
        b=ZZSQqqcITOCtDFjG/ylX0ox1zmLGFZefZpz8kipr3jXFFmLZ0QJXJ1nl5PYWGyry17
         vkRHeSyzuWuQfi+7bZEIg44eUwT75uYcVjKPg0H46nErXw+DU/LCe9Pj7rMa4BNolqjY
         qJeaS3GN2KR9eExu1CJhGjwpkMKlFFOmXRllK/TFQYSCni4LsMkUbfg0KGLkpBm8mIcu
         2Eq20stKp1j2r484tIRJ0waV7in3q2aa+/DGVylHWV7IjjDVaRq+64kkEnt2DmMR6j7M
         LMg29udOJu2QT+gXTXv8BMTptc2EGLf3TeIF+NCk5m88KNb0KQIplnHXPQHXnr3zZUAr
         jL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOoRt7gRUVygfU+Sl/VWrnk6H3xPmjMwBcvxXe+wyCQ=;
        b=p0sKeuhhGyi51e/RM8RAYa6js6jgCtrKSe7RYnP7cNyq2gWAd4ZnH8kkf/sbfl6ouD
         9cJSmazzxwbHqY/69onNaHsHUsQ+oTaa6V0op5/8RcxegdlLT/DeD5SeWN4rDS2Qd0i6
         nZrUiGpUsfv98q+6H6pYSaQ1sMzUj62knWWtDY+11LUTHeJ9BWkOqmZN9gyHFCPdkNKO
         MV1Qh+yOHykrAfBgb+FiuJ/VA5yuS/S2Y/mgb5EMSrNowhZiXxaKp1Gb0SS+mUbbxz24
         Q1q2nEipyQq1eubeUTATqPZwtzkeT1Ph+mVHjLHhK+7qFAWFsGLHQxgradoxd8B8jDZ/
         Qx/A==
X-Gm-Message-State: AOAM5337gB8XvEnFmAoVxXykRE7rfc049iX4owuXYougXCtbCxpC8ddX
        K+12fzAoKdQ3jQge3CbVMs4=
X-Google-Smtp-Source: ABdhPJxGk98DUyyioKZA28nW7+rRaIXDNACiz7urpEtkaq6VVVMF4oMmiM58tbnMbl2hVm/FCLeAIQ==
X-Received: by 2002:a05:6512:210b:: with SMTP id q11mr1594356lfr.238.1605618277471;
        Tue, 17 Nov 2020 05:04:37 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm2989482lfk.207.2020.11.17.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 05:04:36 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 17 Nov 2020 14:04:34 +0100
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
Message-ID: <20201117130434.GA10769@pc636>
References: <20201116220033.1837-1-urezki@gmail.com>
 <20201116220033.1837-2-urezki@gmail.com>
 <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:37:34AM +0800, huang ying wrote:
> On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
> <urezki@gmail.com> wrote:
> >
> > A current "lazy drain" model suffers from at least two issues.
> >
> > First one is related to the unsorted list of vmap areas, thus
> > in order to identify the [min:max] range of areas to be drained,
> > it requires a full list scan. What is a time consuming if the
> > list is too long.
> >
> > Second one and as a next step is about merging all fragments
> > with a free space. What is also a time consuming because it
> > has to iterate over entire list which holds outstanding lazy
> > areas.
> >
> > See below the "preemptirqsoff" tracer that illustrates a high
> > latency. It is ~24 676us. Our workloads like audio and video
> > are effected by such long latency:
> 
> This seems like a real problem.  But I found there's long latency
> avoidance mechanism in the loop in __purge_vmap_area_lazy() as
> follows,
> 
>         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
>             cond_resched_lock(&free_vmap_area_lock);
> 
I have added that "resched threshold" because of on my tests i could
simply hit out of memory, due to the fact that a drain work is not up
to speed to process such long outstanding list of vmap areas.

>
> If it works properly, the latency problem can be solved.  Can you
> check whether this doesn't work for you?
>
We have that cond_resched_lock() in our products. The patch that is
in question creates bigger vmap areas on early step(merge them), so
the final structure becomes less fragmented, what speeds up a drain
logic, thus reduces a preemption off time.

Apart of that, high priority tasks like RT or DL which are users of
the vmalloc()/vfree() can start draining process from its contexts,
what is also a problem. In that sense, i think we need to make the
vfree() call to be asynchronous, so latency sensitive tasks and others
do not perform any draining from their contexts.

--
Vlad Rezki
