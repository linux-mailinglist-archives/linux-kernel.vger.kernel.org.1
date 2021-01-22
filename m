Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E382FFC76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 07:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhAVGNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 01:13:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2959 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhAVGNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:13:25 -0500
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMTRV5Yqjz5K8f;
        Fri, 22 Jan 2021 14:11:34 +0800 (CST)
Received: from DGGEML533-MBX.china.huawei.com ([169.254.9.87]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0509.000;
 Fri, 22 Jan 2021 14:12:41 +0800
From:   wufengguang <wufengguang@huawei.com>
To:     Hui Zhu <teawater@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hui Zhu <teawaterz@linux.alibaba.com>,
        "wfg@mail.ustc.edu.cn" <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH] usemem: Remove the duplicate do_access
Thread-Topic: [PATCH] usemem: Remove the duplicate do_access
Thread-Index: Adbv+IcJBmmJ4GQFQVumFBfHInI7Jw==
Date:   Fri, 22 Jan 2021 06:12:40 +0000
Message-ID: <63AD405728A51946A32F7AFFEF2AFE88A9C3CB@dggeml533-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.46.10.144]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXBwbGllZCwgdGhhbmtzIQ0KDQpTb3JyeSB0aGUgbWlzdGFrZSBzaG91bGQgYmUgY2F1c2VkIGJ5
IG1hbnVhbGx5IGZpeGluZyB1cCBtYW5nbGVkIG91dGxvb2sgcGF0Y2guDQoNClJlZ2FyZHMsDQpG
ZW5nZ3VhbmcNCg==
