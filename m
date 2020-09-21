Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF1271948
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIUC1l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Sep 2020 22:27:41 -0400
Received: from smtp.h3c.com ([60.191.123.56]:45879 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUC1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:27:41 -0400
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
        by h3cspam01-ex.h3c.com with ESMTPS id 08L2QjpK039265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 10:26:45 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 10:26:46 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Mon, 21 Sep 2020 10:26:46 +0800
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
Thread-Index: AQHWjamkvjMzTC+ou0aptn5bKR4hY6luQCAAgAEKLTCAAxV5EA==
Date:   Mon, 21 Sep 2020 02:26:46 +0000
Message-ID: <1f0a3015fd6f40e792a15486f34491c7@h3c.com>
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
X-MAIL: h3cspam01-ex.h3c.com 08L2QjpK039265
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,
I found an extreme case, 
in function blk_mq_alloc_map_and_requests(), it will adjust tagset depth by 'set->queue_depth >>= 1' if there is no enough memory for rqs. 
If this happens, the real available number of tags(nr_tags) is much smaller than nvmeq->q_depth.
So the judgement "if (unlikely(cqe->command_id >= nvmeq->q_depth))" in nvme_handle_cqe() is really
meaningless.

I figured out a new patch, which replaces the meaningless judgement by checking whether the returned
req is null, if it is null, directly return.

Would you please spare several minutes to review below new patch? thanks
https://lkml.org/lkml/2020/9/20/400

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
