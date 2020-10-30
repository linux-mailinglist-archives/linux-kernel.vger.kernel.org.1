Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFD29FB75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgJ3Chx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:37:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6991 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgJ3Chw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:37:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CMmgh63FFzhd3g;
        Fri, 30 Oct 2020 10:37:52 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 30 Oct
 2020 10:37:45 +0800
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION
 ioctl
From:   Chao Yu <yuchao0@huawei.com>
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20201029041538.4165209-1-daeho43@gmail.com>
 <861e569d-feae-c521-35b7-dcb8b79cdfba@huawei.com>
Message-ID: <61d43f5d-f26c-525a-6405-bae0ca495c6d@huawei.com>
Date:   Fri, 30 Oct 2020 10:37:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <861e569d-feae-c521-35b7-dcb8b79cdfba@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/29 15:24, Chao Yu wrote:
> On 2020/10/29 12:15, Daeho Jeong wrote:

>> +	inode_lock(inode);
> 
> It's minor,
> 
> inode_lock_shared()?
> 
>> +
>> +	if (!f2fs_compressed_file(inode)) {
>> +		inode_unlock(inode);
> 
> inode_unlock_shared()?
> 
>> +		return -ENODATA;
>> +	}
>> +
>> +	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
>> +	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
>> +
>> +	inode_unlock(inode);
> 
> ditto.

Any comments?

Thanks,
