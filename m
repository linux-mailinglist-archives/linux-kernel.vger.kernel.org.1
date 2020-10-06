Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192A8284C68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJFNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFNTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:19:22 -0400
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AEEE2078E;
        Tue,  6 Oct 2020 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601990361;
        bh=rhzEg93RmiL/9w7FXsjEbHmJfiXwGx7Q4TpUevh6Ol4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j12QtR/d3cElZV0sIOkrI6AEhL4P73NtQY4j8J1Cyxv62Sk4Wkjp60MdI620gNiUU
         5YHtzFvmnqRxhIz1iwvj2qxk1HtvTqZclFmcfIvpTCS9CKcrinv+FJmYHONs1T05G4
         Os4IZ2/yw9vHl4SMa/CXVylTfDBRBVL0OidcPijA=
Date:   Tue, 6 Oct 2020 15:19:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>
Subject: Re: [PATCH 2/2] w1: w1_therm: Add support for GXCAS GX20MH01
 device.
Message-ID: <20201006151915.77d044a4@coco.lan>
In-Reply-To: <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru>
References: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
        <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri,  4 Sep 2020 19:00:04 +0300
Ivan Zaentsev <ivan.zaentsev@wirenboard.ru> escreveu:

> diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
> index f1148181f53e..00376501a5ef 100644
> --- a/Documentation/w1/slaves/w1_therm.rst
> +++ b/Documentation/w1/slaves/w1_therm.rst

>  
> @@ -130,4 +131,12 @@ conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
>  power), the driver returns a conversion error. Bit mask ``2`` enables poll for
>  conversion completion (normal power only) by generating read cycles on the bus
>  after conversion starts. In parasite power mode this feature is not available.
> -Feature bit masks may be combined (OR).
> +Feature bit masks may be combined (OR). See accompanying sysfs documentation:
> +:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
> +

As warned by Sphinx, this cross-reference is broken:

	.../Documentation/w1/slaves/w1_therm.rst:125: WARNING: undefined label: w1_therm (if the link has no caption the label must precede a section header)

Not sure what you wanted to point here.


Thanks,
Mauro
