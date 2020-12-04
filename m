Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731362CF14C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgLDPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgLDPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:53:10 -0500
Date:   Fri, 4 Dec 2020 16:53:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607097144;
        bh=joesd0VC32GUl4vlLoi/gJEGTBVxw5QiUzTjAyk4/ao=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAavfzz+6xysPYv5v+2uuYQpFYyRk7ODsDiDN5Z/FlAcS1osreISClYZWXo2WlcGN
         qi9wJxK3O8E8w82eVO9K6+ySL5LbPNK/RrRUWiZ9DAko3rSI8L8+fXhVAJiAASFcHI
         5DvW/UzLRYK5hEK9PqGzEYk919q/Ksra1NCt1K+8=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Yan.Gao" <gao.yanB@h3c.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY: Fix whitespace inconsistencies in vt_io_ioctl
Message-ID: <X8pbhIv8grF2hSd6@kroah.com>
References: <20201204015201.9122-1-gao.yanB@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204015201.9122-1-gao.yanB@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:52:01AM +0800, Yan.Gao wrote:
> Replaces spaces with tabs for indentation.
> 
> Signed-off-by: Yan.Gao <gao.yanB@h3c.com>
> ---
>  drivers/tty/vt/vt_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 5f61b25a9..3813c40f1 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -596,12 +596,12 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
>                 return con_font_op(vc, &op);
> 
>         case PIO_CMAP:
> -                if (!perm)
> +               if (!perm)
>                         return -EPERM;
>                 return con_set_cmap(up);
> 
>         case GIO_CMAP:
> -                return con_get_cmap(up);
> +               return con_get_cmap(up);
> 
>         case PIO_FONTX:
>                 if (!perm)
> --
> 2.17.1
> 
> -------------------------------------------------------------------------------------------------------------------------------------
> ??????????????????????????????????????????????????????????????????
> ????????????????????????????????????????????????????????????????????????????????
> ????????????????????????????????????????????????????????????????????????????????
> ??????
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

Your email is now deleted from my system, this footer is not compatible
with kernel patch submission, sorry.

greg k-h
