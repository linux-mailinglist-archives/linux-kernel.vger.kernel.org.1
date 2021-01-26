Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8865F303A39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbhAZK23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbhAZBbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:31:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C429BC061221
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:51:07 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b17so2193183plz.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uPJlUchjV+OaTIftOWbXEjVwG0d/bApny8LKz3OH9do=;
        b=Fn4EVg48BXJQ0XVCGo4P1/CcZQYyaUjR593N0Mrt0Pa+QokgKItCP+8Jqv/2LG0i6e
         ZOE+o7Kp6TSk5kE5z/p+B9iYW/TEKeeUZ38hHU2REBudTZapniqQIgruui5UYR2CX3jM
         XMAbvuY6JHqMBPOAxvGF/pd+dD2JXyjuQuYgOdpBoKEe5OkwN21A1Oz9evbFfBDmAQvY
         7WFdRbpEZ2liR9Ig+qsbIiWSj+GDDvognZEVlwuSJJV6ndniZaVtaxhiGOys5MNoWytQ
         gQ7Z3yycyJCcMckSCcJGV82qUswKaz/f7sRYaD0P22YuS9ZNrnmyYgBqU8O8EcKu5dJk
         dg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPJlUchjV+OaTIftOWbXEjVwG0d/bApny8LKz3OH9do=;
        b=AzMG6QKzpwqqigffn0i9iU7DmoUshKfef2Cbro+boMpbqRrGO9g0G/zTBvhreRZVDr
         9iNbupo3aPLPP11osGDdCdCYZk99+vNa6FNVvzwOMguB1tMhjQate20VHSvbXbbR3for
         FlbZJO90TcZEBVmvVMssVs6Z3WqgUnmaX2vD4tIMeuBOWeVy1C0rwOp62UsFixrhpr3N
         Grr6M8Dimij2K4Z+L92fqcMZXb5fd3jk61G8bXBMrA1bQeFz/fRycoFZAsjYYWcz7QzF
         aj2ljblIXqm2Uf52mx7KYO6Aa3rzF5uEqBUCvwChjJhm0duqI5gt35M+qWRRrlsSriw6
         FmpQ==
X-Gm-Message-State: AOAM533xZ4DinEiLNy/2eucSwl1890CeQ+f1x6Hr7WD3rp3HSvY0oenO
        WZZx3/89doTkNjWot0X/e/guGA==
X-Google-Smtp-Source: ABdhPJzzs4C/lNGU5gJfjXLgueQ6h//2HOCs2JEgJn8fHs+SjPK/bp53wfdpI/yc0gqOKDwXYe/jwg==
X-Received: by 2002:a17:902:c284:b029:df:c0d8:6b7 with SMTP id i4-20020a170902c284b02900dfc0d806b7mr3120918pld.34.1611622266246;
        Mon, 25 Jan 2021 16:51:06 -0800 (PST)
Received: from [10.8.1.5] ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id r7sm3940119pfc.26.2021.01.25.16.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 16:51:05 -0800 (PST)
Subject: Re: [PATCH v2 08/10] md: Implement ->corrupted_range()
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
References: <20210125225526.1048877-1-ruansy.fnst@cn.fujitsu.com>
 <20210125225526.1048877-9-ruansy.fnst@cn.fujitsu.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <6100b7ca-7968-e1ea-84b8-074dc216a453@cloud.ionos.com>
Date:   Tue, 26 Jan 2021 01:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125225526.1048877-9-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/21 23:55, Shiyang Ruan wrote:
> With the support of ->rmap(), it is possible to obtain the superblock on
> a mapped device.
> 
> If a pmem device is used as one target of mapped device, we cannot
> obtain its superblock directly.  With the help of SYSFS, the mapped
> device can be found on the target devices.  So, we iterate the
> bdev->bd_holder_disks to obtain its mapped device.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   drivers/md/dm.c       | 61 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvdimm/pmem.c | 11 +++-----
>   fs/block_dev.c        | 42 ++++++++++++++++++++++++++++-
>   include/linux/genhd.h |  2 ++
>   4 files changed, 107 insertions(+), 9 deletions(-)

I can't see md raid is involved here, perhaps dm-devel need to be cced 
instead of raid list. And the subject need to be changed as well.

Thanks,
Guoqing
