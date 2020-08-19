Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA00A24A18A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHSOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 10:18:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbgHSOSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:18:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8908AB40B7E2DEBD118D;
        Wed, 19 Aug 2020 22:18:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 22:18:24 +0800
Subject: Re: [PATCH v2 1/4] libnvdimm: Fix memory leaks in of_pmem.c
To:     Oliver O'Halloran <oohall@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
CC:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com>
 <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
 <CAOSf1CGJ6JNBuN+EpLttpf0HYOtN8dpqoTscGYHEbxqb9ANkVg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <aacaa4e4-95c9-c089-dea0-6a7c4808d1ea@huawei.com>
Date:   Wed, 19 Aug 2020 22:18:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGJ6JNBuN+EpLttpf0HYOtN8dpqoTscGYHEbxqb9ANkVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 9:35 PM, Oliver O'Halloran wrote:
> On Wed, Aug 19, 2020 at 10:28 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
>>> freed correctly.
> 
> Personally I thought his commit message was perfectly fine. A little
> unorthodox, but it works.
> 
>> How do you think about to choose an imperative wording for
>> a corresponding change description?
> 
> ...but this! This is word salad.

Talented students are trained by strict teacher. All of us is trying to make things better.

> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
>>
>> Regards,
>> Markus
> 
> 

