Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D181ADFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgDQOZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgDQOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:25:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A241AC061A10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:25:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g30so1141395pfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L6cWP5WK6ujku9y43wjaNC6S0VeElTh4yenPv8t29Ak=;
        b=gKw5eoYUIpd77RsZ9EA4/OBI5it3b4QtTk5w0WNiaVsQlhU0AvTC99Kwb6pyQrnZwb
         8mkxqNjg6VEOZTZqnkLOebZlO/n/v5mMNjfkBB1cGO3Fx7O3pVDrmTfYyuyYufQ9ccR3
         RtPWKLjDzCOGMUWt9saeSwmpszseuFa+iiXqlLA7QMz5NdgXvU//k288EsKe0YfAzi6u
         dvmxk+qgp7K7fE2PnVT7fvqSgeWduMN7B1pblLGgZqKs3H1NpzAxQ5FN/ffFSwvnE0Dr
         z0qCKxdTOrenMDSXdIXvCN19QGBDvsZe/1e/6pTgbuMcknn8YL4CeODkrzae32Dl8ywr
         FA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6cWP5WK6ujku9y43wjaNC6S0VeElTh4yenPv8t29Ak=;
        b=D/gHdUalubj2c86bHPhFXZEiID/6wGx7O+mdeHU+6AldcLSjLBIE8vTaXAxq2npmc/
         KrMQ7Z3QUhfg7t1qOzSqz5fjXxFxF2d/IukLNOAhoBaKOol5PugwiTWd5UOeaCnAtLu1
         q2pZ20vA5YIwvGeWTfGjHQS74gHd+ErctuNDGMHpx1xCCfZvmQvvBMFKX7O4yUmbsOgw
         rSisvcZ74hCdudtYaW+nIyMyFPsXjdERaXhRJ5Mlae2HdjNGfLbBskMmTIigBbgViNds
         oagh1M3ZkzS2i/hDgbcjzJ6ZtkqIZ9k+pvpPVlhd6UUKAW5LTfKAK4ilqKM39eaaN337
         p/lg==
X-Gm-Message-State: AGi0Pub5yAO65kS8taV0L7JjJ0KL1ICFrnUPc6Zdyk1agOK14ecjwRI7
        A+rmdgCbv7eetD4Z+SyY+sQZfw==
X-Google-Smtp-Source: APiQypLk3UKQ7IlVU68RBsk4YcfumTB0+HNr5I6KmasWP50lwGXPB60OmHhJAmy9VXUBKXWGkLn5iw==
X-Received: by 2002:a63:1662:: with SMTP id 34mr3312317pgw.117.1587133542614;
        Fri, 17 Apr 2020 07:25:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r18sm579944pfg.120.2020.04.17.07.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:25:41 -0700 (PDT)
Subject: Re: improve use_mm / unuse_mm v2
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
References: <20200416053158.586887-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d314bc3-ea59-684d-2d34-20b152a36f4f@kernel.dk>
Date:   Fri, 17 Apr 2020 08:25:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416053158.586887-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 11:31 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series improves the use_mm / unuse_mm interface by better
> documenting the assumptions, and my taking the set_fs manipulations
> spread over the callers into the core API.
> 
> Changes since v1:
>  - drop a few patches
>  - fix a comment typo
>  - cover the newly merged use_mm/unuse_mm caller in vfio

You can add my reviewed-by/tested-by to the patches, passes the
io_uring regression tests.

-- 
Jens Axboe

