Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1675239D28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 03:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHCBM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 21:12:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHCBMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 21:12:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 869567EE8D90D9FFC445;
        Mon,  3 Aug 2020 09:12:52 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 09:12:49 +0800
Subject: Re: [BUG] crypto: hisilicon: accessing the data mapped to streaming
 DMA
To:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
References: <361fa200-479c-e1ef-b7d6-e666a256660f@tsinghua.edu.cn>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F276491.8060409@hisilicon.com>
Date:   Mon, 3 Aug 2020 09:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <361fa200-479c-e1ef-b7d6-e666a256660f@tsinghua.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/2 22:52, Jia-Ju Bai wrote:
> In qm_qp_ctx_cfg(), "sqc" and "aeqc" are mapped to streaming DMA:
>   eqc_dma = dma_map_single(..., eqc, ...);
>   ......
>   aeqc_dma = dma_map_single(..., aeqc, ...);

Only sqc, cqc will be configured in qm_qp_ctx_cfg.

> 
> Then "sqc" and "aeqc" are accessed at many places, such as:
>   eqc->base_l = cpu_to_le32(lower_32_bits(qm->eqe_dma));
>   eqc->base_h = cpu_to_le32(upper_32_bits(qm->eqe_dma));
>   ......
>   aeqc->base_l = cpu_to_le32(lower_32_bits(qm->aeqe_dma));
>   aeqc->base_h = cpu_to_le32(upper_32_bits(qm->aeqe_dma));

There are sqc, cqc, eqc, aeqc, you seems misunderstand them.

> 
> These accesses may cause data inconsistency between CPU cache and hardware.
> 
> I am not sure how to properly fix this problem, and thus I only report it.

In qm_qp_ctx_cfg, sqc/cqc memory will be allocated and related mailbox will be sent
to hardware. In qm_eq_ctx_cfg, eqc/aeqc related operations will be done.

So there is no problem here :)

Thanks,
Zhou

> 
> 
> Best wishes,
> Jia-Ju Bai
> 
> 
