Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35880247C21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRCZx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Aug 2020 22:25:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgHRCZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 22:25:52 -0400
Received: from dggeme704-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id A351282782B86ACD5956;
        Tue, 18 Aug 2020 10:25:49 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme704-chm.china.huawei.com (10.1.199.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 18 Aug 2020 10:25:49 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 18 Aug 2020 10:25:49 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Thread-Topic: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Thread-Index: AdZ1Bqx0JUT5SU7CKEmLji2ne5ieMQ==
Date:   Tue, 18 Aug 2020 02:25:49 +0000
Message-ID: <8e7c7a77722446afbc8cb25e46eab325@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:
>On Mon, Aug 17, 2020 at 07:59:33AM -0400, Miaohe Lin wrote:
>> There is no need to check if this process has the right to modify the 
>> specified process when they are same.
>
>We should probably also skip the security hook call if a process is modifying its own pages.
>
>How about this instead?
>

It sounds good, thanks for your good advice. Would you like a tag like suggest-by?

