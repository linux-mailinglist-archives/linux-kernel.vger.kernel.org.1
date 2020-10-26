Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88D2985C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 04:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421675AbgJZDDP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Oct 2020 23:03:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2048 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421649AbgJZDDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 23:03:13 -0400
Received: from dggeme753-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CKKQq5QByzVh99;
        Mon, 26 Oct 2020 11:03:15 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 26 Oct 2020 11:03:10 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 26 Oct 2020 11:03:10 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: swap: Use memset to fill the swap_map with
 SWAP_HAS_CACHE
Thread-Topic: [PATCH] mm: swap: Use memset to fill the swap_map with
 SWAP_HAS_CACHE
Thread-Index: AdarQpX2ZZ5fV9PCQBCbgX9M50USaQ==
Date:   Mon, 26 Oct 2020 03:03:10 +0000
Message-ID: <16636ab4ebb746b4ba0a14eec8225cbc@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.91]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 21 Sep 2020 08:22:24 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
>
>> We could use helper memset to fill the swap_map with SWAP_HAS_CACHE 
>> instead of a direct loop here to simplify the code. Also we can remove 
>> the local variable i and map this way.
>>  	*slot = swp_entry(si->type, offset);
>
>I suppose so.  But it does assume that the ->swapmap array has the type char.  If we ever change that, breakage will ensue.
>

The origin code already assumes that the ->swap_map array has the type char. So, this change is ok. ;)

And if we change the type of ->swap_map, each place uses the swap_map should be fixed accordingly.;(

Many thanks.

