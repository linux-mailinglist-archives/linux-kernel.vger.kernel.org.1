Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4627E5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgI3J5x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 05:57:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:51996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727657AbgI3J5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:57:52 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E608E9F67144460A1187;
        Wed, 30 Sep 2020 17:57:44 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 30 Sep 2020 17:57:44 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 30 Sep 2020 17:57:44 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/atomic/bitops: Fix some wrong param names in
 comments
Thread-Topic: [PATCH] locking/atomic/bitops: Fix some wrong param names in
 comments
Thread-Index: AdaXEBX7ZwOiGoS6QqevemLv2dOXxg==
Date:   Wed, 30 Sep 2020 09:57:44 +0000
Message-ID: <efc3919563c249ceab488d682e19ee17@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping :)
> Correct the wrong param name @addr to @p.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/asm-generic/bitops/lock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h

