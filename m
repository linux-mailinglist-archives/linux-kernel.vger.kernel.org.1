Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CCE2EA501
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAEFns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAEFnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:43:47 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005BEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 21:43:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jx16so39691665ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 21:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CmvrTwTOLCxJGYA+L8vnsRq7pQdWjB2uBzHiEQLghE=;
        b=DFQdiZejzRJBlir0ay06r5fcQjz1D4NsJMshTXAaljvFFeyP7wL9+zPXDd7Iq0AOIS
         K9SYOsvsRghXdb/P9VdoFn4vse4IhNSpWOdZ8PPLRLrjqGNx+D8+B5uzjwvdcf6xuI8U
         am6QCDKfMmrsKEd9PynpGihEhDpF/Ak0JDCvmiXWf+z43jJDYNyWcbG1ZNiE8Blw5+s9
         x+JgMNkpd/uvGISykRZZAEThjgfWVxU+qy1NJB4oPrYxekRVqZ6PUoVmp5/iogkGIg9I
         Kiy5epIb330ep1CdBZ9hpKsYiql2JVan0j3qpRncU5e/LQTccmQ1D1RJBaxlnreEa1lr
         ooBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CmvrTwTOLCxJGYA+L8vnsRq7pQdWjB2uBzHiEQLghE=;
        b=jXH4JBIrVLOpGcLJBoHgxMxPKG1cAIj2ch+LS8fZl5Ki6SDnnlU3it3IgoZUHpRB66
         TbuEHWwYBjpg3tGtaQvp5OJUSxVvHdH199k9UExFRzL6mT709gteFBgDN1qUV8zdsjRO
         xD4HxO+WTRjYqc0Vq9LXNeI0f36N0LBDDvtCGIya2iBknPoi99xtOCOJG0zjhe7FgDdQ
         j3QdqBdBiZEPCr55zji4FLcto7XHDHpuaXPFweTAj7N4uPuMd8V36YETXdF1600k/YCU
         cpMf66NDM9W7NkofpAvKp1ZznYpQdX5H7PFeEmLG76cAJQXSHTkiOYoSNV0qbfObgt1A
         bc5w==
X-Gm-Message-State: AOAM533Jt+ck+fx3Rn55Hth3UrGm0dPobo5si10TsKxZd8OaAquLP465
        4z6sTyvV3cKNLG7WCifigEtLyyuY4B1nsutGN5SVpg==
X-Google-Smtp-Source: ABdhPJx7m/Sf0ohBHUMCtWefo85ADNjmKH0VHW7sKIZoRIr8AXB9Bw3Shm9m7fih9e4QeOv1njHPYp+1UN1nW3Djk94=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr68498113ejz.45.1609825385802;
 Mon, 04 Jan 2021 21:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20201231053156.24276-1-zhuling8@huawei.com>
In-Reply-To: <20201231053156.24276-1-zhuling8@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Jan 2021 21:42:59 -0800
Message-ID: <CAPcyv4i9mn7SJ6CSY4uH_74f6pRny5aLQhg6Ubf3cDw8kJoWzg@mail.gmail.com>
Subject: Re: [PATCH] arm64: add pmem module for kernel update
To:     Zhuling <zhuling8@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, luanjianhai@huawei.com,
        luchunhua@huawei.com, sangyan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhuling,

On Wed, Dec 30, 2020 at 10:18 PM Zhuling <zhuling8@huawei.com> wrote:
>
> Category: feature
> Bugzilla: NA
> CVE: NA

These tags can be dropped.

>
> Use reserved memory to create a pmem device to store the
> processes information that dumped before kernel update.
> When you want to use this feature you need to declare by
> "pmemmem=pmem_size:pmem_phystart" in cmdline.
> (exp: pmemmem=100M:0x202000000000)
>

Interesting. I like the feature, but it's not clear to me that a new
command line based configuration scheme is needed. There is the
existing memmap= parameter that on x86 describes a
IORES_DESC_PERSISTENT_MEMORY_LEGACY range. The driver/nvdimm/e820.c
driver could be reworked to attach to the same thing on ARM64.

Then as far as assigning memory to different kernel usages there is
the existing capability in libnvdimm to attach a "personality" to an
nvdimm namespace. I imagine you could write a special signature to the
namespace that libnvdimm would recognize as a KUP reservation
namespace and work generically across any arch.
