Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8F2CE670
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgLDDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgLDDXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607052114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCINrh3VNpkGouXddHNxS7sFf+jq22dtzVWiRPWZKl8=;
        b=LQVgg9Wz/em8BJDSb+sv/0HsqAtgP9JWbytTzCRc+iRhhkFVtP8ZakXuQc23tuwczACnE9
        53/w5Pvjo3NMUwPqWn9tMCz1k0tYHj7/PH0ugpVOtf9gYVOQKSdDwnsIF7bA/ZOOBXkwgk
        HY9qns0dio0/nlycenb23LfjAW+4RhE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-irvZ0fuMPZekq7NAJfngIA-1; Thu, 03 Dec 2020 22:21:52 -0500
X-MC-Unique: irvZ0fuMPZekq7NAJfngIA-1
Received: by mail-pf1-f200.google.com with SMTP id r15so2787390pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 19:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCINrh3VNpkGouXddHNxS7sFf+jq22dtzVWiRPWZKl8=;
        b=KDLz0VC29eJTE+yCuQrMA34j4x6Ecbyn0D6g0C11vZoeihXogX6Zagh3fQ6GsVKoYZ
         8mt+mX9JgQY0eY/3d0gipo8IgEH6xCcBWHf+ZMWIiSAt6PDcLJfBNaeynmnBq57PxvTl
         T7fYCzBC24d/2agHtQak1DeTs9NIZQ/vn2iBF8Rbp2BXQ1oVhxb6/0Pr+upaazRshmIk
         p00a99vBObBx+uTbxCE3mEF0Y/sbh+xt931GqNy7aeBfkJrcCwIM+tOgN/laWrCv7+BJ
         ljS6Bk3SXsBy9X589sYDiK3n5/Esbdv63XLf4qOydPiJyYDrvveTRJyihW2aColiwZ89
         /UpA==
X-Gm-Message-State: AOAM5329s29rjI0aYqfnCA2MJbDcxelA0sSaRyXI+R2ru/Vqd1LgR4ED
        +iWF4CQggwIz419mvq/WG1AUYCl6w8955M+pHAONcj92ALnYT+Ygr8XNHcuM7MDWkogaN7zFd4L
        wngzX576AKJTyIyKebis8HV57
X-Received: by 2002:aa7:8f35:0:b029:19b:1258:ec5d with SMTP id y21-20020aa78f350000b029019b1258ec5dmr2079489pfr.9.1607052111357;
        Thu, 03 Dec 2020 19:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2VxNKUALmnFA+8MX11vWPTJT60okdryyGIBTDAupAp6zmoczzVNWutiMV27zPuUM1/ie90Q==
X-Received: by 2002:aa7:8f35:0:b029:19b:1258:ec5d with SMTP id y21-20020aa78f350000b029019b1258ec5dmr2079481pfr.9.1607052111126;
        Thu, 03 Dec 2020 19:21:51 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i123sm624927pfb.28.2020.12.03.19.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 19:21:50 -0800 (PST)
Date:   Fri, 4 Dec 2020 11:21:40 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <20201204032140.GD1963435@xiangao.remote.csb>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
 <20201204003119.GA1957051@xiangao.remote.csb>
 <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
 <20201204020659.GB1963435@xiangao.remote.csb>
 <3041968d-87d0-d2dc-822b-0bb4a94a365b@huawei.com>
 <20201204024746.GC1963435@xiangao.remote.csb>
 <15afffcc-636d-b678-0c01-b2fad98d9311@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15afffcc-636d-b678-0c01-b2fad98d9311@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:11:03AM +0800, Chao Yu wrote:
> On 2020/12/4 10:47, Gao Xiang wrote:

...

> 
> > future (and add more dependency to algorithms, you might see BWT-based bzip2
> > removal patch
> 
> Oops, is that really allowed? I don't this is a good idea...and I don't see there
> are deletions from fs/ due to similar reason...

Fortunately, bzip is quite slow algorithm, so not affective at all.

My personal opinion based on compress algorithm principle (just for reference
as well...)
 - zlib should be better replaced with libdeflate if possible, the main point
   is that many hardware accelerator for deflate (LZ77 + huffman) are
   available;

 - lzo is not attractive from its format complexity and its CR/performance
    goal so lz4 is generally better due to its format design;

 - lzo-rle, oops, just introduced for zram I think, not sure quite helpful
   for file data (since anonymous pages are generally RLE-effective due to
   many repeative data.) But it'd be good if lzo author accepts it.

Thanks,
Gao Xiang

> 
> Thanks,
> > 
> 

