Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8726DAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIQL5o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Sep 2020 07:57:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726850AbgIQLyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:54:52 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id F2794487DE71E8F30B73;
        Thu, 17 Sep 2020 19:54:43 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 17 Sep 2020 19:54:43 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 17 Sep 2020 19:54:43 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: avoid possible multiple call to swap_node()
Thread-Topic: [PATCH] mm: avoid possible multiple call to swap_node()
Thread-Index: AdaM6Oe6eaYOLUj9SMWV/0KAXRUceQ==
Date:   Thu, 17 Sep 2020 11:54:43 +0000
Message-ID: <691578e1e0844c7c876a54c6ff9c2f0a@huawei.com>
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

Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Sep 17, 2020 at 07:44:49AM -0400, Miaohe Lin wrote:
>> Cache the swap_node() in a local variable to avoid possible multiple 
>> call to swap_node(), though compiler may do this for us.
>
>Why don't you find out?  Compare the assembly before and after, see what the compiler did.

In fact, I don't care if the compiler can really do this for us. I think it's better to do this explicity. I think this can improve the readability.
Thanks.

