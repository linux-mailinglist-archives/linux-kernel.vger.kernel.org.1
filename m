Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945062DAE62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgLON5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgLON4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:56:38 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76579C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:55:57 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cm17so21122111edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28yftlhd5Mm7TNEoJztkfUFW7tsicxqlvZ58WZP092o=;
        b=q8hRvO8FBlmEVVvGDqqdPymPT2VZCrOP6sdFOK85a8fzhGrEA+VPk8dRAl38JbXfAb
         pENLRXdI7wPSCGKgFbDvGVqnbbRQ1YJqOZGobDdUJevwJgsecLQ0xYQyU1R7BaKyJOAm
         aU8bjNtF5rSo+WjA633Q3G4UZXiJdP0mgMratYIzEVUbz4Yd3ALFdCr3qnjEbsQ7KGLI
         gl3imdIUYwv7AEAmQMNJsX0f1SFP7S+DAL7TLK0FN0FaOdsxR875O0AgQ0WZrUXnMyu3
         DYN8kHD7MtuD2z7RUKB5HUtduTjGtX3FHHdlziaVIJaOq47v8MTpI4KmaMgWA4Y5/SWe
         RpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28yftlhd5Mm7TNEoJztkfUFW7tsicxqlvZ58WZP092o=;
        b=lyRtK7HutDcwDViL4Dc2wfr2x8DWKAChj44J1tvUxlLZZSagx2M39li4TD4i1ri0a4
         jfCwCB6jXHSCYx4s0mqbPSebV3rfDSm6MAKg2qSUDdRx72jttxDb6/VKDeSdQiyy9tYM
         cwOgcxA10j3t2LrJXJA606DA7paWL+wNV5DAdLZeTBTj4x4akyF04So3ATgUG6DAfaa7
         nC8PLH686Dh5EYdIsERNugvCNL+iDclvoRSvtYn+5VLWawhlsaW+F2mZdcuB44Li1Usl
         6Jmi0494Hhb5b4H4uWRDOPtTAIUYV2Ik/E4249td8XTPofN8MZzCTTpgC36FO/NcbZHb
         6j5g==
X-Gm-Message-State: AOAM532Sc7/1zlToQs49Pqjwn+svdZkc+fF6jsarYVNPN8lR5IghrFpA
        ptlYuOj+lF5xprSbmGF44Phn4A==
X-Google-Smtp-Source: ABdhPJyuNO0PF0kKJURjwb9+E/B+40e84QEC1lprj6xFNjGqXis995/63N/Dg86zVL7idzJQzFY5Fw==
X-Received: by 2002:a05:6402:2066:: with SMTP id bd6mr29548060edb.211.1608040556150;
        Tue, 15 Dec 2020 05:55:56 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id b21sm18147895edr.53.2020.12.15.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 05:55:55 -0800 (PST)
Date:   Tue, 15 Dec 2020 14:53:48 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20201215135348.GC379720@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-3-shy828301@gmail.com>
 <20201215020957.GK3913616@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215020957.GK3913616@dread.disaster.area>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:09:57PM +1100, Dave Chinner wrote:
> On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > exclusively, the read side can be protected by holding read lock, so it sounds
> > superfluous to have a dedicated mutex.
> 
> I'm not sure this is a good idea. This couples the shrinker
> infrastructure to internal details of how cgroups are initialised
> and managed. Sure, certain operations might be done in certain
> shrinker lock contexts, but that doesn't mean we should share global
> locks across otherwise independent subsystems....

They're not independent subsystems. Most of the memory controller is
an extension of core VM operations that is fairly difficult to
understand outside the context of those operations. Then there are a
limited number of entry points from the cgroup interface. We used to
have our own locks for core VM structures (private page lock e.g.) to
coordinate VM and cgroup, and that was mostly unintelligble.

We have since established that those two components coordinate with
native VM locking and lifetime management. If you need to lock the
page, you lock the page - instead of having all VM paths that already
hold the page lock acquire a nested lock to exclude one cgroup path.

In this case, we have auxiliary shrinker data, subject to shrinker
lifetime and exclusion rules. It's much easier to understand that
cgroup creation needs a stable shrinker list (shrinker_rwsem) to
manage this data, than having an aliased lock that is private to the
memcg callbacks and obscures this real interdependency.
