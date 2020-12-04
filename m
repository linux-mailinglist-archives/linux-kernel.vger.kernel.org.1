Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28EE2CE47B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbgLDAdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgLDAdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607041897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mAp0zfGpgeyDdpWyEdaWC5DSXakMnn28Gue+5urM60=;
        b=PTjLtGsUNAjvMDiWeiPHcu3O2JD/8iYgV2YbW5BGYFJd+yya2En2vswLvxocoHRLOBgcLi
        hCcyS4wfnn+GapoPQFoTTuuaFTJZPtYZ7dXImMUk33UQE4+3n97dezwl5Vr7vCxISCTGCs
        GVF1JxxR6/c2nwZwH3HH9MQZoVc8eLU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-bi_NP-v3Nsm-a0D4CWs7jQ-1; Thu, 03 Dec 2020 19:31:35 -0500
X-MC-Unique: bi_NP-v3Nsm-a0D4CWs7jQ-1
Received: by mail-pl1-f197.google.com with SMTP id x11so2150204plo.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mAp0zfGpgeyDdpWyEdaWC5DSXakMnn28Gue+5urM60=;
        b=uXzPyoxsvMtKuSIhf8L5ZmRIVsO4YRXniAaU8aerv6PHvVVOrF/DHQFxH0UjyBVZUl
         w7BWBvythMf6ZRbj9N7RJV7A1v4JaQWX+/yztI2Cio1GeGe5hYq6u+ZsSMUEVhRWV/W/
         cy4dyDFGiOm1MSFHyTW10fF852B8xvGx+2hNMyIbPh8feJsujYo+8Xk2Yy+sYqwTVPxF
         krfQg4BWXQhHub5n3dywuA8NKsmCBSDSPV7GtHrQS6eNQLqnUDeymCh4dlre46ofdsCX
         lHQGyna7HGoFrDtjrnnMfkDb0Tgj5jyQsGRvHAcCwYlDoTIdZuS4eJ07BpCYKp7XZw9y
         w6Kg==
X-Gm-Message-State: AOAM532rTJv+k44ittmwlVKI1cLGQUzq22A1IV4TX4MZ68e63Dp6ZMzq
        YlY3Z0JuKJAvkib4nmU5Ynb/G2/6XW4ntuAeE1cYfFpG2ALnifvkZ0NdVLsMhTYBUun4wqJY6T+
        Dslqsu5eGfty101NA8z+s5+Q0
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr1574187pjz.168.1607041894609;
        Thu, 03 Dec 2020 16:31:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVzK1aMZnIsdP2uBywNAqLlD6nz6l7chr6tH9+UsvJY25t+xk7F+gDLz78gw2UP2gnAZNkxQ==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr1574176pjz.168.1607041894347;
        Thu, 03 Dec 2020 16:31:34 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u205sm2915866pfc.146.2020.12.03.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:31:33 -0800 (PST)
Date:   Fri, 4 Dec 2020 08:31:19 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <20201204003119.GA1957051@xiangao.remote.csb>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8k9UoUKcyThlJNU@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Thu, Dec 03, 2020 at 11:32:34AM -0800, Eric Biggers wrote:

...

> 
> What is the use case for storing the compression level on-disk?
> 
> Keep in mind that compression levels are an implementation detail; the exact
> compressed data that is produced by a particular algorithm at a particular
> compression level is *not* a stable interface.  It can change when the
> compressor is updated, as long as the output continues to be compatible with the
> decompressor.
> 
> So does compression level really belong in the on-disk format?
> 

Curious about this, since f2fs compression uses 16k f2fs compress cluster
by default (doesn't do sub-block compression by design as what btrfs did),
so is there significant CR difference between lz4 and lz4hc on 16k
configuration (I guess using zstd or lz4hc for 128k cluster like btrfs
could make more sense), could you leave some CR numbers about these
algorithms on typical datasets (enwik9, silisia.tar or else.) with 16k
cluster size?

As you may noticed, lz4hc is much slower than lz4, so if it's used online,
it's a good way to keep all CPUs busy (under writeback) with unprivileged
users. I'm not sure if it does matter. (Ok, it'll give users more options
at least, yet I'm not sure end users are quite understand what these
algorithms really mean, I guess it spends more CPU time but without much
more storage saving by the default 16k configuration.)

from https://github.com/lz4/lz4    Core i7-9700K CPU @ 4.9GHz
Silesia Corpus

Compressor              Ratio   Compression     Decompression
memcpy                  1.000   13700 MB/s      13700 MB/s
Zstandard 1.4.0 -1      2.883   515 MB/s	1380 MB/s
LZ4 HC -9 (v1.9.0)      2.721   41 MB/s         4900 MB/s

Also a minor thing is lzo-rle, initially it was only used for in-memory
anonymous pages and it won't be kept on-disk so that's fine. I'm not sure
if lzo original author want to support it or not. It'd be better to get
some opinion before keeping it on-disk.

Thanks,
Gao Xiang

> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

