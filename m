Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71DF28FAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgJOVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgJOVeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:34:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE48C061755;
        Thu, 15 Oct 2020 14:34:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q26so409500qtb.5;
        Thu, 15 Oct 2020 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8mdlzifETD7dDuA1V3YKKF+U9XTqlEODnK2lvnXX8zE=;
        b=uKyqjiLAm8LXPyz0bkIR6peoreT/vMSjZlV3h7LzOA6c6I0uX7c/bIOEA7M+VRlB5t
         4S6si8clfoTSqtAS4kuONir7ltmQQuz3YltaOsdCAz0KYm8om0D173SEaYm5Q7puVVLK
         bQP7REoi9lKkPNT8z9KYLZ0u88dbXyAhhHAWQCRvuZK0HbITHfqhk8OXo8lt3izf0FxN
         hdI8eprx8e9SKsAW9QwLmWNbqPylYENDoEG5NpHCd5DsP0I9qRBOE4uyvr5H9i/sRIjL
         DVW53Lf+x+qHOdHy9svh3jqDf3TJLOwA96YD/RovKI1fIfAzoiyB9on/wWD9ibrAf5uu
         3OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8mdlzifETD7dDuA1V3YKKF+U9XTqlEODnK2lvnXX8zE=;
        b=ji/rO/2/HeyfH3/b5JR4sfB2udZYtyvSt5VzvfHTfga+piIoCrnpwptotPrvtb4Lg/
         JSnApvwKVmO+xq5+QsgAWOGyqJBkVUBgkDYkyuEdDj2HQ4YE5SAQegIMkVoCj5GBkX/f
         mGpHGdxn8SZ7JABz1+XCMdT93xzWiIdGIYfqxgtaUfeNGFGJy9gV301mOfdA41gLKzUi
         AKs6pJN33EHux6quIgfGqKliwNdTI6OHGhiCU5GKkQlosfw1fuhLp5J+Dxq7p/dCXAMl
         LyFMONguOxVdr5TxkB8y6sIOCw+kELpqDEDMAAjYMiwF4C9uKF60dhDyevi8ezNciKqj
         Tkwg==
X-Gm-Message-State: AOAM530icO/GPWGDxhQMc4iafL6y8XBqTXmoqFoBfXxQ0Qi0sZMhOBHp
        9gePK6Ow0SvwD4har3AQQMc=
X-Google-Smtp-Source: ABdhPJxYVzslPxZmQVqTEb18qiPnUfZjT7AMkQGFO0v2P8KO5mXkcRKEvxEBsw1knmTlZfHSecuUMg==
X-Received: by 2002:aed:2ce5:: with SMTP id g92mr364144qtd.107.1602797689037;
        Thu, 15 Oct 2020 14:34:49 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id r8sm81317qkm.115.2020.10.15.14.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 14:34:48 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
To:     Michael Auchter <michael.auchter@ni.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saravanak@google.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8c123831-1a35-0a28-d583-5bab4735edfd@gmail.com>
Date:   Thu, 15 Oct 2020 16:34:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014193615.1045792-1-michael.auchter@ni.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 10/14/20 2:36 PM, Michael Auchter wrote:
> After updating to v5.9, I've started seeing errors in the kernel log
> when using device tree overlays. Specifically, the problem seems to
> happen when removing a device tree overlay that contains two devices
> with some dependency between them (e.g., a device that provides a clock
> and a device that consumes that clock). Removing such an overlay results
> in:
> 
>   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
>   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> 
> followed by hitting some REFCOUNT_WARNs in refcount.c
> 
> In the first patch, I've included a unittest that can be used to
> reproduce this when built with CONFIG_OF_UNITTEST [1].
> 
> I believe the issue is caused by the cleanup performed when releasing
> the devlink device that's created to represent the dependency between
> devices. The devlink device has references to the consumer and supplier
> devices, which it drops in device_link_free; the devlink device's
> release callback calls device_link_free via call_srcu.
> 
> When the overlay is being removed, all devices are removed, and
> eventually the release callback for the devlink device run, and
> schedules cleanup using call_srcu. Before device_link_free can and call
> put_device on the consumer/supplier, the rest of the overlay removal
> process runs, resulting in the error traces above.
> 
> Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
> for any pending device_link_free's to execute before continuing on with
> the removal process.
> 
> These patches resolve the issue, but probably not in the best way. In
> particular, it seems strange to need to leak details of devlinks into
> the device tree overlay code. So, I'd be curious to get some feedback or
> hear any other ideas for how to resolve this issue.

Thanks for finding the problem, analyzing it, creating a unittest, and
creating a fix.

I agree with your analysis that there are issues with the implementation
of the test and fix.  I'll dig into this to see if I can provide some
useful improvements.

-Frank

> 
> Thanks,
>  Michael
> 
> 1. Note that this isn't a very good unit test: it will report a "pass"
>    even if it fails with the aforementioned errors, as these errors
>    aren't propogated.
> 
> Michael Auchter (3):
>   of: unittest: add test of overlay with devlinks
>   driver core: add device_links_barrier
>   of: dynamic: add device links barrier before detach
> 
>  drivers/base/core.c                     | 10 ++++++++++
>  drivers/of/dynamic.c                    |  3 +++
>  drivers/of/unittest-data/Makefile       |  1 +
>  drivers/of/unittest-data/overlay_16.dts | 26 +++++++++++++++++++++++++
>  drivers/of/unittest.c                   | 16 +++++++++++++++
>  include/linux/device.h                  |  1 +
>  6 files changed, 57 insertions(+)
>  create mode 100644 drivers/of/unittest-data/overlay_16.dts
> 

