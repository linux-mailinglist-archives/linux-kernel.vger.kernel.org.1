Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A315F2712E4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgITI2O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Sep 2020 04:28:14 -0400
Received: from smtp.h3c.com ([60.191.123.50]:7649 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgITI2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 04:28:14 -0400
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
        by h3cspam02-ex.h3c.com with ESMTPS id 08K8QiiG013053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Sep 2020 16:26:44 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Sep 2020 16:26:47 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Sun, 20 Sep 2020 16:26:46 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Topic: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Index: AQHWjamkvjMzTC+ou0aptn5bKR4hY6luQCAAgAEKLTCAAd/R8A==
Date:   Sun, 20 Sep 2020 08:26:46 +0000
Message-ID: <4e8aec9ebe8a4b8792632e71cb4a0e65@h3c.com>
References: <20200918104420.30219-1-tian.xianting@h3c.com>
 <20200918192034.GA4030837@dhcp-10-100-145-180.wdl.wdc.com> 
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08K8QiiG013053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I test and get the init flow of nvme admin queue and io queue in kernel 5.6,
Currently, the code use nvmeq->q_depth as the upper limit for tag in nvme_handle_cqe(), according to below init flow, we already have the race currently.

Admin queue init flow:
1, set nvmeq->q_depth 32 for admin queue;
2, register irq handler(nvme_irq) for admin queue 0;
3, set admin_tagset.queue_depth to 30 and alloc rqs;
4, nvme irq happen on admin queue;

IO queue init flow:
1, set nvmeq->q_depth 1024 for io queue 1~16;
2, register irq handler(nvme_irq) for io queue 1~16;
3, set tagset.queue_depth to 1023 and alloc rqs;
4, nvme irq happen on io queue;

So we have two issues need to fix:
1, register interrupt handler(nvme_irq) after tagset init(step 3 above) done to avoid a race;
2, use correct upper limit(queue_depth in tagset) for tag in nvme_handle_cqe(), which is the issue that will be solved in this patch I submitted.

Is it right? Thanks a lot.

-----Original Message-----
From: tianxianting (RD) 
Sent: Saturday, September 19, 2020 11:15 AM
To: 'Keith Busch' <kbusch@kernel.org>
Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: RE: [PATCH] [v2] nvme: use correct upper limit for tag in nvme_handle_cqe()

Hi Keith,
Thanks a lot for your comments,
I will try to figure out a safe fix for this issue, then for you review:) 

-----Original Message-----
From: Keith Busch [mailto:kbusch@kernel.org] 
Sent: Saturday, September 19, 2020 3:21 AM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: use correct upper limit for tag in nvme_handle_cqe()

On Fri, Sep 18, 2020 at 06:44:20PM +0800, Xianting Tian wrote:
> @@ -940,7 +940,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> +	if (unlikely(cqe->command_id >=
> +			nvmeq->qid ? nvmeq->dev->tagset.queue_depth :
> +			nvmeq->dev->admin_tagset.queue_depth)) {

Both of these values are set before blk_mq_alloc_tag_set(), so you still have a race. The interrupt handler probably just shouldn't be registered with the queue before the tagset is initialized since there can't be any work for the handler to do before that happens anyway.

The controller is definitely broken, though, and will lead to unavoidable corruption if it's really behaving this way.
