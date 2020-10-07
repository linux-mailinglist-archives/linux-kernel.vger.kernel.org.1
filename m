Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75404285922
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgJGHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:13:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:13:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id az3so591611pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m4zhtUrnJ3gfXK56jpuIcL6gq7j0ZVq/kMpKZzKqnQQ=;
        b=OnbJ+tBplPBjO3xCR4JaWv1/6JAmfSppZnb6ixkREqkZGKFbqku3E0UTsKgyWuAl0q
         B9JrkFotcBWaWOwK3k2PS5zKanw5bE23gMaqyCcBCXft0iArsD++rRjgdd+hyCTueFL/
         QCLwkxuFymJdVoFfRVVDkJNDZxIsEMpUSeodM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4zhtUrnJ3gfXK56jpuIcL6gq7j0ZVq/kMpKZzKqnQQ=;
        b=qbbFfrsTQFUzIfPC0ou6dlQ+K6+SgOqp8ws62yV62qrwgistUBg3dafCWq1XybARdF
         kBQUQU6H8Oy/XMZv5aGeOlTdCjyrnp5BCxyrOz96sQdTCu0DJ32mn4ewKl3ZbHmCy1sx
         uNR5WGcd5zfwSlh0GCYUdXA3t+zpS8lmAalKo0j8bLtxxYzCsNiRchVYQOcZdbDHUiAF
         3tWjric8K4FxPPVV41uLrzoPnX9n+O6zgitfanvpbxJrvGxX7CwQ6YOU4r29xcm3Sbsf
         qmUfK/Fq8lQqDzjZynsCnP48RDdx+/ovDYWISock7DvVnAVe3E4J23wqaqknjN1aoK2T
         UZQg==
X-Gm-Message-State: AOAM530dRj1dKqOLXihwk7IPH5e8FXFO6lcv0TILSWyJI4gwphUhD+lj
        UC7qA3LuOkkcQFSzmrLmqdwoLari9I0K0Xnl
X-Google-Smtp-Source: ABdhPJycTHJaOgJip1kgxt64lwtbK4L8r93LBcZXx9bETvRUnfW96AFhQRxttOigWGaSRzOt9VYtlA==
X-Received: by 2002:a17:90a:109:: with SMTP id b9mr1764790pjb.35.1602054809548;
        Wed, 07 Oct 2020 00:13:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e19sm1717246pfl.135.2020.10.07.00.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:13:28 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:13:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     WeiXiong Liao <gmpy.liaowx@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <202010070007.8FF59EC42@keescook>
References: <20201006155220.GA11668@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006155220.GA11668@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 05:52:20PM +0200, Christoph Hellwig wrote:
> Hi WeiXiong, hi Kees,
> 
> what is the use case for the code added in commit 17639f67c1d6 
> ("pstore/blk: Introduce backend for block devices").
> 
> This still doesn't have a user, and the API looks really odd to me.

pstore is a beast. :) The API is there so that a blk device can declare
its direct support of pstore (specifically, to provide a panic_write
handler).

The MTD device does this, but yes, that's a good point, there isn't a
blk device user of that entry point yet.

> By our normal kernel rules we should not add new exports without
> users and this should probably be reverted for the 5.9 release.

I don't want to revert the entire patch (I'm still using
__register_pstore_blk by way of pstore/blk's "best_effort" option), but
I wouldn't object to something like this:


diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index fcd5563dde06..e0fe21e2cf34 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -419,27 +419,6 @@ static int __register_pstore_blk(struct pstore_blk_info *info)
 	return ret;
 }
 
-/**
- * register_pstore_blk() - register block device to pstore/blk
- *
- * @info: details on the desired block device interface
- *
- * Return:
- * * 0		- OK
- * * Others	- something error.
- */
-int register_pstore_blk(struct pstore_blk_info *info)
-{
-	int ret;
-
-	mutex_lock(&pstore_blk_lock);
-	ret = __register_pstore_blk(info);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_pstore_blk);
-
 static void __unregister_pstore_blk(unsigned int major)
 {
 	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
@@ -454,19 +433,6 @@ static void __unregister_pstore_blk(unsigned int major)
 	}
 }
 
-/**
- * unregister_pstore_blk() - unregister block device from pstore/blk
- *
- * @major: the major device number of device
- */
-void unregister_pstore_blk(unsigned int major)
-{
-	mutex_lock(&pstore_blk_lock);
-	__unregister_pstore_blk(major);
-	mutex_unlock(&pstore_blk_lock);
-}
-EXPORT_SYMBOL_GPL(unregister_pstore_blk);
-
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
 {
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 61e914522b01..2bf07d20ce43 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -46,9 +46,6 @@ struct pstore_blk_info {
 	sector_t start_sect;
 };
 
-int  register_pstore_blk(struct pstore_blk_info *info);
-void unregister_pstore_blk(unsigned int major);
-
 /**
  * struct pstore_device_info - back-end pstore/blk driver structure.
  *

-- 
Kees Cook
