Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBD2E9645
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbhADNqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:46:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839EFC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:45:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m12so64380549lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 05:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjj6uZMAh4bwqWKMhZWRFG4e725F45DY+i8GEvjt0RE=;
        b=dSG5hKrjTah0OQ6XYQ2SGfwkLcoZzvrowwwGGP1ej43f5r8iO6TJLsN+Ieu2YdVYPJ
         xHJLjyQr8J/MQOiXOdBlDXYTnBg93WZz+qZDCGVE0OSFIzTH4V4zTfXvvmB53LtBt6CX
         gYqgvzeMAm1UwkUzt1c2GR+vcCV5wv9C2bc1vyu+/tzU0wMeuWSDKSsaO9Uqf+K9PjKg
         nnfHY53JCWoQS8/avWXfmDjmEjPTI/j0d3m8ns7eaoDKB3eGXGcca9ae7WNwxyaIMU+l
         nEoClrvSUj/dsx1rqKSRR9jlDPokbQPRkxrf3wiXzlPBK4HMvypfA/F17cpnFl7zXI4h
         Yn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjj6uZMAh4bwqWKMhZWRFG4e725F45DY+i8GEvjt0RE=;
        b=JCwUoFwrcOvComY6YC1ykmChVyAjgg+5pZAFKmGcGT4qNDCv0Wbei89IiqHyQzKbYC
         OFPj09uhVX4D94NObpCtf8KDUWctnijpxpyTMUFx/VkXxX0t8PHmJgChyzher7yN+Xtf
         1IxOHoSzWajHiWf2CJ3xk8vHZb8GgLHfAwSXVpHhFVFdYbPnlQVRAABtx6DHuwGMpkKA
         oijDJfkubqiXf5WKnodF5U93eejWPkXgAuBno3BBReLvZ6twwD0XDyFcr7IbGTB+8UvY
         6x9f48cB2gMupo/WEgELGor9yxBdeIOjWGd6wZ2hlFv6VTkkpcxy9MGzC4AclU3PDgu6
         OtSw==
X-Gm-Message-State: AOAM5308HS3MbHNfy8y2PHMxip1bqFsVovEqNZK/OATLDqwVpvxsYPhR
        EIoRoOS5u+9V4lQDME1hsOsifHXn/fI1f3TWm1A=
X-Google-Smtp-Source: ABdhPJxrOCIQRY85pxpq3s2QrJ2pl7CAhLmIZRFBlKzXWqfUyFWtvbyBVa4uiC2Q7qFYavNPyc/W/hgqV+Atv99q+I4=
X-Received: by 2002:a2e:154b:: with SMTP id 11mr34263557ljv.22.1609767929125;
 Mon, 04 Jan 2021 05:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain>
 <20201222122312.GH874@casper.infradead.org> <CA+2MQi8GMLfSFN30G8EEeXXsC5M+Et2oRMnynUp==eRbY0Z2Wg@mail.gmail.com>
 <20210104125122.GD13207@dhcp22.suse.cz>
In-Reply-To: <20210104125122.GD13207@dhcp22.suse.cz>
From:   Liang Li <liliang324@gmail.com>
Date:   Mon, 4 Jan 2021 21:45:17 +0800
Message-ID: <CA+2MQi9900FU9+=j7EM2YEH5=Dg0wH9-GvfZDhop6kGO_=a2Pw@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Win or not depends on its effect. For our case, it solves the issue
> > that we faced, so it can be thought as a win for us.  If others don't
> > have the issue we faced, the result will be different, maybe they will
> > be affected by the side effect of this feature. I think this is your
> > concern behind the question. right? I will try to do more tests and
> > provide more benchmark performance data.
>
> Yes, zeroying memory does have a noticeable overhead but we cannot
> simply allow tasks to spil over this overhead to all other users by
> default. So if anything this would need to be an opt-in feature
> configurable by administrator.
> --
> Michal Hocko
> SUSE Labs

I know the overhead, so I add a switch in /sys/ to enable or disable
it dynamically.

Thanks
Liang
