Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7F1B8485
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDYIDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 04:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYIDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:03:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680D5206B6;
        Sat, 25 Apr 2020 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587801826;
        bh=Q9FVcEXiVrvBg/q16CBnBZeiK5yQybG9lZ1rY/Zw65Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvPdP4x2ZA2V8BXJ/fIU9WpT9mGCDGvJc0wKhivptX8gdpLI1Vtl3ONVKuYtkNVNG
         63ruBPEXkeF63T99UiZtCk+iOgNooqauOCnOsLYJhdYWqb6cXA1eM6jjsbiUtva35c
         6zwW/5aRaMMUlBtRR8kCFcZuvJcjGGhDkaN/SlVU=
Date:   Sat, 25 Apr 2020 10:03:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200425080343.GA2048673@kroah.com>
References: <20200423143642.11788-2-xujialu@vimux.org>
 <20200425073105.27796-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425073105.27796-1-xujialu@vimux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 03:31:06PM +0800, xujialu wrote:
> Add a script to generate a gtags.files file.
> 
> For navigating linux sources, it will be more efficient if gtags/cscope just
> collects source files that needed by compilation. The kernel makefiles already
> create *.cmd files that contain the files we needed, then just extracts files
> list from them and into gtags.files cause it's the default name list file for
> gtags.
> 
> make defconfig
> make
> scripts/gtags_files_generator.sh
> gtags [-f gtags.files]
> 
> Enjoy with vim+gtags. :)

What's wrong with just 'make gtags' that we currently have in the kernel
tree?  Shouldn't that be sufficient, and if not, then you need to
explain why it isn't in your changelog.

thanks,

greg k-h
