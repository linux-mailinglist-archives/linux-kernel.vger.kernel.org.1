Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196802A12CD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 03:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgJaCTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 22:19:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2484 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 22:19:23 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CNNCt2tKDzQjtp;
        Sat, 31 Oct 2020 10:19:22 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 31 Oct 2020 10:19:20 +0800
Subject: Re: Using fixed LPI number for some Device ID
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
Message-ID: <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
Date:   Sat, 31 Oct 2020 10:19:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Marc,
    Sorry to disturb you, Currently the LPI number is not fixed for the device. The LPI number is dynamically allocated start from 8092.
 For two OS which shares the ITS, One OS needs to configure the device interrupt required by another OS, and the other OS uses a fixed interrupt
 ID to respond the interrupt. Therefore, the LPI IRQ number of the device needed be fixed. I want to upstream this feature that allocate fixed
 LPI number for the device that is specified through the DTS. What is your meaning?  Thanks
