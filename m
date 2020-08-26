Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2512527B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 08:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHZGsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 02:48:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbgHZGsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:48:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EED8939BD2D5B9716034;
        Wed, 26 Aug 2020 14:48:11 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 26 Aug
 2020 14:48:06 +0800
Subject: Re: [PATCH v2 5/5] f2fs: support age threshold based garbage
 collection
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200804131449.50517-1-yuchao0@huawei.com>
 <20200804131449.50517-6-yuchao0@huawei.com>
 <20200825193404.GA2614120@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cfee98ee-382f-7bf2-4a99-d1ac2d6a3b0c@huawei.com>
Date:   Wed, 26 Aug 2020 14:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200825193404.GA2614120@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Jaegeuk, :)

On 2020/8/26 3:34, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I modified directly like below which makes fsck complain wrong free segment
> number.
