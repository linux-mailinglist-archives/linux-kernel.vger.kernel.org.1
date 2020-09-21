Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4223A2722CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgIULlj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 07:41:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:46092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbgIULlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:41:39 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 172A1C2DDCC6393A8BA3;
        Mon, 21 Sep 2020 19:41:36 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 21 Sep 2020 19:41:35 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 21 Sep 2020 19:41:35 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     "ardb@kernel.org" <ardb@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lib: fix incomplete comment in
 refcount_dec_and_lock_irqsave()
Thread-Topic: [PATCH v2] lib: fix incomplete comment in
 refcount_dec_and_lock_irqsave()
Thread-Index: AdaQC7funBeNoQ3tSN2j7CxmPbHxQQ==
Date:   Mon, 21 Sep 2020 11:41:35 +0000
Message-ID: <4a6ab26488c143259d0f04ff636fe6f3@huawei.com>
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

Will Deacon <will@kernel.org> wrote:
> On Mon, Sep 21, 2020 at 07:23:58AM -0400, Miaohe Lin wrote:
>> The description of arg flags is incomplete. The flags is saved 
>> IRQ-flags when the @lock is acquired.
>> 
>> + * @flags: saved IRQ-flags if the is @lock acquired
>
>This still isn't quite right. If we go with:
>
>  @flags: saved IRQ-flags if @lock is acquired
>

This is what I mean to do... Sorry for this overlook.

>then:
>
>Acked-by: Will Deacon <will@kernel.org>
>
>Will

Thanks for acked-by tag and kindly reply.

