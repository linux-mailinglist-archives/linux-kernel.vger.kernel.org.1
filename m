Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5C28C6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 03:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgJMBrA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Oct 2020 21:47:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728368AbgJMBrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:47:00 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 52428B01F422E592A767;
        Tue, 13 Oct 2020 09:46:58 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 13 Oct 2020 09:46:57 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 13 Oct 2020 09:46:57 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Question Resend] About z3fold page migration
Thread-Topic: [Question Resend] About z3fold page migration
Thread-Index: AdahATPxqN5axJg6RU2xJ1rzRUeAVQ==
Date:   Tue, 13 Oct 2020 01:46:57 +0000
Message-ID: <5558810ec33b4b8e92145f66a4922be8@huawei.com>
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

Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Oct 12, 2020 at 02:00:17PM +0000, linmiaohe wrote:
>> Hi all:
>> 
>> 	Many thanks for brilliant z3fold code. I am reading it and have some questions about it. It's very nice of you if you can explain it for me.
>> 	1.page->private is used in z3fold but PagePrivate flag is never set, should we SetPagePrivate for it?
>
>No.  SetPagePrivate and page->private are related in interesting and complicated ways.  I'm working on some documentation for it at the moment, but the short answer is: no.

I can't wait to read your document. PagePrivate confuses me now.

>
>> 	2.Since PagePrivate flag is never set, why we ClearPagePrivate in free_z3fold_page and z3fold_page_migrate?
>
>That's probably a bug.
>
>
>> 	3.Should we add page to the unbuddied list in z3fold_page_putback() 
>> when zhdr->refcount does not reach 0 since we remove it from unbuddied list in z3fold_page_isolate? Or When we will add page to the unbuddied list after z3fold_page_putback?
>
>This one I do not know the answer to.
>

Many thanks for your reply. Enjoy your day! ;)

