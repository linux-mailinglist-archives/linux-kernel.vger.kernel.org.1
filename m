Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF551BF8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD3NAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 09:00:22 -0400
Received: from david.siemens.de ([192.35.17.14]:56458 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgD3NAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:00:21 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 03UCxqYX019571
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 14:59:52 +0200
Received: from [139.22.32.49] ([139.22.32.49])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 03UCxo1b023033;
        Thu, 30 Apr 2020 14:59:50 +0200
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Will Deacon <will@kernel.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck> <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck> <20200430111156.GI5097@quicinc.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
Date:   Thu, 30 Apr 2020 14:59:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111156.GI5097@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.20 13:11, Srivatsa Vaddagiri wrote:
> * Will Deacon <will@kernel.org> [2020-04-30 11:41:50]:
> 
>> On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
>>> If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
>>> set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
>>> example: message_queue_send() and message_queue_recevie() hypercalls).
>>
>> Hmm, but then how would such a kernel work as a guest under all the
>> spec-compliant hypervisors out there?
> 
> Ok I see your point and yes for better binary compatibility, the ops have to be
> set based on runtime detection of hypervisor capabilities.
> 
>>> Ok. I guess the other option is to standardize on a new virtio transport (like
>>> ivshmem2-virtio)?
>>
>> I haven't looked at that, but I suppose it depends on what your hypervisor
>> folks are willing to accomodate.
> 
> I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> (for life-cycle management of VMs), which our hypervisor may not support. A
> simple shared memory and doorbell or message-queue based transport will work for
> us.

As written in our private conversation, a mapping of the ivshmem2 device 
discovery to platform mechanism (device tree etc.) and maybe even the 
register access for doorbell and life-cycle management to something 
hypercall-like would be imaginable. What would count more from virtio 
perspective is a common mapping on a shared memory transport.

That said, I also warned about all the features that PCI already defined 
(such as message-based interrupts) which you may have to add when going 
a different way for the shared memory device.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
