Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C22A0476
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJ3Li4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:38:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2358 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ3Liz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:38:55 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CN0gy4kFZz4yVj;
        Fri, 30 Oct 2020 19:38:54 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 30 Oct 2020 19:38:53 +0800
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Using fixed LPI number for some Device ID
Message-ID: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
Date:   Fri, 30 Oct 2020 19:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
   Sorry to disturb you, Currently the LPI number is not fixed for the device. The LPI number is dynamically allocated start from 8092.
For two OS which shares the ITS, One OS needs to configure the device interrupt required by another OS, and the other OS uses a fixed interrupt
ID to respond the interrupt. Therefore, the LPI IRQ number of the device needed be fixed. I want to upstream this feature that allocate fixed
LPI number for the device that is specified through the DTS. do you agree?  Thanks!
