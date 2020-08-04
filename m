Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5716023B3A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 05:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgHDDwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 23:52:04 -0400
Received: from mail.windriver.com ([147.11.1.11]:53294 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgHDDwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:52:04 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 0743poUu003488
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 3 Aug 2020 20:51:50 -0700 (PDT)
Received: from [128.224.162.157] (128.224.162.157) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 20:51:49 -0700
Subject: Re: [PATCH] crypto: ccp - zero the cmd data after use it
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, David <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200803075858.3561-1-liwei.song@windriver.com>
 <20200803125242.GA7689@gondor.apana.org.au>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <87ae939b-4983-4e96-cc3d-1aa1d1b3d3ae@windriver.com>
Date:   Tue, 4 Aug 2020 11:51:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803125242.GA7689@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/20 20:52, Herbert Xu wrote:
> On Mon, Aug 03, 2020 at 03:58:58PM +0800, Liwei Song wrote:
>> exist the following assignment in ccp(ignore the force
>> convert of the struct) by list_del in ccp_dequeue_cmd():
>> req->__ctx->cmd->entry->next = LIST_POISON1;
>>
>> after use the req, kzfree(req) can not zero the entry
>> entry->next = LIST_POISON1 of the ccp_cmd(cmd) struct
>> when this address available as slub freelist pointer, this will cause
>> the following "general protection fault" error if some process meet
>> this LIST_POISON1 value address when request memory:
> 
> Your description makes no sense.  Please rewrite it and explain
> the problem properly.

The problem here is that the entry of struct ccp_cmd is not zeroed after we use it,
If the other process got this address by kmalloc(), this illegal value "LIST_POISON1"
will cause "general protection fault" error.

Thanks,
Liwei.


> 
> Thanks,
> 
