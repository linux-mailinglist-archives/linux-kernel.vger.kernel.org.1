Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38EA244D56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHNRKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 13:10:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3015 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbgHNRKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:10:23 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 39AA4C23FCB17C1C9D5E;
        Sat, 15 Aug 2020 01:10:21 +0800 (CST)
Received: from [10.140.157.78] (10.140.157.78) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 15 Aug 2020 01:10:20 +0800
To:     <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Adjust interrupt Priority for ARM64 GIC
Message-ID: <5a6e65cf-d2fe-0107-2318-0e3c81d57000@huawei.com>
Date:   Sat, 15 Aug 2020 01:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.78]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
   In the Linux kernel, we can not adjust the  interrupt Priority, For all the interrupts, the interrupt Priority are fixed to 0xa0.
In some scenarios, it needs to change the Priority. so I want to upstream a serie patch to support to change the Priority through procfs. do you agree I upstream this feature? thanks~
