Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABE2004CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgFSJRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 05:17:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbgFSJRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:17:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69C6EAD15B3E23525768;
        Fri, 19 Jun 2020 17:17:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 17:17:43 +0800
Subject: Re: [PATCH v3] f2fs-tools: introduce set_node_footer to initialize
 node footer
To:     <zhaowuyun@wingtech.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1592556344-2301-1-git-send-email-zhaowuyun@wingtech.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0ae2bfe6-70c0-82ad-6973-300fde3edbcd@huawei.com>
Date:   Fri, 19 Jun 2020 17:17:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1592556344-2301-1-git-send-email-zhaowuyun@wingtech.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/19 16:45, zhaowuyun@wingtech.com wrote:
> From: Wuyun Zhao <zhaowuyun@wingtech.com>
> 
> the filesystem will use the cold flag, so deal with it to avoid
> potential issue of inconsistency
> 
> Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
