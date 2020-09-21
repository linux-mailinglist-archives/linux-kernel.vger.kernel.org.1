Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C448272AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgIUPuv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 11:50:51 -0400
Received: from smtp.h3c.com ([60.191.123.50]:24952 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgIUPuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:50:51 -0400
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
        by h3cspam02-ex.h3c.com with ESMTPS id 08LFn5r7084222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 23:49:05 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 23:49:09 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Mon, 21 Sep 2020 23:49:09 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Thread-Topic: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Thread-Index: AQHWj71pi81Rb9ZmlEuvVhznKWqiEqlyrIIAgACJanA=
Date:   Mon, 21 Sep 2020 15:49:09 +0000
Message-ID: <be133ab59334475dacd4a52a2834fe71@h3c.com>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
 <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
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
X-MAIL: h3cspam02-ex.h3c.com 08LFn5r7084222
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Keith,
Thanks for your comments,
I will submit a new patch of version 2 for the further reviewing,  v2 patch will contains:
1, retain existing judgement and dev_warn;
2, add the check whether req is null(already did in this patch)
3, simplify and make the changelog succinct according to you said " This is what I'm thinking:".
Is it right?
Should I retain the nvme_irq crash log in changelog, mention the difference between nvmeq->q_depth and tagset queue_depth? 

Thanks

-----Original Message-----
From: Keith Busch [mailto:kbusch@kernel.org] 
Sent: Monday, September 21, 2020 11:08 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking whether req is null

On Mon, Sep 21, 2020 at 10:10:52AM +0800, Xianting Tian wrote:
> @@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> -		dev_warn(nvmeq->dev->ctrl.device,
> -			"invalid id %d completed on queue %d\n",
> -			cqe->command_id, le16_to_cpu(cqe->sq_id));
> -		return;
> -	}
> -
>  	/*
>  	 * AEN requests are special as they don't time out and can
>  	 * survive any kind of queue freeze and often don't respond to @@ 
> -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (unlikely(!req)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"req is null for tag %d completed on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}

This is making sense now, though I think we should retain the existing
dev_warn() since it's still accurate and provides continuity for people who are used to looking for these sorts of messages.

Your changelog is a bit much though. I think we can say it a bit more succinctly. This is what I'm thinking:

  The driver registers interrupts for queues before initializing the
  tagset because it uses the number of successful request_irq() calls
  to configure the tagset parameters. This allows a race condition with
  the current tag validity check if the controller happens to produce
  an interrupt with a corrupted CQE before the tagset is initialized.

  Replace the driver's indirect tag check with the one already provided
  by the block layer.
