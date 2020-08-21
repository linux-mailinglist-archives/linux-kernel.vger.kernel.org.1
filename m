Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA424D535
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 14:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgHUMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHUMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:41:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FDDC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:41:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so1653146ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQ8YtZUq2JY+BH1jqqQCLSvh1WL0FVc7UY1mYQp2AQM=;
        b=Ehr1XCOBzdD5uog8ufwc8p/ZeibsGALJ/DPSRGA30L6oGq3HsS0KFwdyYUsug7ybHg
         uQac9t59HdWh/sctxLtx59MZmp9zKkXTcoNFgYd3aDVl9zN5KUBN1oZjufXKLn1TDuXt
         Wtw75wC4NFAvIaPTbdwVKS/HWohfj3La+pWL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQ8YtZUq2JY+BH1jqqQCLSvh1WL0FVc7UY1mYQp2AQM=;
        b=Mtb20piS/UYeOZmQxnuNOBxYp+rCpPBcfSvYmivdpGeBUe4n64ut3GNupfXwxubTj5
         Mkdef/VbLxDKsKSjusfqIXYD5mKsYTw2Td3AXrvx1GZ7gAjHNg1PK36SLP5tg4Zrp5de
         edAFHlTN7j779+FyZMr8eDGut66XBTejFgIILhrF3iaMGxPaO2nrRsinkoinxmDjE/Ql
         1UnBGoj/NMyKJ7hush34Hz5gMTcfbAwC5DgGX5Aeml6WfUuPB/4JQGwqj6og9ojaajqR
         nBx5f4BsjEbUOs87aRTLGP7YO+izUcbAu746b6wwP7Z0T04t0l0yMGFFI71au4WXybIb
         P1eg==
X-Gm-Message-State: AOAM533ZYJCzihN8GmauIJcfy5wUjjS02F4451M6F5LluhP9EXR/Zzuq
        4wce85qHbhm1wGr5NgE3OiF7q3sJ0nRBMg==
X-Google-Smtp-Source: ABdhPJyPdAGMT+EnupUkes03p2cxV44HtW43PeCJVu3GQx5X6BjVk4dg5VFgWKbaoQBoIuZy9o4nSw==
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr1315840ljo.256.1598013680721;
        Fri, 21 Aug 2020 05:41:20 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a2sm375612ljj.40.2020.08.21.05.41.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 05:41:19 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id b30so833950lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:41:19 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr1384989lfa.192.1598013678967;
 Fri, 21 Aug 2020 05:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200821085011.28878-1-chris@chris-wilson.co.uk> <20200821085011.28878-2-chris@chris-wilson.co.uk>
In-Reply-To: <20200821085011.28878-2-chris@chris-wilson.co.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 05:41:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiu1WHD0x0VXKoLQGy43S7KLCY=Yd-TPDh=7tDW08554w@mail.gmail.com>
Message-ID: <CAHk-=wiu1WHD0x0VXKoLQGy43S7KLCY=Yd-TPDh=7tDW08554w@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/i915/gem: Sync the vmap PTEs upon construction
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 1:50 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Since synchronising the PTE after assignment is a manual step, use the
> newly exported interface to flush the PTE after assigning via
> alloc_vm_area().

This commit message doesn't make much sense to me.

Are you talking about synchronizing the page directory structure
across processes after possibly creating new kernel page tables?

Because that has nothing to do with the PTE. It's all about making
sure the _upper_ layers of the page directories are populated
everywhere..

The name seems off to me too - what are you "flushing"? (And yes, I
know about the flush_cache_vmap(), but that looks just bogus, since
any non-mapped area shouldn't have any virtual caches to begin with,
so I suspect that is just the crazy architectures being confused -
flush_cache_vmap() is a no-op on any sane architecture - and powerpc
that mis-uses it for other things).

                   Linus
