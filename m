Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC12CDC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgLCRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgLCRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:38:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E959C061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9JV3l87i7qLuKjrvGVIBLbXpO5mZxmVEIeZIIj4DDBE=; b=aj9cu+XYV8TCyhcLCZh0/WjBjV
        uYmmIxruOBzucXfBghia+f98ozsoaToftIyylqh8O4gT6AC9VGzRIaGYoU7f0agEh7aD40D87ukul
        vq/ZZP7tWjPlnuDMCvyCGwcNCEGKdetpzdCACMcHnzrVAGKQybkGU2kBP08KDZjeq3izr28Z5FQAl
        1PvYFz1q4AV3n9IaxFGX5PdYbtevBqNtzsgcGtn5byE5ZnEHbipEwY+3xFEjx3Pc7x2nV1yfTve3k
        PeIBUX4TEZMgLMOXJA1T0Ede7h70oG7xTXvyKYHNt5uDJzCBUH5nWfsDVK4sTO64CCie3utaAFlVi
        bGHnw7Nw==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kksYE-00060O-CT; Thu, 03 Dec 2020 17:37:54 +0000
Subject: Re: [PATCH v3 02/19] vdpa_sim: remove unnecessary headers inclusion
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-3-sgarzare@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e55ab39-afdd-f47b-55ec-a2bec4ab4cec@infradead.org>
Date:   Thu, 3 Dec 2020 09:37:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 9:04 AM, Stefano Garzarella wrote:
> Some headers are not necessary, so let's remove them to do
> some cleaning.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Hi,
What makes you say that some of these are unnecessary?

Please use Rule #1 from Documentation/process/submit-checklist.rst:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


so just because it will compile without these headers being explictly
#included does not mean that you should remove them.


> ---
> v3:
> - avoided to remove some headers with structures and functions directly
>   used (device.h, slab.h, virtio_byteorder.h)[Jason]
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a90fdb9cbfc..b08f28d20d8d 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -7,20 +7,10 @@
>   *
>   */
>  
> -#include <linux/init.h>

above is used by __init and __exit.

>  #include <linux/module.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/fs.h>
> -#include <linux/poll.h>

Looks OK to remove poll.h.

>  #include <linux/slab.h>
> -#include <linux/sched.h>

Might be OK for sched.h.

> -#include <linux/wait.h>

Might be OK for wait.h.

> -#include <linux/uuid.h>
> -#include <linux/iommu.h>
>  #include <linux/dma-map-ops.h>
> -#include <linux/sysfs.h>
> -#include <linux/file.h>
>  #include <linux/etherdevice.h>
>  #include <linux/vringh.h>
>  #include <linux/vdpa.h>
> 

I didn't check the others.


-- 
~Randy

