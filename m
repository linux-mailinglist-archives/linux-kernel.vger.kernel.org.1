Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8029FADC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgJ3Bw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:52:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7100 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgJ3BwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:52:18 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMlg60RdbzLmp9;
        Fri, 30 Oct 2020 09:52:18 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 30 Oct
 2020 09:52:15 +0800
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, "Daeho Jeong" <daehojeong@google.com>
References: <20201029041538.4165209-1-daeho43@gmail.com>
 <20201029041538.4165209-2-daeho43@gmail.com>
 <92f4da8e-27a1-7577-84f9-39038eaa88cb@huawei.com>
 <20201029155453.GB849@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <69dfcb36-158c-e524-494c-6c5377a56945@huawei.com>
Date:   Fri, 30 Oct 2020 09:52:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201029155453.GB849@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/29 23:54, Eric Biggers wrote:
> Note that my intent with recommending ENOPKG was for it to be returned in the
> !f2fs_cops[algorithm] case, similar to how opening an encrypted file when the
> encryption algorithm is recognized but not supported by the kernel returns
> ENOPKG.  For a truly unrecognized algorithm (algorithm >= COMPRESS_MAX), EINVAL
> would probably be more appropriate.  So if !f2fs_cops[algorithm] is now allowed,
> then ENOPKG should no longer be among the error codes this ioctl returns.

Agreed.

Thanks,

> 
> - Eric
> .
> 
