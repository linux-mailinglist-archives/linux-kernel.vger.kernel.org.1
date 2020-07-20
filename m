Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD9225531
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGTBKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 21:10:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbgGTBKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:10:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63D3841452D250B40056;
        Mon, 20 Jul 2020 09:10:46 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 20 Jul
 2020 09:10:42 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: segment.h: delete a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200720001344.25138-1-rdunlap@infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bffcb40e-94bf-ca89-4ee8-3158050930c1@huawei.com>
Date:   Mon, 20 Jul 2020 09:10:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200720001344.25138-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/20 8:13, Randy Dunlap wrote:
> Drop the repeated word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
