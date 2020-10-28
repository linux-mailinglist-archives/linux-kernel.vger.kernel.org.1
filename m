Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3029DA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbgJ1XVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:21:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1454 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbgJ1XVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:21:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99a3120002>; Wed, 28 Oct 2020 09:57:54 -0700
Received: from [172.27.0.18] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 16:58:11 +0000
Subject: Re: [PATCH v3] nvme-rdma: handle nvme completion data length
To:     zhenwei pi <pizhenwei@bytedance.com>, <kbusch@kernel.org>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <lengchao@huawei.com>
References: <20201025115124.1430678-1-pizhenwei@bytedance.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <86fa6106-b969-4bb9-95ee-c1101a61ff03@nvidia.com>
Date:   Wed, 28 Oct 2020 18:58:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201025115124.1430678-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603904274; bh=cR2ZEkkVb/BlRCyOFgIUSEJCwL4kH+CyituXrsasLIE=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=nWFx2UzNPDiROjdiBCoKaqsoXBmlMDFGaKIaTCPEvZLLmwBjn6a5pVAnzknVcWEBL
         Zp9/RSvDbckthXtzooyEMojhijAhKPEOtke6799ARYxLPNoBTJuyal0yJyMd3gb5rh
         dirt/6rnxeYZb1/wxBYsxH8MD/O/5f1ANoLm3NqDLrtaoOy8AlqSUa3/p0i8SSqd5S
         D+BsZTStZC7a1WXAMtLgF0VAILvWTxNSpNguPgDY0qrnjaKUPbxOnyRNYxKtjO8mqq
         PXrV0ShzH5EMS4x8hrVwa4ValWS2DFZhNql8gaq4CVNXEnbyfPPUkK1gu7aOPCA4Zh
         mynLNW5LnWEMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/2020 1:51 PM, zhenwei pi wrote:
> Hit a kernel warning:
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
>
> RIP: 0010:refcount_warn_saturate+0xd9/0xe0
> Call Trace:
>   <IRQ>
>   nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
>   __ib_process_cq+0x76/0x150 [ib_core]
>   ...
>
> The reason is that a zero bytes message received from target, and the
> host side continues to process without length checking, then the
> previous CQE is processed twice.
>
> Do sanity check on received data length, try to recovery for corrupted
> CQE case.
>
> Because zero bytes message in not defined in spec, using zero bytes
> message to detect dead connections on transport layer is not
> standard, currently still treat it as illegal.
>
> Thanks to Chao Leng & Sagi for suggestions.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/host/rdma.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
Seems strange that the targets sends zero byte packets.

Can you specify which target is this and the scenario ?

