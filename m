Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0262D3441
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgLHUe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgLHUe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:34:26 -0500
Date:   Tue, 8 Dec 2020 20:52:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607457076;
        bh=Ca/yUEh1danqrq5/dxXGE8VD2nSkqfSBiC/STEg0i7k=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJGkaLwlOQrG1rbFf5ZBKSzwElM313eOK8PFuaoAGOpk9IhFjGawznPFQmYACCmWC
         vfyOAcyRcS6v7Z0VNkEBYC6CvDcQRJSusiUt2099InMpLdjPbVo9qihnSH8Cw7wkbB
         7UmL9ZTAjMnYc2+Hdz5MP8zrZrmzsmrBSc1+/Lhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: core: Fix list corruption after device_del()
Message-ID: <X8/ZghuyCJfguuIE@kroah.com>
References: <20201208190326.27531-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208190326.27531-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:03:26PM +0100, Takashi Iwai wrote:
> The device_links_purge() function (called from device_del()) tries to
> remove the links.needs_suppliers list entry, but it's using
> list_del(), hence it doesn't initialize after the removal.  This is OK
> for normal cases where device_del() is called via device_destroy().
> However, it's not guaranteed that the device object will be really
> deleted soon after device_del().  In a minor case like HD-audio codec
> reconfiguration that re-initializes the device after device_del(), it
> may lead to a crash by the corrupted list entry.
> 
> As a simple fix, replace list_del() with list_del_init() in order to
> make the list intact after the device_del() call.
> 
> Fixes: e2ae9bcc4aaa ("driver core: Add support for linking devices during device addition")
> Cc: <stable@vger.kernel.org>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209207
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d661ada1518f..e8cb66093f21 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1386,7 +1386,7 @@ static void device_links_purge(struct device *dev)
>  		return;
>  
>  	mutex_lock(&wfs_lock);
> -	list_del(&dev->links.needs_suppliers);
> +	list_del_init(&dev->links.needs_suppliers);
>  	mutex_unlock(&wfs_lock);

Can this wait until 5.11-rc1 and then get backported, as it has been
around for a while, or are you hitting this on 5.10-rc7 now and need
this for 5.10-final?

thanks,

greg k-h
