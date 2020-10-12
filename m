Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0828B8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbgJLNyt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Oct 2020 09:54:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:51344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389049AbgJLNyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:54:32 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id D8E24734CB159E6780CF;
        Mon, 12 Oct 2020 21:54:29 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 12 Oct 2020 21:54:29 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 12 Oct 2020 21:54:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "vitalywool@gmail.com" <vitalywool@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Question] About z3fold page migration
Thread-Topic: [Question] About z3fold page migration
Thread-Index: AdagnzMIx4Seyi2qROGt7qSVacTSPg==
Date:   Mon, 12 Oct 2020 13:54:29 +0000
Message-ID: <1f19b35baad347f08d02b90239214196@huawei.com>
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

Hi Vitaly:

	Many thanks for your brilliant z3fold code. I am reading it and have some questions about it. It's very nice of you if you can explain it for me.
	1.page->private is used in z3fold but PagePrivate flag is never set, should we SetPagePrivate for it?
	2.Since PagePrivate flag is never set, why we ClearPagePrivate in free_z3fold_page and z3fold_page_migrate?
	3.Should we add page to the unbuddied list in z3fold_page_putback() when zhdr->refcount does not reach 0 since we remove it from unbuddied list
in z3fold_page_isolate? Or When we will add page to the unbuddied list after z3fold_page_putback?

	Thanks a lot in advance. And waiting for your reply. :)
