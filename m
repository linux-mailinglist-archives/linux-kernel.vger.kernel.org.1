Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2455A2C7D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgK3DSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgK3DSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:18:24 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53904C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 19:17:44 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so5704139plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 19:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zwbwZcpp3gI3cc3GYkT8OX/wHY+SvDyCSQpo9znuRHc=;
        b=oQ4EXki5q+k/2QQHRJfVognb/E2BspR3JKt9edeiB5ImwUrn793BofB1b3ROvNic2r
         796NjG+Vv+BdEPQleuTy0nafnjvTXwvuxqVFyyQMdYQ+9p0Y4D9ZqufAU/yZBfcTWI3C
         9WLJ/ljNV3d3Vt6UMhcRYCSTD761qez81TdM92k2AGH4eaRetGAqoLt4RKQwql+BgVlp
         W51QOtEacdImYHVXvQnmtv86HgJqpSL81aaYDJ5eny6BtAWyavfG+n8KWIXj3esR3/c2
         UCvIRNK6d/prb8qh67c2jjMOFjJfjL93nFOP1MZoW2MunW+Ax/mWaTzgtTS/OEj95WQI
         mfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zwbwZcpp3gI3cc3GYkT8OX/wHY+SvDyCSQpo9znuRHc=;
        b=tG7aOPsEDFUCWF7cMVTE8AEVfsuOfLDu+riP6oGwKjQD2uN68p/sQmwZUllLi06ivw
         2lNP/jx9Z6bxzgSaFC4y4IUsCpSvOv6e/qm77CqvN0oAJuBI1S6BJVIA9DbKtXjdaQD7
         GXso9fA4x9phIipP7YsrdmwdHqg3dNkponNAPqAvCRVho6y0RrvROazB515zCm90P8WC
         eIcL+LiL3jxPoKALwURBfbwmFRt4N7wyDau9fHWO9rpWwotA0xpuwq6WgwiStwwiI8Nq
         N/cKcpGFgHleZUAQ/FpbPGusOvRKmitqysdbNuvOk2Q+ln8ldYvii/GmkJcEIPSgjqGg
         xaFQ==
X-Gm-Message-State: AOAM531fwTWPXwhuG2gVf9nXLCjvEfQoZHkPjx5Fevhxn+b9t6EAfUMe
        NJRwLX67W0axw54W4FnKs30=
X-Google-Smtp-Source: ABdhPJzc+0ywB5gG6nhsmtRo3eT0VZ2DVebwgFc0YbIQioeskO1B9GCBcyRZWETcM2SNYkCCetlE6w==
X-Received: by 2002:a17:902:744b:b029:da:74ca:b5f2 with SMTP id e11-20020a170902744bb02900da74cab5f2mr3484759plt.22.1606706263902;
        Sun, 29 Nov 2020 19:17:43 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id j74sm14564506pfd.43.2020.11.29.19.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 19:17:43 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:17:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
Message-ID: <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain>
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
 <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/30 12:15), Sergey Senozhatsky wrote:
> On (20/11/29 18:00), Randy Dunlap wrote:
> > On 11/29/20 5:44 PM, Sergey Senozhatsky wrote:
> > > Some functions that are declared when CONFIG_POSIX_ACL is defined
> > > are not declared when CONFIG_POSIX_ACL is not defined. Add the
> > > missing ones:
> > >   set_posix_acl(), posix_acl_update_mode(), get_cached_acl(),
> > >   get_cached_acl_rcu(), set_cached_acl(), forget_cached_acl().
> > > 
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > Hi,
> > 
> > I can't find CONFIG_POSIX_ACL in the kernel source tree.
> > Should it be CONFIG_FS_POSIX_ACL ?
> 
> Oh, yes, CONFIG_POSIX_ACL. My bad.

     ...   CONFIG_FS_POSIX_ACL. I did it again.

	-ss
