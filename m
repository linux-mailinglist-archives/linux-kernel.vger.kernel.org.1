Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4399C2CE58B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgLDCIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607047634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxHGQsBlpLQuTDMJXZrWsBJjFIx/LYv87Cod4+aHr9s=;
        b=Qa06mvvXHVbq2U5iJdQ6F1vG+K8iqIjjF1TDoWwFqXuSXiQs5VKKBRO0LioUGGdAVfgKhp
        62PsQ8sF2Yi1plCZQreE8g+xLE3z6+2JDW/bBT4w19Q85h3UPjTvZklyk/L3IQBWswNGLX
        PF5/sw0PYETezPlKQ/20NjYxUqR4S5g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-KF6F0wUxMu-tcM3EDUm-lw-1; Thu, 03 Dec 2020 21:07:12 -0500
X-MC-Unique: KF6F0wUxMu-tcM3EDUm-lw-1
Received: by mail-pj1-f70.google.com with SMTP id p6so2842147pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxHGQsBlpLQuTDMJXZrWsBJjFIx/LYv87Cod4+aHr9s=;
        b=E+5V5JG3DV8hFGAOSF9+Kwxwec/Ny2CXEatIYDm1KWnpzgi3EsJi3I/mdpbI1TSVFS
         P8/nf6Jg3nbncX2L4oQ1wtDnNb/KNc3kMztGl8Dqw9XtMD8rOFFj7UHiOnJVi8oBz1hH
         /gSCcvnrMfNSgYZlYSqWAUu+l04Jy+rH68Qa9+nrpgC/6Yov6XosMbfqCSayxylgdb5P
         wyLI0kZdNqtm89CU2H5bQQil+pAyBTnPXxJynJx2uoLzTH/eAiouRFF3xD7CMQhnuRw3
         QXu2BP22aU3t2VM+qfWXQBPDpCJCZ01omp8QIo68aJ3hGVblK29npj9eVd4/4rNKw8pt
         0v2g==
X-Gm-Message-State: AOAM532hUB7TBJOy5f7nA8/mC8ae7zNH1SVZYtKXlfFt0oQBqOHunk+b
        ugYelxOueU4MZT5ugVfh2bBlLItGmJexTBR0MgFWibbVMBA4IOqRhHWcaq+xGXoq4Pi0s8j+i4I
        lrWJan2tulD6jpQK9G5TTj+JE
X-Received: by 2002:a63:e502:: with SMTP id r2mr5641670pgh.308.1607047631317;
        Thu, 03 Dec 2020 18:07:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVCcgiTEAfs2WeNWNAikcp00j2f14t84/QAqAvr6qrNmjA30ji78GzwaEsS5x0E1WOnWspKw==
X-Received: by 2002:a63:e502:: with SMTP id r2mr5641649pgh.308.1607047630945;
        Thu, 03 Dec 2020 18:07:10 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y19sm3063476pfp.211.2020.12.03.18.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:07:10 -0800 (PST)
Date:   Fri, 4 Dec 2020 10:06:59 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <20201204020659.GB1963435@xiangao.remote.csb>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
 <20201204003119.GA1957051@xiangao.remote.csb>
 <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:56:27AM +0800, Chao Yu wrote:
> Hi Xiang,
> 
> On 2020/12/4 8:31, Gao Xiang wrote:
> > Hi Chao,
> > 
> > On Thu, Dec 03, 2020 at 11:32:34AM -0800, Eric Biggers wrote:
> > 
> > ...
> > 
> > > 
> > > What is the use case for storing the compression level on-disk?
> > > 
> > > Keep in mind that compression levels are an implementation detail; the exact
> > > compressed data that is produced by a particular algorithm at a particular
> > > compression level is *not* a stable interface.  It can change when the
> > > compressor is updated, as long as the output continues to be compatible with the
> > > decompressor.
> > > 
> > > So does compression level really belong in the on-disk format?
> > > 
> > 
> > Curious about this, since f2fs compression uses 16k f2fs compress cluster
> > by default (doesn't do sub-block compression by design as what btrfs did),
> > so is there significant CR difference between lz4 and lz4hc on 16k
> > configuration (I guess using zstd or lz4hc for 128k cluster like btrfs
> > could make more sense), could you leave some CR numbers about these
> > algorithms on typical datasets (enwik9, silisia.tar or else.) with 16k
> > cluster size?
> 
> Yup, I can figure out some numbers later. :)
> 
> > 
> > As you may noticed, lz4hc is much slower than lz4, so if it's used online,
> > it's a good way to keep all CPUs busy (under writeback) with unprivileged
> > users. I'm not sure if it does matter. (Ok, it'll give users more options
> > at least, yet I'm not sure end users are quite understand what these
> > algorithms really mean, I guess it spends more CPU time but without much
> > more storage saving by the default 16k configuration.)
> > 
> > from https://github.com/lz4/lz4    Core i7-9700K CPU @ 4.9GHz
> > Silesia Corpus
> > 
> > Compressor              Ratio   Compression     Decompression
> > memcpy                  1.000   13700 MB/s      13700 MB/s
> > Zstandard 1.4.0 -1      2.883   515 MB/s	1380 MB/s
> > LZ4 HC -9 (v1.9.0)      2.721   41 MB/s         4900 MB/s
> 
> There is one solutions now, Daeho has submitted two patches:
> 
> f2fs: add compress_mode mount option
> f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
> 
> Which allows to specify all files in data partition be compressible, by default,
> all files are written as non-compressed one, at free time of system, we can use
> ioctl to reload and compress data for specific files.
> 

Yeah, my own premature suggestion is there are many compression options
exist in f2fs compression, but end users are not compression experts.
So it'd better to leave advantage options to users (or users might be
confused or select wrong algorithm or make potential complaint...)

Keep lz4hc dirty data under writeback could block writeback, make kswapd
busy, and direct memory reclaim path, I guess that's why rare online
compression chooses it. My own premature suggestion is that it'd better
to show the CR or performance benefits in advance, and prevent unprivileged
users from using high-level lz4hc algorithm (to avoid potential system attack.)
either from mount options or ioctl.

> > 
> > Also a minor thing is lzo-rle, initially it was only used for in-memory
> > anonymous pages and it won't be kept on-disk so that's fine. I'm not sure
> > if lzo original author want to support it or not. It'd be better to get
> 
> 
> Hmm.. that's a problem, as there may be existed potential users who are
> using lzo-rle, remove lzo-rle support will cause compatibility issue...
> 
> IMO, the condition "f2fs may has persisted lzo-rle compress format data already"
> may affect the decision of not supporting that algorithm from author.
> 
> > some opinion before keeping it on-disk.
> 
> Yes, I can try to ask... :)

Yeah, it'd be better to ask the author first, or it may have to maintain
a private lz4-rle folk...

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > - Eric
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 
> 

