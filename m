Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6672E22CEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 21:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGXTkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 15:40:36 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60434 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1+/vH/LNVq3z6IyOwmadh9LNf0EtvgbHbnnQfZcGz+s=; b=RK8P9qip85bzZhXDx0HGVg69BB
        RZr1EuZ7AxNgcRDhNl+yiYPUN/e3q7FftCv2bOWx7v4pJE3Vio3JKK4KyMdkKCwrSWJxsybtARvUY
        JADz0/l/bbHKzv1qIDqW9xrLam5tMqbfcntdvDzXKnUB3LSXtiq21mIPuiZdJW9lyLuO9p/AUC+7Q
        WGSU5yvbz1b6iIi/Vllc+/by9T5bo+kOaQ98imKJU2FZsaKgq4CKZ8T5Y6bJ/umucVltBTaodx18S
        5vxdDkr1MO/Z2e/PgN+/rYCniT2qDtmaMpi+nJHZjAdgQpMaFWlCwxiQ6QxTdGh552ffedRdFXEYO
        IFlnmb2Q==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jz3YQ-0001DC-LM; Fri, 24 Jul 2020 13:40:27 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
 <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d5c64c38-066c-013c-7a79-46230e439c5e@deltatee.com>
Date:   Fri, 24 Jul 2020 13:40:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-24 1:33 p.m., Keith Busch wrote:
> On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
>> +	/*
>> +	 * The passthru NVMe driver may have a limit on the number of segments
>> +	 * which depends on the host's memory fragementation. To solve this,
>> +	 * ensure mdts is limitted to the pages equal to the number of
> 
>                           limited
> 
>> +	/* don't support fuse commands */
>> +	id->fuses = 0;
> 
> If a host were to set a fuse, the target should return an Invalid Field
> error. Just to future-proof, rejecting commands with any flags set
> (other than SGL, which you handled in patch 1/9) is probably what should
> happen, like:

> 
>> +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
>> +{
> 
> 	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
> 		return NVME_SC_INVALID_FIELD;


Yes, this seems like a good idea. I can add it.

> Or maybe we could obviate the need for 1/9 with something like:
> 
> 	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> 	if (req->cmd->common.flags)
> 		return NVME_SC_INVALID_FIELD;

We used to clear the SGL flags in the target passthru code but Christoph
asked that it be done in the host code, hence patch 1/9.

Logan
