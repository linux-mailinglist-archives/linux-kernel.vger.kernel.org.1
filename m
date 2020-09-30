Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487F027EACA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgI3OTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgI3OTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:19:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C0420709;
        Wed, 30 Sep 2020 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601475591;
        bh=KjqhkMSmQAqGdUf+wARySt2Y47P2sRmybBHUt8C1SO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRrQFA9kz/xosasjCQE397D5Hia5cxV80cYVfpQobLN8R3vDQov5nLcE2Wtrwv2SN
         GHZj9f2HwdgGTsaodEXxIJvwKLpaYqlZkSBsf9QFZYMPFU67uu4O5L3cJDqr5flcfH
         4hV9YUN83JrrE7eAnkfy0w2QP1U0C2tEfIVtG+es=
Date:   Wed, 30 Sep 2020 16:19:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 0/2] Platform integrity information in sysfs (version 9)
Message-ID: <20200930141954.GC1654628@kroah.com>
References: <20200930135101.5424-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930135101.5424-1-daniel.gutson@eclypsium.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:51:01AM -0300, Daniel Gutson wrote:
> This patch serie adds a misc kernel module and extends the intel-spi drivers
> to publish platform integrity data in the sys-fs.
> Please check the comments in the following patches of this serie for further
> details.
> 
> Daniel Gutson (2):
>   Platform integrity information in sysfs (version 9)
>   This patch exports the BIOS Write Enable (bioswe), BIOS Lock Enable
>     (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of the
>     BIOS Control register using the platform-integrity misc kernel
>     module. The idea is to keep adding more flags, not only from the BC
>     but also from other registers in following versions.

You sent 2 patches with the identical subject line, yet they do
different things, you migth want to fix that...

thanks,

greg k-h
