Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665FA258D77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIALdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 07:33:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbgIAL2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:28:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B6C335C5C8A95CC4DC61;
        Tue,  1 Sep 2020 19:11:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 19:11:10 +0800
Subject: Re: [PATCH v4 0/1] libnvdimm: fix memory leaks in of_pmem.c
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <20200901081450.1969-1-thunder.leizhen@huawei.com>
 <9d82bd85-5d6c-b8fe-15c7-c87348aa7a3a@web.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6a9ec7f5-f822-dce5-0560-d49d3bacaf0b@huawei.com>
Date:   Tue, 1 Sep 2020 19:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9d82bd85-5d6c-b8fe-15c7-c87348aa7a3a@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/1 18:14, Markus Elfring wrote:
>> v3 --> v4
>> 1. Merge patch 1 and 2 into one:
> 
> How do you think about to omit a cover letter for a single patch?

After all, the code hasn't changed except this merge.

> 
> Regards,
> Markus
> 
> 

