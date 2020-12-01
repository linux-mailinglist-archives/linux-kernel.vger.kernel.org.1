Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353C72CAB7B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgLATLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:11:09 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3191C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:10:29 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id v3so1658697plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H90UyAJzvmoPRUfMh6apfAgsUXazwUJB3aNHvcWIGHI=;
        b=I5YX0/C5nVbGAWieLr/8Ha6VtOsNkjWnnJ2Qd/Y9ewwbhhMcDtFL+5KhABvcX+In0o
         x7Xu2ydSilrJRpv0QQ8N/m0XoiMV6C4Q53/6aaxK+lQ1S2YGq5YNRaKjjq7HGffu86TL
         UhHkgFuFvIpcoYkdkwwdicoqg0Coi5RRsjjzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H90UyAJzvmoPRUfMh6apfAgsUXazwUJB3aNHvcWIGHI=;
        b=GZrW+1I7pGslz1FD/a1Dj+5tm7eBAkCvdbNv9V+GtO5Y+kuUmmUypwcemncNEls4OI
         m1Y3aYXEBjabIsFQRndBsnICf9h6J2fUhPWUav4fpmgN/vAgG7mXr35V2gx4idG2xXqp
         IZnfVHcDSbfApzdYLiXYaeZJEhiDpV8f05a6KSB1UxsINqIlCLE8NaUzFOzMCyNG4afb
         wq4VVIWK8kueaVyC1X3O+PkRXx3LGvpnzjm43guPAvkQ2Zhih0vpa0xlCecjCPgt+shm
         ZNBdUlrjsqoHk3dOkUwZBHjxADVWpsDt0RCytY0iHAY1aYWjtLn8u7rgwff/GQy53QtT
         xJgg==
X-Gm-Message-State: AOAM532AkrHtyomhXu7nC6B8Yuxhr+Tb8JwdgLBqYBQQ6kRZ4jTaOz5v
        Vc0pUl2cTVu3Ifo6uiDJuYwv4A==
X-Google-Smtp-Source: ABdhPJx7x0iRMtUz5Ywwp5v5n5BadeJy9m8KDj6Zo4n0WVF4edJ+2HmN3yI/8gKoFC66PFpZIwuaCA==
X-Received: by 2002:a17:902:9a4c:b029:d6:1f21:8021 with SMTP id x12-20020a1709029a4cb02900d61f218021mr4154492plv.58.1606849829316;
        Tue, 01 Dec 2020 11:10:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 184sm542646pfc.28.2020.12.01.11.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:10:28 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:10:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] pstore/blk: update the command line example
Message-ID: <202012011109.6D417FB4@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:40PM +0200, Christoph Hellwig wrote:
> Use the human readable device name instead of the device number, and
> add the required best_effort parameter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, best_effort is needed here. I think changing from major:minor to a
path is also fine.

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  Documentation/admin-guide/pstore-blk.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
> index 296d5027787ac2..d9ec8b0572d3b2 100644
> --- a/Documentation/admin-guide/pstore-blk.rst
> +++ b/Documentation/admin-guide/pstore-blk.rst
> @@ -35,7 +35,7 @@ module parameters have priority over Kconfig.
>  
>  Here is an example for module parameters::
>  
> -        pstore_blk.blkdev=179:7 pstore_blk.kmsg_size=64
> +        pstore_blk.blkdev=/dev/mmcblk0p7 pstore_blk.kmsg_size=64 best_effort=y
>  
>  The detail of each configurations may be of interest to you.
>  
> -- 
> 2.28.0
> 

-- 
Kees Cook
