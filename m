Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4021CCF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 03:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgEKBYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 21:24:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbgEKBYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:24:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 796B9EC8409A43A0084B;
        Mon, 11 May 2020 09:24:29 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.90) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 11 May 2020
 09:24:21 +0800
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
To:     Joe Perches <joe@perches.com>, <davem@davemloft.net>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
 <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
CC:     <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
Date:   Mon, 11 May 2020 09:24:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, i made a mistake, should be scnprintf().


On 2020/5/9 19:40, Joe Perches wrote:
> On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
>> snprintf() returns the number of bytes that would be written,
>> which may be greater than the the actual length to be written.
> []
>> Chen Zhou (2):
>>   sparc: use snprintf() in show_pciobppath_attr() in pci.c
>>   sparc: use snprintf() in show_pciobppath_attr() in vio.c
> Your subjects are a bit off: snprintf vs scnprintf
>
>
>
>


