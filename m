Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA26B2CC54C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgLBSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731002AbgLBSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:35:19 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:34:39 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y18so2189601qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G4Rb/iEqWvKjuXSHou+bQSyzGRLIPVOqsUgWVUCbZ+U=;
        b=Gx52ocf/sRmNTzI3/f7trH7GQqHxqO3NRU0QvIXIDv8JM9L3NeV5IVMTV9so3hntB9
         iaX5Ge04WHTMKNvBzmKS0Vqv0jFZQottPU51fEd5tq4OkqyrR/HIP349FYdBrj2610cN
         7ZWfhnAAmAAJ3l9NVtfuLIjX+s87rSvjbc+rCoC5hkdJQXQTI+HEb+tF45m4J8hdcb50
         nvLNiHTzb5w8PQlYJIcK0rAF99Agrp7b18B4muQ5nBeGY3SaFL29kaqvA+bZ+x6c9HoK
         PhlwH4TEPnlsP8E40jQfJpQjqvmVeRV/v44H/7giPWYN+DcaOUQYNh89ovMGhsxhYlfO
         jE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G4Rb/iEqWvKjuXSHou+bQSyzGRLIPVOqsUgWVUCbZ+U=;
        b=XzglH90sLvN5YYneJbkMwoHFBh74HxFPLrocN9r06tGfH6vqCVqRIogSyMTu0SLqM/
         N8uDe5J++qgWVRM04vicSnjzO2frteapKBU82nYyRt6Usvts5X9/w4MmAiqzKkAf9fuu
         fQgPSfWW+mg7iH2sFCeNvEsDN+N3MzkODrDmEwHfYLVY60MOpF8aGaPDJWl8s43plOX9
         1GF/GTJZ31XUA6TPoukDBvCxVPZdn0nVlOCVbBpnXJ9MoiZMskD4tlQuaEmC8XeJT3vk
         /ZScSaOpcGaDMhjWWCWLDyiMb/ySJNWMR/jZjNIC69M28UzPuCAXRPNBWXMnTDcVn27r
         0V8A==
X-Gm-Message-State: AOAM5316LfGWcGZAGG+bm7eHGJ0LsSPFAfMVYBhuUDCg/Gs18LLltWFd
        RC12o1GBmU6boHtpATex2BI=
X-Google-Smtp-Source: ABdhPJz1M0rTHxPGm2r1CQ80xA551sHzTfmset08UkYrdfsRHPtedxEjP3YNb7PMCHaWzrWdQ2ECjQ==
X-Received: by 2002:a05:620a:57b:: with SMTP id p27mr3911509qkp.417.1606934078808;
        Wed, 02 Dec 2020 10:34:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id g70sm2627235qke.8.2020.12.02.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:34:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 13:34:10 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernfs: replace the mutex in kernfs_iop_permission
 with a rwlock
Message-ID: <X8feIjdsi6xlGLv6@mtj.duckdns.org>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
 <20201202145837.48040-2-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145837.48040-2-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 02, 2020 at 10:58:36PM +0800, Fox Chen wrote:
> @@ -121,7 +121,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
>  	if (!kn)
>  		return -EINVAL;
>  
> -	mutex_lock(&kernfs_mutex);
> +	write_lock(&kn->iattr_rwlock);
>  	error = setattr_prepare(dentry, iattr);
>  	if (error)
>  		goto out;
> @@ -134,7 +134,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
>  	setattr_copy(inode, iattr);
>  
>  out:
> -	mutex_unlock(&kernfs_mutex);
> +	write_unlock(&kn->iattr_rwlock);
>  	return error;
>  }

This is putting GFP_KERNEL allocation inside a rwlock. Can you please test
with debug options including LOCKDEP and DEBUG_ATOMIC_SLEEP turned on?

Thanks.

-- 
tejun
