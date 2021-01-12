Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485F52F28D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbhALHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:19:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10711 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbhALHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:19:51 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFMNX1ZcGzl448;
        Tue, 12 Jan 2021 15:17:48 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 12 Jan
 2021 15:19:00 +0800
Subject: Re: [PATCH -next] f2fs: docs: rectify the table header in
 sysfs-fs-f2fs
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-doc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210112063930.20525-1-lukas.bulwahn@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4d28715d-74ed-2ca2-ae4c-d5e88731e5c6@huawei.com>
Date:   Tue, 12 Jan 2021 15:18:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210112063930.20525-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/12 14:39, Lukas Bulwahn wrote:
> Commit 969945899a35 ("f2fs: introduce sb_status sysfs node") documents the
> sb_status values in a table in ./Documentation/ABI/testing/sysfs-fs-f2fs,
> but the table header of the first column has a wrong length.
Thanks for fixing this, however original patch was still in dev branch of
f2fs, so I prefer to fix original patch rather than adding a new fixing patch.

Would you mind merging this into original patch?

Thanks,
