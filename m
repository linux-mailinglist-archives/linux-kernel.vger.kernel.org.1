Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9531224A032
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgHSNhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:37:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbgHSNf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:35:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0BD7B6E4E73F1F088A22;
        Wed, 19 Aug 2020 21:35:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 21:35:21 +0800
Subject: Re: [PATCH v2 3/4] libnvdimm/bus: simplify walk_to_nvdimm_bus()
To:     Markus Elfring <Markus.Elfring@web.de>, <linux-nvdimm@lists.01.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-4-thunder.leizhen@huawei.com>
 <ff1333cb-9917-6a2c-4454-325d161d8650@web.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ee3b1538-b19f-5dd9-d023-90eca4bfd9b7@huawei.com>
Date:   Wed, 19 Aug 2020 21:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ff1333cb-9917-6a2c-4454-325d161d8650@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 8:40 PM, Markus Elfring wrote:
>> … when is_nvdimm_bus(dev) successed.
> 
> I imagine that that an other wording will be more appropriate here.

OK, I will rewrite it.

> 
> Regards,
> Markus
> 
> 

