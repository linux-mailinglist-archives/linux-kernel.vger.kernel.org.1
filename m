Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D62DE33F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgLRNXh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Dec 2020 08:23:37 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2530 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLRNXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:23:37 -0500
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Cy8fg1jqhzQsqX;
        Fri, 18 Dec 2020 21:22:19 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 18 Dec 2020 21:22:54 +0800
Received: from DGGEML513-MBX.china.huawei.com ([169.254.12.170]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Fri, 18 Dec 2020 21:22:53 +0800
From:   wufengguang <wufengguang@huawei.com>
To:     Hui Zhu <teawater@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] usemem: Add option touch-alloc
Thread-Topic: [PATCH] usemem: Add option touch-alloc
Thread-Index: AdbVQLU3AXz0GA7TSPaB37n1qGP7DA==
Date:   Fri, 18 Dec 2020 13:22:53 +0000
Message-ID: <63AD405728A51946A32F7AFFEF2AFE88A50008@dggeml513-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.52.178.143]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhu Hui,

Applied both patches with minor cleanup. Thanks!

Regards,
Fengguang

