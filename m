Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269A82A62D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgKDLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDLCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:02:04 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AE720867;
        Wed,  4 Nov 2020 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604487723;
        bh=W+3QSsbuXdJVSCV51q6c6auVI0NKTOuW/rHh0EGgt0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nurarh21VMIMoEwhAIZMBHGPYSK7vnzTUaEbu4qlm6ac0+hwaMe2szcQdyW7SLwtz
         7gXOC7gb3HAsGHN6RmrbRvoMtUDT0DfiOgRl2iYTBSUHqwxowv7t7dt7MO63/Nzt6x
         CwKsFzkmJdQM04F4KthCnNwobMzSVyjaZ5Yf50t0=
Date:   Wed, 4 Nov 2020 12:02:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 0/2] drivers/tty: delete break after return or goto
Message-ID: <20201104110253.GB1688848@kroah.com>
References: <20201104105331.16654-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104105331.16654-1-bernard@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:53:29AM -0800, Bernard Zhao wrote:
> This patch sereies optimise code like:
> {
> case XXX:
> 	return XXX;
> 	break; //The break is meanless, so just delete it.
> case YYY:
> 	goto YYY;
> 	break; //The break is meanless, so just delete it.
> ......
> }
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> 
> ---
> Bernard Zhao (2):
>   drivers/tty/nozomi.c: delete no use break after goto
>   drivers/tty/serial/imx.c: delete no use break after return

That is not the subject of the patches you sent out, what broke?

