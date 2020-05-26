Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A611AB175
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506455AbgDOTRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:17:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18924 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438103AbgDOTHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:07:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9759d70000>; Wed, 15 Apr 2020 12:00:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 12:02:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 12:02:28 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 19:02:28 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 19:02:28 +0000
Subject: Re: [PATCH] mm/filemap: Fix a typo in comment
 "unneccssary"->"unnecessary"
To:     Matthew Wilcox <willy@infradead.org>
CC:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200411065141.15936-1-ethp@qq.com>
 <9677805f-5194-b6e8-8949-6ff0cbeb504e@nvidia.com>
 <20200415183743.GE5820@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <c85bd99a-f921-d294-b454-3c5d8e0f4221@nvidia.com>
Date:   Wed, 15 Apr 2020 12:02:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200415183743.GE5820@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586977239; bh=KyoYk8q6/O85eMdsE3qMRX+wPYPXu0EM5khVV9wjUpQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mCQ5dkGbx8+HeqaAlzgJrkFZcsYUWLSPaAPrtsL/FYvl4+truvBdG/Fpef3XbeiEY
         wIJWGkputVBX8s+e1SQWYr9Hc9b71W1pqIMRf3opy3vWStB5zNwjxRP64S8WknHzw1
         IbFiWQiY6No+N7EGhsq1VuiYIpCLR2lSTKhjVt48L1s6t+/EI8P5VD3DJG84hoVGo8
         cyiNlijZwKUd7/F5ZFrSNsu/+EEXwpI79579cGAefWumrXtWpZmIhVsij0iq4qA42G
         Uji+o3g2tZe+fP0gwIeAK3+JYTi2P4bo/Xt2zGZFPFxO8LPqpEsIruvZU/DWMywe94
         NtHQ0GW6xTsrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/20 11:37 AM, Matthew Wilcox wrote:
> On Wed, Apr 15, 2020 at 11:36:34AM -0700, Ralph Campbell wrote:
>>
>> On 4/10/20 11:51 PM, Ethon Paul wrote:
>>> There is a typo in comment, fix it.
>>>
>>> Signed-off-by: Ethon Paul <ethp@qq.com>
>>
>> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> NAK.  See earlier response.

Oops. Sorry about that.
I was looking at 5.7.0-rc1 and forgot about your pending change that makes this
unnecessary. :-)
