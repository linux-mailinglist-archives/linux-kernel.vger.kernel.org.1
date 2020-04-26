Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93F1B8D29
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgDZHJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 03:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgDZHJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085AF20700;
        Sun, 26 Apr 2020 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587884962;
        bh=3qtJaBd6XIB2amTUo4PU0+6xaG1Zb4hRCgS0P/J/yns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bm3w4KoyopNUxpSlp7YV5eXlCnDHBgh7ezsQxDgwieXDfGZpS3z36JJKaEJ3JeWA6
         iWJ+VB9+ihsBya/ZntmDND58SM3XIUQjlFaaxvpL2vcQZqJu/+mLARlH1zcBRtHk+Z
         TbQPkqOui78R2dxBydxUgBnreiL1ZBZjaM1j+pHM=
Date:   Sun, 26 Apr 2020 09:09:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200426070919.GB2084805@kroah.com>
References: <20200425080343.GA2048673@kroah.com>
 <20200426024436.7534-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426024436.7534-1-xujialu@vimux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 10:44:36AM +0800, xujialu wrote:
> Add a script to generate a more precise gtags.files from *.cmd files.
> 
> For navigating linux sources, it will be more efficient if gtags/cscope
> just collects source files that needed for compilation. The kernel
> makefiles already create *.cmd files that contain the files we needed,
> then just extracts files list from them and into gtags.files cause it's
> the the default name list file for gtags.
> 
> make defconfig
> make
> scripts/gtags_files_generator.sh
> gtags [-f gtags.files]
> 
> Enjoy with vim+gtags. :)
> 
> Here is a log for comparison with 'make gtags':
> 
> $ time make ARCH=arm cscope
>   GEN     cscope
> 
> real	1m20.600s
> user	1m36.004s
> sys	0m8.192s
> $ wc -l cscope.files
> 31201 cscope.files		#collected too many files we don't care
> 
> $ time ./scripts/gtags_files_generator.sh
> 
> Succeed, 3716 gtags.files listed!
> 
> real	0m1.593s		#collected files only we care
> user	0m1.704s
> sys	0m0.256s
> 				#collected also dts and dtsi
> $ grep dts gtags.files
> arch/arm/boot/dts/xxxxxx-clocks.dtsi
> arch/arm/boot/dts/xxxxxx.dtsi
> arch/arm/boot/dts/xxxxxxxx.dts
> arch/arm/boot/dts/xxxxxxxx.dtsi
> 
> Signed-off-by: xujialu <xujialu@vimux.org>
> ---
>  scripts/gtags_files_generator.sh | 48 ++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100755 scripts/gtags_files_generator.sh

As this is a new version, you need to properly version your patch, as is
documented, please do that.

Also, you seem to be ignoring my previous questions/comments, which
makes me want to just ignore this patch :(

greg k-h
