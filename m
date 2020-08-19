Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12F4249FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgHSNay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:30:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9849 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728060AbgHSNaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:30:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C9E21510E0ACF87DB482;
        Wed, 19 Aug 2020 21:30:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 21:30:46 +0800
Subject: Re: [PATCH v2 0/4] bug fix and optimize for drivers/nvdimm
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <ce85d12b-f0bf-8cdd-0477-8ee87ff5a4c9@web.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6ae57740-afdf-d9fc-2f11-821de66fb357@huawei.com>
Date:   Wed, 19 Aug 2020 21:30:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ce85d12b-f0bf-8cdd-0477-8ee87ff5a4c9@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 8:20 PM, Markus Elfring wrote:
>> v1 --> v2:
>> 1. Add Fixes for Patch 1-2
>> 2. Slightly change the subject and description of Patch 1
> …
>>   libnvdimm: fix memmory leaks in of_pmem.c
> …
> 
> I suggest to avoid a typo in such a patch subject.

OK, Thanks for reminding me.

> 
> Regards,
> Markus
> 
> 

