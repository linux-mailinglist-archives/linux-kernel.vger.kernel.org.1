Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9422E96CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbhADOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhADOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:08:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DAEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:07:19 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so64547614lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Noy6r1/WTM/FuD2jphA2uWS50pb5obVRw55AkQ+95cI=;
        b=LOnFTpkM+pp+xw2QIahN/58KTeXTmZmogfFOQDQZrae2dqqSUCXJi95ZHh+CGC80Za
         CIzV1m3shttpaF2xef8iCMVq7PkWeaB0pov7RFanNH8+qpm+oFIrBxpBCv0yQnyriY0K
         MRsXskenCYPZ/cvgb9XRtCDBB5RnpemEt5cRDLRPe9jkH7OvoIYjnOAJ2rnrcX5wWBhb
         Ypag2OXD3vpswjnX+xhRsSGRDjvZ7/p6RFrekWVs6y12QPsLXSzT2qmgUbPgAQLH3I2u
         Sg7g1oGOFo2V6Lx92H89iJCEROZmEGIqUCKS5HS3h1MemaMX4RRpFOZj1wnvzE0Py4BL
         4/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Noy6r1/WTM/FuD2jphA2uWS50pb5obVRw55AkQ+95cI=;
        b=pvdAcZ4BkP5I4PwM4gFwaVN19qt7+ep1BCYTQoKBqtKJEu3FuHu90sfdVWJIhw7AND
         hJdZdJhiKmCTrhXC2tB5ztiDD4ZRr3PivavVj1DUphj3rcI12SSPlkI4NpR/CmitvjZc
         rkcDUlhOjZO1g8ELtFh9R1qPqMfTRyaDWnlvzLkS/4b1uYqtB+p7sw/3KkFBX0+PUMGz
         3RVODO9bdRCMyZw9HyscDQd3D3xNtaYnt2vePuXGGkzQQfZR8ZFy4ZzhVaLKpANu4MfD
         pU9HQ6qvHK7Ix1XDf+uUCkUsR14/9ce/ARv9JO9FPIS4FWJdza077VvZQ7KnC8V3cFsG
         LWqQ==
X-Gm-Message-State: AOAM531sw3axENRfUg3X4crWW88maK+zXfHjLdTlIYDknC2LFHcgGS39
        7yhsnwtSoNSvZrS+/Q3iEYX0PrXy/cK2lTmryCc=
X-Google-Smtp-Source: ABdhPJxmxsxVDFpbXZxv3wxt4WJzq5x+LhWqUBlh10IEtDlXJufp57gIWF5eSR7AeUPhDlbdZuI/azYJnM1F0ktp4MQ=
X-Received: by 2002:a2e:154b:: with SMTP id 11mr34295269ljv.22.1609769238030;
 Mon, 04 Jan 2021 06:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain> <20210104125554.GE13207@dhcp22.suse.cz>
In-Reply-To: <20210104125554.GE13207@dhcp22.suse.cz>
From:   Liang Li <liliang324@gmail.com>
Date:   Mon, 4 Jan 2021 22:07:05 +0800
Message-ID: <CA+2MQi9iViYq7+apaJEymt8rZxUuo+9EJN4x3_RRydjr7-vwMQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Michal Hocko <mhocko@suse.com>
Cc:     Liang Li <liliang.opensource@gmail.com>,
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

On Mon, Jan 4, 2021 at 8:56 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 21-12-20 11:25:22, Liang Li wrote:
> [...]
> > Security
> > ========
> > This is a weak version of "introduce init_on_alloc=1 and init_on_free=1
> > boot options", which zero out page in a asynchronous way. For users can't
> > tolerate the impaction of 'init_on_alloc=1' or 'init_on_free=1' brings,
> > this feauture provide another choice.
>
> Most of the usecases are about the start up time imporvemtns IIUC. Have
> you tried to use init_on_free or this would be prohibitive for your
> workloads?
>
I have not tried yet. 'init_on_free' may help to shorten the start up time. In
our use case,  we care about both the VM creation time and the VM reboot
time[terminate QEMU process first and launch a new  one], 'init_on_free'
will slow down the termination process and is not helpful for VM reboot.
Our aim is to speed up 'VM start up' and not slow down 'VM shut down'.

Thanks
Liang
