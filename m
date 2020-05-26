Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D741CA465
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEHGmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 02:42:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4349 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgEHGmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:42:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4B68F644DD8B07BD068;
        Fri,  8 May 2020 14:42:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 14:42:42 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix zstd data corruption
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200508011603.54553-1-yuchao0@huawei.com>
 <CACOAw_xxS_Wf==KnD31f9AOMu+QUs3WacowsfcD6w4A9n2AkTg@mail.gmail.com>
 <0d41e29e-c601-e016-e471-aed184ca4a6a@huawei.com>
 <CACOAw_z39D=2GONkMaQX6pSi2z26nqCvBZwZK-M=n3_yc84+yg@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2a241a80-2597-ef9e-62b5-cf2b8bdb33c4@huawei.com>
Date:   Fri, 8 May 2020 14:42:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_z39D=2GONkMaQX6pSi2z26nqCvBZwZK-M=n3_yc84+yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/8 11:30, Daeho Jeong wrote:
> I am a little bit confused.
> 
> In compress_log=2 (4 pages),
> 
> Every compression algorithm will set the cc->nr_cpages to 5 pages like below.
> 
>         max_len = COMPRESS_HEADER_SIZE + cc->clen;
>         cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
> 
>         cc->cpages = f2fs_kzalloc(sbi, sizeof(struct page *) *
>                                         cc->nr_cpages, GFP_NOFS);
> 
> And call cops->compress_pages(cc) and the returned length of the compressed data will be set to cc->clen for every case.
> And if the cc->clen is larger than max_len, we will give up compression.
> 
>         ret = cops->compress_pages(cc);
>         if (ret)
>                 goto out_vunmap_cbuf;
> 
>         max_len = PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
> 
>         if (cc->clen > max_len) {
>                 ret = -EAGAIN;
>                 goto out_vunmap_cbuf;
>         }
> 
> So, with your patch, we will just use 3 pages for ZSTD and 5 pages for LZO and LZ4 now.
> My question was whether it is also possible to decrease the compression buffer size for LZO and LZ4 to 3 pages like ZSTD case.
> I was just curious about that. :)
I guess we can change LZ4 as we did for ZSTD case, since it supports partially
compression:

- lz4_compress_pages
 - LZ4_compress_default
  - LZ4_compress_fast
   - LZ4_compress_fast_extState
    if (maxOutputSize < LZ4_COMPRESSBOUND(inputSize))
     - LZ4_compress_generic(..., limitedOutput, ...)
      - if (outputLimited && boundary_check_condition) return 0;

And for LZO case, it looks we have to keep to allocate 5 pages for worst
compression case as it doesn't support partially compression as I checked.

Thanks,

> 
> 
> 2020년 5월 8일 (금) 오전 11:48, Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>님이 작성:
> 
>     Hi Daeho,
> 
>     On 2020/5/8 9:28, Daeho Jeong wrote:
>     > Hi Chao,
>     >
>     > IIUC, you are trying not to use ZSTD_compressBound() to save the memory
>     > space. Am I right?
>     >
>     > Then, how about LZ4_compressBound() for LZ4 and lzo1x_worst_compress() for
>     > LZO?
> 
>     Oops, it looks those limits were wrongly used...
> 
>     #define LZ4_COMPRESSBOUND(isize)        (\
>             (unsigned int)(isize) > (unsigned int)LZ4_MAX_INPUT_SIZE \
>             ? 0 \
>             : (isize) + ((isize)/255) + 16)
> 
>     #define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)
> 
>     Newly calculated boundary size is larger than target buffer size.
> 
>     However comments on LZ4_compress_default() said:
> 
>     ...
>      * @maxOutputSize: full or partial size of buffer 'dest'
>      *      which must be already allocated
>     ...
>     int LZ4_compress_default(const char *source, char *dest, int inputSize,
>             int maxOutputSize, void *wrkmem);
> 
>     And @out_len in lzo1x_1_compress() was passed as an output parameter to
>     pass length of data that compressor compressed into @out buffer.
> 
>     Let me know if I missed sth.
> 
>     Thannks,
> 
>     > Could we save more memory space for these two cases like ZSTD?
>     > As you know, we are using 5 pages compression buffer for LZ4 and LZO in
>     > compress_log_size=2,
>     > and if the compressed data doesn't fit in 3 pages, it returns -EAGAIN to
>     > give up compressing that one.
>     >
>     > Thanks,
>     >
>     > 2020년 5월 8일 (금) 오전 10:17, Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>님이 작성:
>     >
>     >> During zstd compression, ZSTD_endStream() may return non-zero value
>     >> because distination buffer is full, but there is still compressed data
>     >> remained in intermediate buffer, it means that zstd algorithm can not
>     >> save at last one block space, let's just writeback raw data instead of
>     >> compressed one, this can fix data corruption when decompressing
>     >> incomplete stored compression data.
>     >>
>     >> Signed-off-by: Daeho Jeong <daehojeong@google.com <mailto:daehojeong@google.com>>
>     >> Signed-off-by: Chao Yu <yuchao0@huawei.com <mailto:yuchao0@huawei.com>>
>     >> ---
>     >>  fs/f2fs/compress.c | 7 +++++++
>     >>  1 file changed, 7 insertions(+)
>     >>
>     >> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>     >> index c22cc0d37369..5e4947250262 100644
>     >> --- a/fs/f2fs/compress.c
>     >> +++ b/fs/f2fs/compress.c
>     >> @@ -358,6 +358,13 @@ static int zstd_compress_pages(struct compress_ctx
>     >> *cc)
>     >>                 return -EIO;
>     >>         }
>     >>
>     >> +       /*
>     >> +        * there is compressed data remained in intermediate buffer due to
>     >> +        * no more space in cbuf.cdata
>     >> +        */
>     >> +       if (ret)
>     >> +               return -EAGAIN;
>     >> +
>     >>         cc->clen = outbuf.pos;
>     >>         return 0;
>     >>  }
>     >> --
>     >> 2.18.0.rc1
>     >>
>     >>
>     >>
>     >> _______________________________________________
>     >> Linux-f2fs-devel mailing list
>     >> Linux-f2fs-devel@lists.sourceforge.net <mailto:Linux-f2fs-devel@lists.sourceforge.net>
>     >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>     >>
>     >
> 
