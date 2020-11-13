Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF012B21CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:16:46 -0500
Received: from netrider.rowland.org ([192.131.102.5]:57705 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726028AbgKMRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:16:45 -0500
Received: (qmail 327091 invoked by uid 1000); 13 Nov 2020 12:16:58 -0500
Date:   Fri, 13 Nov 2020 12:16:58 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Boero <boeroboy@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <20201113171658.GF322940@rowland.harvard.edu>
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com>
 <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com>
 <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
 <20201112192524.GB287229@rowland.harvard.edu>
 <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
 <20201113163449.GB322940@rowland.harvard.edu>
 <CAO5W59iqXGeAQTP7hzzRmbqwZUcK=vwuJ7pFzzNzZ9o11_k2tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59iqXGeAQTP7hzzRmbqwZUcK=vwuJ7pFzzNzZ9o11_k2tw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:45:52PM +0000, John Boero wrote:
> Sorry I wanted to include a pastebin or link but was trying to follow maillist
> guidelines and not include links or exceed wrap guidelines.  Full contents:
> https://paste.centos.org/view/3746bc40
> 
> Yes I understand the return dodges the config dereference.
> 
> Original line usb.c:281 is the original error:
> 
> 280| for (i = 0; i < config->desc.bNumInterfaces; i++)
> 281|  if (config->interface[i]->altsetting[0]
> 282|    .desc.bInterfaceNumber == ifnum)
> 283|  return config->interface[i];

Okay.  Without having looked at the code, I would guess that uvcvideo's 
uvc_ioctl_streamon() handler -- or some routine beneath it -- either 
doesn't lock the USB interface while starting I/O, or doesn't check 
(while holding the lock) to see whether the driver has been unbound.

This sort of error (config->interface[i] == NULL) is what you expect to 
see if a driver tries to carry out I/O to a device that has been 
unplugged and that it has been unbound from.

Alan Stern
