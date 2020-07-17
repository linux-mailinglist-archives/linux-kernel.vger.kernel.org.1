Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E3223480
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 08:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGQG2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 02:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgGQG2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:28:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD6E21744;
        Fri, 17 Jul 2020 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594967329;
        bh=/zDpcXferlVtWyvGBk0RCp/EESwPvxFdFmaWT7IB5mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGn1qhG01OHqEEHQJUEmSuu/sVsHpdMBOUDRld0QlkpUsFb/3GgPZE0v1HXL4MOss
         SQafuUuYSS91Vd2p+yKKuMTKGVA0cE4/Jd5hrN52gyaFFA9lmL9DHqkXRZOmqzOh9l
         BXjcHxfLYZELw3WeZyuKI6/fdZ+kFeV4tMPKAcBI=
Date:   Fri, 17 Jul 2020 08:28:41 +0200
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
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
Message-ID: <20200717062841.GA3238569@kroah.com>
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 07:36:27PM -0300, Daniel Gutson wrote:
> +What:		/sys/kernel/firmware-security/bioswe

Ick, I stopped reading right here.

No, this is not where this belongs.

We already have /sys/firmware/, right?  And firmware-specific
subdirectories below that.

We also have /sys/devices/system/ and I think that would be a much
better place for this, as it is easier to work with a real 'struct
device' than a "raw" kobject any day.  Bonus is you get full support of
userspace libraries when you do that, unlike when dealing with kobjects.

Also, this really is a _SPECIFIC_ type of firmware that supports these
features, right?  Why not call that out too?  This is not generic by any
means.

thanks,

greg k-h
