Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3792156FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgGFMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 08:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgGFMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:03:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2145420720;
        Mon,  6 Jul 2020 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594037004;
        bh=XwRvS45PxaPTFeBe6KHjdcIn7V0a7dqAR3vsGU9xQmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mw11sBtWYKsfI6BoiOauLa6aF2gC1VakNTSVP6AgE7AtOJsd5jOzjLg7bsiS5972V
         DXQHC7EnRZZXiP/DbZpRcI+gZkxfVntuZr+vUCdgaxE5jhp2rxlBYSmpqydlDVIbZG
         uGzRG3yzQMGLEQLvA0mVkupzKp5rqISt6bdX32N8=
Date:   Mon, 6 Jul 2020 14:03:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] serial: Remove duplicated macro definition of port type
Message-ID: <20200706120324.GA2248224@kroah.com>
References: <1588853015-28392-1-git-send-email-yangtiezhu@loongson.cn>
 <74173351-9d43-07fc-30c4-3c5aab72dcd0@suse.cz>
 <faa2c3bd-c816-7285-b5c7-92b2c379e22f@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa2c3bd-c816-7285-b5c7-92b2c379e22f@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:01:12PM +0800, Tiezhu Yang wrote:
> On 05/11/2020 02:40 PM, Jiri Slaby wrote:
> > On 07. 05. 20, 14:03, Tiezhu Yang wrote:
> > > There exists the same macro definition of port type from 0 to 13
> > > in include/uapi/linux/serial.h, remove these duplicated code in
> > > include/uapi/linux/serial_core.h which includes the former header.
> > > 
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Acked-by: Jiri Slaby <jslaby@suse.cz>
> 
> Hi,
> 
> Could you please apply this patch?

Odd, I can't find this anywhere in my archives, sorry about that, will
grab it from lore.kernel.org.

greg k-h

