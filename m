Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9720249221
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 03:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHSBIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 21:08:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbgHSBIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:08:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55D2713F051FD3159F59;
        Wed, 19 Aug 2020 09:08:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 09:07:59 +0800
Subject: Re: [PATCH 1/3] libnvdimm: Fix memory leaks in of_pmem.c
To:     Markus Elfring <Markus.Elfring@web.de>, <linux-nvdimm@lists.01.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fdbd9d2d-2e5d-8190-5d7c-eec5c4cdadbb@huawei.com>
Date:   Wed, 19 Aug 2020 09:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 3:00 AM, Markus Elfring wrote:
>> The memory priv->bus_desc.provider_name allocated by kstrdup() should be
>> freed.
> 
> * Would an imperative wording be preferred for the change description?
> 
> * I propose to add the tag “Fixes” to the commit message.
Thanks for your suggestion, I will add it in v2.

Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")


> 
> Regards,
> Markus
> 
> 

