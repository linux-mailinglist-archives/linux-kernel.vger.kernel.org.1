Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA53429420D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbgJTSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgJTSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:20:02 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D7C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:20:00 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h12so1903041qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M85fSv8BahcDlCF9UJ6M+uu0ObrHdHEDxKjhsgKNBhM=;
        b=ZPhxZ0k738FNf0pe63JAjf7fr2+0N1EA6+c9mgp2fQePMiVd/CJlxck0574RVWRq68
         V3z/IBkT6SQ8vyg8exe/E/JIKmHWMH3h3h52e02ldSJWUS9awkfRj869O5+09AXFzpb1
         2AsaBczZz9XDGMRQwKbmummZMojEqAbBUP0RRQhLSSmqn9mjuxlxSk8aOgnQ/xPCa2Mq
         jAm93wjtbYii0VyHCUk0RZzEcgvzB1Mzcp9e/r/cH1CiSO0yQ4PPScQpDzkBSYxIsbeP
         /VBBYhTELV9A05uyqJffdxQcf1Hn72c1md2LW+IcFStT6dyZs69j9CZNa6Unslh9pRAT
         F4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M85fSv8BahcDlCF9UJ6M+uu0ObrHdHEDxKjhsgKNBhM=;
        b=pUSuDh/0hrQ8cnEOLeppXcKOBDIcR414DZeLVR5U+ZBagsK/bpl0VXiSBKJQDqbS8u
         UCOyU0hzWVn4OmtJEhrS7bckNL/WrGq5iloKy9iX7Mdvig94+RDAT9LuWlA7qbxKJYlH
         YKrjAIqUqdQXjqwdWMsOAwNN73rgQJkk/cKgC8AV3B7Dzl4bVWuoc2RTPSkkT4WLD87m
         gSNGUPnBkfH2JbanbJ2XTkKuqrg9GIifF1EH2jxt1avVP8o80kb6v0UmC6/ui91QFdxx
         81A4xz7Lkp3KRvpJ5ELiCaFY7Zm994btmu5VWQPrIKFkNjUFQ91+aCx6qqhY8iJZiJlV
         ceBw==
X-Gm-Message-State: AOAM533GnPuAvHEiJDyW4Kl9W+vQgTN+CcYFFxEkh74OFzRJNwSaSVT7
        f8Odzh1w7RsMYiFWRI9jjpepsg==
X-Google-Smtp-Source: ABdhPJzpXkKUy7ZqEVOQzOGaY9mnFlvxyTDpsTnXUSYQQideZaK50gy7objTxpfsEPoNPct8KhwJXQ==
X-Received: by 2002:ac8:3f9a:: with SMTP id d26mr3766872qtk.246.1603217999891;
        Tue, 20 Oct 2020 11:19:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c52c])
        by smtp.gmail.com with ESMTPSA id p23sm1139882qkm.126.2020.10.20.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:19:59 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:18:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201020181822.GA397401@cmpxchg.org>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:07:17AM -0700, Roman Gushchin wrote:
> If we want these counter to function properly, then we should go into the opposite
> direction and remove the special handling of the root memory cgroup in many places.

I suspect this is also by far the most robust solution from a code and
maintenance POV.

I don't recall the page counter at the root level having been a
concern in recent years, even though it's widely used in production
environments. It's lockless and cache compact. It's also per-cpu
batched, which means it isn't actually part of the memcg hotpath.
