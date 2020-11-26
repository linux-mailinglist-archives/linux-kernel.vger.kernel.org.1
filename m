Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5A02C57E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbgKZPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:12:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15384 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390351AbgKZPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:12:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbfc5e30000>; Thu, 26 Nov 2020 07:12:35 -0800
Received: from [172.27.12.84] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 15:12:33 +0000
Subject: Re: [PATCH v2 00/17] vdpa: generalize vdpa simulator
To:     Stefano Garzarella <sgarzare@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>, Oren Duer <oren@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <751e8938-8055-511c-c339-2b55dc902944@nvidia.com>
Date:   Thu, 26 Nov 2020 17:12:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606403555; bh=vtGXiLJGj14rKPmHhudnMAtjCzWUYwLzn0s8yBeVSHw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=XhwI+JIouPOqtJ2VNtrmoSq+4SZ2mCWLlNea1Nh3lPvUjlJX3ieQIORafSVTtqj9s
         egoEZCfp4HBl8F3Zqp20AIn7L89aMaB2ZN8ikaSctz7G0Dh/54B6tTLKILDnnohs3a
         uDLkQJPprJNfGv92M+eGrML0/3dKvFxhtGx3615lo3B0MIwif01ouS0TxS36C3ojly
         8KIX1I80Zi0kxFWCDdoRGCuUgJ25oFnXW6mNX6clk+NgpCRdJiSMhhCdlelsZs/VAO
         fLA7PKjKx0zvnrXOdY+Ny7hZXcLeZ+m9le0cAkYkH2yIg7qOYBvDfey8Uh6wYBhLSD
         nQXXh8B/DNPrg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2020 4:49 PM, Stefano Garzarella wrote:
> This series moves the network device simulator in a new module
> (vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
> module, allowing the possibility to add new vDPA device simulators.
>
> For now I removed the vdpa-blk simulator patches, since I'm still working
> on them and debugging the iotlb issues.
>
> Thanks to Max that started this work! I took his patches and extended a bit.
>
> As Jason suggested, I simplified the "vdpa: split vdpasim to core and
> net modules" patch, moving some changes out in small patches.
> @Max: I put your Co-developed-by and Signed-off-by tags on these patches,
> let me know if it is okay for you, or if there is a better way to give
> credit to your work!

Stefano,

thanks for taking my initial series and bringing it to upstream level 
and thanks Jason for your reviews.

I'm ok with the tags and hopefully I'll be able to help a bit in the 
submission in couple of weeks.

great progress !


> v1: https://lists.linuxfoundation.org/pipermail/virtualization/2020-November/050677.html
>
> v2:
>    - moved most of the patches before the vdpa-core/net split [Jason]
>    - removed unnecessary headers
>    - removed 'default n' in Kconfig entries [Jason]
>    - added VDPASIM_IOTLB_LIMIT macro [Jason]
>    - set vringh notify callback [Jason]
>    - used VIRTIO terminology for in_iov/out_iov [Stefan]
>    - simplified "vdpa: split vdpasim to core and net modules" patch,
>      moving some changes out in small patches
>    - left batch_mapping module parameter in the core [Jason]
>
> Max Gurtovoy (2):
>    vdpa_sim: remove hard-coded virtq count
>    vdpa: split vdpasim to core and net modules
>
> Stefano Garzarella (15):
>    vdpa: remove unnecessary 'default n' in Kconfig entries
>    vdpa_sim: remove unnecessary headers inclusion
>    vdpa_sim: remove the limit of IOTLB entries
>    vdpa_sim: rename vdpasim_config_ops variables
>    vdpa_sim: add struct vdpasim_dev_attr for device attributes
>    vdpa_sim: add device id field in vdpasim_dev_attr
>    vdpa_sim: add supported_features field in vdpasim_dev_attr
>    vdpa_sim: add work_fn in vdpasim_dev_attr
>    vdpa_sim: store parsed MAC address in a buffer
>    vdpa_sim: make 'config' generic and usable for any device type
>    vdpa_sim: add get_config callback in vdpasim_dev_attr
>    vdpa_sim: set vringh notify callback
>    vdpa_sim: use kvmalloc to allocate vdpasim->buffer
>    vdpa_sim: make vdpasim->buffer size configurable
>    vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov

