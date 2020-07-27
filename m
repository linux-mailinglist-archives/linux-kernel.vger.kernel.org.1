Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF422F409
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgG0Pod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 11:44:33 -0400
Received: from ale.deltatee.com ([204.191.154.188]:46254 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgG0Pod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v9juTWF0gUqIQym5kftupp/yJY6WM8xbb3ynnrOV7Ec=; b=kjRUm44k6agr6xBlWPUhmI/zSe
        LD3CypdiCMTqy4ao7clkxItuhG/EWKGMWI4Qoz6Cb0IBN+QYxxm8+t0hgu/4POalYqV1HBDofGfGz
        ASolRjnbAWUvl8/OCaG4Wk7s2WPd2C2nKVazCQZH2KOhC4lxhlqWXmDw0Lu6SbswSjxsvfPYZhpdl
        g0oja+r6dw4DXSt1W4zNjvzkZLF1BSeOasDOb/2xQ1r5STH+Bs5ML2Jrufgo9fnZfMHYKfuF3pjgV
        qLIJbgnP/027CA/2YHgCOhWemQCrbnuTA5J3XollrxBA0Kpyuwi4beRxHPFHTyX0o+yIAShS+upRe
        Qf1qFknw==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k05Id-0002iR-9G; Mon, 27 Jul 2020 09:44:24 -0600
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
 <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
 <20200726154104.GA23930@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2963e23f-5f37-7720-f8f2-fb1a73f31ac5@deltatee.com>
Date:   Mon, 27 Jul 2020 09:44:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726154104.GA23930@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, kbusch@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
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



On 2020-07-26 9:41 a.m., Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 12:33:51PM -0700, Keith Busch wrote:
>> On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
>>> +	/*
>>> +	 * The passthru NVMe driver may have a limit on the number of segments
>>> +	 * which depends on the host's memory fragementation. To solve this,
>>> +	 * ensure mdts is limitted to the pages equal to the number of
>>
>>                           limited
> 
> I've fixed this when applying.
> 
>>> +	/* don't support fuse commands */
>>> +	id->fuses = 0;
>>
>> If a host were to set a fuse, the target should return an Invalid Field
>> error. Just to future-proof, rejecting commands with any flags set
>> (other than SGL, which you handled in patch 1/9) is probably what should
>> happen, like:
>>
>>> +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
>>> +{
>>
>> 	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
>> 		return NVME_SC_INVALID_FIELD;
>>
>> Or maybe we could obviate the need for 1/9 with something like:
>>
>> 	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>> 	if (req->cmd->common.flags)
>> 		return NVME_SC_INVALID_FIELD;
> 
> We'll also need this for the admin commands, but otherwise this sounds
> like a good idea.  For now I've applied the series as-is, but an
> incremental patch for this would be nice.

Great, I can send one later in the week.

Thanks,

Logan
