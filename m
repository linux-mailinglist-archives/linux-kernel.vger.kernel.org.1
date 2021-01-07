Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D282ECC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbhAGJQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGJQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:16:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B09AF2312E;
        Thu,  7 Jan 2021 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610010978;
        bh=OEOK2cLcu8Rs1Ti+sJvJCut6L+tJsNZ58wiR33kb3B8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZi7+ScM3q5aj1jeNkMlp04Pg7wVx4ShJ0zoNzuUe1M+3AWWO+LHvjKnfulIwiklW
         Gl59u+rb8kYcJwepxbaY9OlVmBjdfFcaYqPwxuv68JXXdPhTR7eAy9l5JwSWMaFVBF
         pfTPuEZ6LU6QJp9JY6u3te9xiwcqOKyTVlqS6wiw=
Date:   Thu, 7 Jan 2021 10:17:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Send uevent for num_altmodes update
Message-ID: <X/bRstJuBYaLz4PK@kroah.com>
References: <20210107034904.4112029-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107034904.4112029-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 07:49:04PM -0800, Prashant Malani wrote:
> Generate a change uevent when the "number_of_alternate_modes" sysfs file
> for partners and plugs is updated by a port driver.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/usb/typec/class.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index ebfd3113a9a8..8f77669f9cf4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -766,6 +766,7 @@ int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmod
>  		return ret;
>  
>  	sysfs_notify(&partner->dev.kobj, NULL, "number_of_alternate_modes");
> +	kobject_uevent(&partner->dev.kobj, KOBJ_CHANGE);

Shouldn't the sysfs_notify() handle the "something has changed" logic
good enough for userspace, as obviously someone is polling on the thing
(otherwise we wouldn't be calling sysfs_notify...)

The kobject itself hasn't "changed", but rather an individual attribute
has changed.  We don't want to create uevents for every individual sysfs
attribute changing values, do we?

What is preventing a normal "monitor the sysfs file" logic from working
here for anyone who wants to know that the alternate modes have changed?

thanks,

greg k-h
