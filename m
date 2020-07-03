Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA744213107
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 03:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGCBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 21:35:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgGCBfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:35:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E61548CA0A9A23D04919;
        Fri,  3 Jul 2020 09:35:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 3 Jul 2020
 09:35:01 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid readahead race condition
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com> <20200629202720.GA230664@google.com>
 <20200630204348.GA2504307@ubuntu-s3-xlarge-x86>
 <20200630205635.GB1396584@google.com>
 <285a4e16-2cbc-d1e9-8464-8a06bacbaaa0@huawei.com>
 <d496f4b9-e4fa-1366-61a9-38ee59c20e15@huawei.com>
 <20200701161442.GB1724572@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <181332c0-f60f-6438-6c79-e3a67f58c4ba@huawei.com>
Date:   Fri, 3 Jul 2020 09:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200701161442.GB1724572@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/2 0:14, Jaegeuk Kim wrote:
> How about v4?

It looks good to me.

Thanks,
