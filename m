Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17C11B5E13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgDWOmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 10:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgDWOmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:42:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4582F20728;
        Thu, 23 Apr 2020 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587652939;
        bh=CYZLO9WrZrZcw2q8PvdB8YO8JajOtg0740bTwyOhLiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eib8PQrX5NECv3nCRjI8ICs14Oopj+g17btTalxraE8Cd7A64Hk7thYdV3N0oMkMc
         IgSHGVc/N80EZyuIBoAtEDWIZQxfyVbwgy0DJPvP9YbTDjxWDRLv30wPEocBVzUQo1
         ghkgkFeRE1NiKYBEmQPiLxGMy/4YYq1FrEFNwDRw=
Date:   Thu, 23 Apr 2020 16:42:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200423144217.GA7622@kroah.com>
References: <20200423103801.GA3730892@kroah.com>
 <20200423143642.11788-1-xujialu@vimux.org>
 <20200423143642.11788-2-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423143642.11788-2-xujialu@vimux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:36:42PM +0800, xujialu wrote:
> A script for generating gtags.files after compilation.

That's a very short description, why isn't that also in the tool itself,
how is anyone going to know what it is, or how to use it?

And this says what it is, but not _why_ it would be useful at all,
please document that here.

thanks,

greg k-h
