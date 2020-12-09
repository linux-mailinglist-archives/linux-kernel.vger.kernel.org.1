Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E92D41A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgLIMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731046AbgLIMBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:01:46 -0500
Date:   Wed, 9 Dec 2020 13:02:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607515266;
        bh=SxUcCOk6EABV426Vv5fQLgQpTaXc7Q0vhKOIeg7/cVo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfoslDmSETsL8y+eBGotK+t74xmX2D24QCVPYznbkYgpPxigNCNOCmmJT99TFtnca
         d/etSQ5pXonj6iqBTNuW8/7KeTrBKMlGvO5DbJB7ILvjO4YICzj8FsEro+A5z3JqDQ
         hJgrqwOjWLaCQNBPihkh59k2KfeXL+2n9uIcnImM=
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Info <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] Staging: silabs si4455 serial driver
Message-ID: <X9C8zlCMvTev7ELE@kroah.com>
References: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <!&!AAAAAAAAAAAuAAAAAAAAAM7AkQxKEJRHh2BgMNSTrQkBAExvbAW64DNBoXXP8CRioZMAAAAzfOEAABAAAAAJUqiRO33GQqGIHffCVyG/AQAAAAA=@ministro.hu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 12:09:58PM +0100, Info wrote:
> This is a serial port driver for
> Silicon Labs Si4455 Sub-GHz transciver.
> 
> Signed-off-by: József Horváth <info@ministro.hu>

Note, your From: line does not match this line, so I can't take this.

But:

> ---
>  .../bindings/staging/serial/silabs,si4455.txt |   39 +

staging drivers need to be self-contained, so this should be here.  It
needs to be reviewed by the DT maintainers when moving out of staging.

> index 000000000000..aee5c7613b31
> --- /dev/null
> +++ b/drivers/staging/si4455/TODO
> @@ -0,0 +1,3 @@
> +TODO:
> +        - add variable packet length support
> +        - add firmware patching support in case of Si4455-C2A

Why are these a requirement to get it out of staging?  Why go into
staging at all?  Why not go into the 'real' part of the kernel directly?
What is keeping that from happening today?

These look like new features that you can add later, and shouldn't be a
requirement for acceptance into the normal part of the kernel for this
driver.  Why have you not tried doing that first?

thanks,

greg k-h
