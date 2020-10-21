Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3EE2953C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505704AbgJUVCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439588AbgJUVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:02:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37349C0613CE;
        Wed, 21 Oct 2020 14:02:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id a23so3998881qkg.13;
        Wed, 21 Oct 2020 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AieU9TT4ooG8IhHcQMgp++3eebf4OkcrIycb0MLJFJ8=;
        b=LWkQ3BmXCFBlgRMVEmpfuWCH2qPqVO3fohsqtbsJ5fcAymSsi7hVIVfbmgtSMyV7yj
         /TuKaAgB/5oBzqnroZSZNWXOb5w7nAvrU2c/LcqtwF/PaojuIjIeZfC2HMeEsVU/yNP8
         +4GIXNjuPswdjGBj41/n03S1+nJGcWN61xuQHahtgBuAg02c1fFDXxTiM07tV0YdBjW2
         ly300NjbORSBetK2Rwi9tMpt2iGSdzYO5yLj31Et+bIJhKeysuhqZyBc8lmBjh+lIvpB
         xugJ/zgBGeYbloJFr5iWvwRyzwYIgwsZLCUT2BMHex8wWYby3CzgGKUwofRjJq6zY+XW
         YnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AieU9TT4ooG8IhHcQMgp++3eebf4OkcrIycb0MLJFJ8=;
        b=gQsgx3eNlJz6KQ3nB7sB1HrgfIvhyfXKAI/E1U4URxKQkhNu5icii2x+EuSXvXVUFb
         yscIiACTNlilhV8agn3R1uMdMRlsP7tlzQaSjvCUbOck9h0RFEbDjiaUhUeerjciFpbh
         XqZCMEc2UhCoV+4M6/shP7Ptpblok0m4EZ0xiFpmIFn2nKg1TyP5zQ4yz11YbBhS4nQF
         hb3FnujrqEQNQvdBIKYh+gBQDSbBEqm4wn+YJcWFb/QqYtxOyTjpAJUm6UJ6fIbkxvu9
         iFyU45SILx+xpsUdQqvJIf+myY86oI60MdHflC9mMikJklQZc6wizjRIdMu62lyoEUAY
         0qew==
X-Gm-Message-State: AOAM533cZ9/hHlN9mOnwshz3H1ZH7jk6U43ZwP1OgHRK4ARGIz8aYFjC
        u9fIqnf0hipOhI9ysm9Hqos=
X-Google-Smtp-Source: ABdhPJxjpEEil2HY3+tmVfCD0S3mGZ9AyffDDHMNr0Hkb0vPcgGNW+wh4Tx9yEZyKV5kvKRldoX1yg==
X-Received: by 2002:a05:620a:100e:: with SMTP id z14mr4879083qkj.278.1603314163369;
        Wed, 21 Oct 2020 14:02:43 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g38sm2154683qtb.25.2020.10.21.14.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 14:02:42 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
To:     Michael Auchter <michael.auchter@ni.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        saravanak@google.com
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
References: <20201014193615.1045792-1-michael.auchter@ni.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d5f8a417-8db9-9385-dfea-9512b4680124@gmail.com>
Date:   Wed, 21 Oct 2020 16:02:41 -0500
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

Hi Saravana,

Michael found an issue related to the removal of a devicetree node
which involves devlinks:

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

When a devicetree node in an overlay is removed, the remove code expects
all previous users of the related device to have done the appropriate put
of the device and to have no later references.

As Michael described above, the devlink release callback defers the
put_device().  The cleanup via srcu was implemented in commit
843e600b8a2b01463c4d873a90b2c2ea8033f1f6 "driver core: Fix sleeping
in invalid context during device link deletion" to solve yet another
issue.


> 
> Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
> for any pending device_link_free's to execute before continuing on with
> the removal process.
> 
> These patches resolve the issue, but probably not in the best way. In
> particular, it seems strange to need to leak details of devlinks into
> the device tree overlay code. So, I'd be curious to get some feedback or
> hear any other ideas for how to resolve this issue.

I agree with Michael that adding an indirect call of srcu_barrier(&device_links_srcu)
into the devicetree overlay code is not an appropriate solution.

Is there some other way to fix the problem that 843e600b8a2b solves without
deferring the put_device() done by the devlink release callback?

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

