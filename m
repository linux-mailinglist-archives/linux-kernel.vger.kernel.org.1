Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431072CE56F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLDB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:57:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8641 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:57:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnG5J5YQ0z15X7D;
        Fri,  4 Dec 2020 09:56:04 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 09:56:28 +0800
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Eric Biggers <ebiggers@kernel.org>, <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com> <20201204003119.GA1957051@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
Date:   Fri, 4 Dec 2020 09:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201204003119.GA1957051@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2020/12/4 8:31, Gao Xiang wrote:
> Hi Chao,
> 
> On Thu, Dec 03, 2020 at 11:32:34AM -0800, Eric Biggers wrote:
> 
> ...
> 
>>
>> What is the use case for storing the compression level on-disk?
>>
>> Keep in mind that compression levels are an implementation detail; the exact
>> compressed data that is produced by a particular algorithm at a particular
>> compression level is *not* a stable interface.  It can change when the
>> compressor is updated, as long as the output continues to be compatible with the
>> decompressor.
>>
>> So does compression level really belong in the on-disk format?
>>
> 
> Curious about this, since f2fs compression uses 16k f2fs compress cluster
> by default (doesn't do sub-block compression by design as what btrfs did),
> so is there significant CR difference between lz4 and lz4hc on 16k
> configuration (I guess using zstd or lz4hc for 128k cluster like btrfs
> could make more sense), could you leave some CR numbers about these
> algorithms on typical datasets (enwik9, silisia.tar or else.) with 16k
> cluster size?

Yup, I can figure out some numbers later. :)

> 
> As you may noticed, lz4hc is much slower than lz4, so if it's used online,
> it's a good way to keep all CPUs busy (under writeback) with unprivileged
> users. I'm not sure if it does matter. (Ok, it'll give users more options
> at least, yet I'm not sure end users are quite understand what these
> algorithms really mean, I guess it spends more CPU time but without much
> more storage saving by the default 16k configuration.)
> 
> from https://github.com/lz4/lz4    Core i7-9700K CPU @ 4.9GHz
> Silesia Corpus
> 
> Compressor              Ratio   Compression     Decompression
> memcpy                  1.000   13700 MB/s      13700 MB/s
> Zstandard 1.4.0 -1      2.883   515 MB/s	1380 MB/s
> LZ4 HC -9 (v1.9.0)      2.721   41 MB/s         4900 MB/s

There is one solutions now, Daeho has submitted two patches:

f2fs: add compress_mode mount option
f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE

Which allows to specify all files in data partition be compressible, by default,
all files are written as non-compressed one, at free time of system, we can use
ioctl to reload and compress data for specific files.

> 
> Also a minor thing is lzo-rle, initially it was only used for in-memory
> anonymous pages and it won't be kept on-disk so that's fine. I'm not sure
> if lzo original author want to support it or not. It'd be better to get


Hmm.. that's a problem, as there may be existed potential users who are
using lzo-rle, remove lzo-rle support will cause compatibility issue...

IMO, the condition "f2fs may has persisted lzo-rle compress format data already"
may affect the decision of not supporting that algorithm from author.

> some opinion before keeping it on-disk.

Yes, I can try to ask... :)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> - Eric
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 
