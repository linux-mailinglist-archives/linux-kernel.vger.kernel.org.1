Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9E283855
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgJEOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgJEOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:46:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:46:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dn5so9646488edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJDWLFQK3NHbczue04Ad/oGIga5mw5RnC9F1EX3+XdE=;
        b=hl2motqvUtv+mvTksLda5r+AFkPsIl17oAkAoCpovuZwVAOmI4uF6k4X0hrbeu5UIV
         4L63H25KQUKF8MNUkLWt/WneZgSx81pfLMMNxbhsI9ViwK7Q3zswPYsHmCMJd7yWREPt
         5ZNnY8RT6kVH5ja7Img8nnNnLSz+y+pOeFYeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJDWLFQK3NHbczue04Ad/oGIga5mw5RnC9F1EX3+XdE=;
        b=RA+kzuARX0I9nSIcHkYNfioBEmhbEZoiIomvpNd3q2e7kM/5mNAh3zwou/7on+LVWy
         hv6IhhrxdzS0++C6eY7hMDXrKnppqdnGZTODq7QcIMGEPJSNDyhKy5ExxWESyOaoitw+
         tHzlhEJn8lhn/XQSEUZrY2OvAsHPWdWOwh6GaVIHI04XB5m4cZ0n1eo30GR0DeU7K1YZ
         P6cngtRf3HFldYpwnI/GnrOaG8S1mAVw69bmyDajG/z/k5MKJV8GypIx1oeRJ+RwQZx5
         xXs4792VkPx75z+ZlGdQ/a7rEAn8TQmXpVjanUsg7UhmF/P+zxTdbKbh+DQBq103dEE4
         WA7w==
X-Gm-Message-State: AOAM531eMxrmRpHbj3b7FUiIT8m0VrKwMSckdOv3378SoElPMO6Dq/Jd
        AkvJpk1/FpQ5SdNGBsGs0wj9GQ==
X-Google-Smtp-Source: ABdhPJx3qUGwmmpBOZFS45fQE04+dVbMCBwt75MdVDrLzDmAkcFM+DYTDIcRGfMI2aS/KZIlZn93kw==
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr16283240edw.331.1601909173219;
        Mon, 05 Oct 2020 07:46:13 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:b1f1])
        by smtp.gmail.com with ESMTPSA id a5sm36220edl.6.2020.10.05.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:46:12 -0700 (PDT)
Date:   Mon, 5 Oct 2020 15:46:12 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2] Opportunistic memory reclaim
Message-ID: <20201005144612.GB108347@chrisdown.name>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
 <20201005112555.GA108347@chrisdown.name>
 <20201005135130.GA850459@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201005135130.GA850459@xps-13-7390>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi writes:
>senpai is focused at estimating the ideal memory requirements without
>affecting performance. And this covers the use case about reducing
>memory footprint.
>
>In my specific use-case (hibernation) I would let the system use as much
>memory as possible if it's doing any activity (reclaiming memory only
>when the kernel decides that it needs to reclaim memory) and apply a
>more aggressive memory reclaiming policy when the system is mostly idle.

 From this description, I don't see any reason why it needs to be implemented in 
kernel space. All of that information is available to userspace, and all of the 
knobs are there.

As it is I'm afraid of the "only when the system is mostly idle" comment, 
because it's usually after such periods that applications need to do large 
retrievals, and now they're going to be in slowpath (eg. periodic jobs).

Such tradeoffs for a specific situation might be fine in userspace as a 
distribution maintainer, but codifying them in the kernel seems premature to 
me, especially for a knob which we will have to maintain forever onwards.

>I could probably implement this behavior adjusting memory.high
>dynamically, like senpai, but I'm worried about potential sudden large
>allocations that may require to respond faster at increasing
>memory.high. I think the user-space triggered memory reclaim approach is
>a safer solution from this perspective.

Have you seen Shakeel's recent "per-memcg reclaim interface" patches? I suspect 
they may help you there.
