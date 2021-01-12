Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646A22F372A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392852AbhALRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbhALRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:31:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E060EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:30:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n7so1888826pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdTRu5tlj/A3yBDzJivXQhUbmV9kR2B6mc01lpwlJu8=;
        b=RZ/5dMMonUTO9uwDF4pLhzmX9iV9siHtpHS8tn8hJcEmD4EfymPs2hg5s1T9cx0ATz
         dLpYTPPbyoRxH3P5VSLCIVFmj9tnEVansZQL2IJJmKQR6dZNa9AmudWjqHSQTBn5Gqu3
         nGJ0JffzpNvhC03FDQe8N1JqYgLXogyfShpwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdTRu5tlj/A3yBDzJivXQhUbmV9kR2B6mc01lpwlJu8=;
        b=rnH8kbgarp7Q5903p6YkJH4RfYu0LZil5LhirtT/RCMI1a8o184gAd0/8W9fsSc00C
         5ttp6Dirky2sn2keWTFxC5SnRZshtniOmLnOvjd9utU1nKoOxXJ4HGHvfWV71DOgz3mZ
         b9yBpKGPm9zefG+dEpomcWd4tiWK5P1wmhldDOQtBX7lcjEAVNI/j5eHOgAryOKFxmPx
         JbftSBsxH92wHJs9GZmc08zJQnZRugc/U8rh4f5mhsMJVwjN9vpNxUoKG+um2TDtpJ2b
         AD3L2/9PK0qcnfezTGJUUo7YuRdlpf/V8Worfc0T1Zl+zB2sv9sdvYdWNqvH9iCwo0qx
         kQ3Q==
X-Gm-Message-State: AOAM532eT3UTZnmY6z0k2LBGsHbdaEs49zTtzps+0MjGLXYvAXe35ht8
        QuuB8CpdPJpJrUuex5oWSKjUIAYj7bvAmA==
X-Google-Smtp-Source: ABdhPJzMKQx3DoJR2OewHw8Nh5bUmiaIAGtOtMJzX2jEh38fP63P0Grlpv6Y89dXjIkc2LEhFcqxcQ==
X-Received: by 2002:a63:6e8f:: with SMTP id j137mr126332pgc.416.1610472648419;
        Tue, 12 Jan 2021 09:30:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g16sm3502796pfh.187.2021.01.12.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:30:47 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:30:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [PCI]  dc83615370:  will-it-scale.per_process_ops -1.2%
 regression
Message-ID: <202101120927.B3345B30@keescook>
References: <20210112141045.GD30747@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112141045.GD30747@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:10:45PM +0800, kernel test robot wrote:
> FYI, we noticed a -1.2% regression of will-it-scale.per_process_ops due to commit:
> 
> commit: dc83615370e7ebcb181a21a8ad13a77c278ab81c ("PCI: Fix PREL32 relocations for LTO")
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/kspp

O_o Well that's surprising. This only creates stubs.

>                                 will-it-scale.workload                          
>                                                                                 
>   2.14e+07 +----------------------------------------------------------------+   
>            |.+. .+ :        +  +.+.               +.+. .+   +.+. .+  :      |   
>   2.13e+07 |-+ +    :    +.+       +             +    +         +    :      |   
>            |        :   :           + .+.+..+. .+                     +.    |   
>   2.12e+07 |-+       :  :            +        +                         +.+.|   
>            |         +.+                                                    |   
>   2.11e+07 |-+                                                              |   
>            |                                                                |   
>    2.1e+07 |-+                   O O     O  O O   O     O                   |   
>            |                 O O     O O        O   O O   O O               |   
>   2.09e+07 |-+         O                                                    |   
>            |         O   O                                                  |   
>   2.08e+07 |-O O O O       O                                                |   
>            |                                                                |   
>   2.07e+07 +----------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample

But it's pretty clear _something_ has happened. We'll investigate...

-- 
Kees Cook
