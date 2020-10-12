Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952ED28B973
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgJLOAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Oct 2020 10:00:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390745AbgJLOA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:00:27 -0400
Received: from dggeme753-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 5D03A1931B07E1AA0D58;
        Mon, 12 Oct 2020 22:00:18 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 12 Oct 2020 22:00:18 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 12 Oct 2020 22:00:18 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Question Resend] About z3fold page migration
Thread-Topic: [Question Resend] About z3fold page migration
Thread-Index: Adagn3yNVyDgo4n6SKSqZr6PQeVVww==
Date:   Mon, 12 Oct 2020 14:00:17 +0000
Message-ID: <6d803d0cf27840caa64619949c2c3dd1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.54]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

	Many thanks for brilliant z3fold code. I am reading it and have some questions about it. It's very nice of you if you can explain it for me.
	1.page->private is used in z3fold but PagePrivate flag is never set, should we SetPagePrivate for it?
	2.Since PagePrivate flag is never set, why we ClearPagePrivate in free_z3fold_page and z3fold_page_migrate?
	3.Should we add page to the unbuddied list in z3fold_page_putback() when zhdr->refcount does not reach 0 since we remove it from unbuddied list
in z3fold_page_isolate? Or When we will add page to the unbuddied list after z3fold_page_putback?

	Thanks a lot in advance. And waiting for your kindly reply. :)

