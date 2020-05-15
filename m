Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF01D4E00
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEOMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 08:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:46:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6561920759;
        Fri, 15 May 2020 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589546783;
        bh=9jx5m24WW0URtbkMH+R+pcNb9OGENvkqB1NS3ledxkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nl6iQHiSYFoDPKQZkIM+5cHf1KC5BPJlhv7X9JFpMTws4kZE6whbUD7CD+6jAa9ND
         0n7mfJl5e6EpSyW0WRHq95RDDK8zL0XEMvJTgXJVqAeRGF7M9mCTmxM+zyry+LTcCQ
         J63Ov8ptGQoSVxbuw+oft+43Qs6xH6AR75CIxym8=
Date:   Fri, 15 May 2020 14:46:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     robh@kernel.org, jslaby@suse.com, long.cheng@mediatek.com,
        changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serdev: ttyport: add devt for tty port
Message-ID: <20200515124621.GB1888557@kroah.com>
References: <20200506072314.112409-1-tientzu@chromium.org>
 <20200506072314.112409-2-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506072314.112409-2-tientzu@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 03:23:12PM +0800, Claire Chang wrote:
> serial_match_port() uses devt to match devices. However, when serdev
> registers a tty port, devt has never been set. This makes
> device_find_child() always return NULL.
> 
> Assign devt in serdev_tty_port_register() to fix this.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 2 ++
>  1 file changed, 2 insertions(+)

So is existing code broken because of this?  Or does no one ever call
device_find_child() on this?  Who needs/uses this?

thanks,

greg k-h
