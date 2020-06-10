Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99B51F52D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 13:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgFJLHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 07:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgFJLHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:07:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BEF206F4;
        Wed, 10 Jun 2020 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591787260;
        bh=d0DVR7KdMTdh+SG8GrUm0y8LB/oJPU5+q3D/EbPQfTQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=xpSREjQWIn1+V0otiAnfK9WLGVtiT5N00yf5lgjC8qJqbc3jS8pJyrH6M0hJ2xhzA
         bGI4LJdfz+2f0PKc/BHiUpu6rFcadDFSlOqFpOws2dh/t4pVOEm+t5Df3/eW0nI9tu
         P5cmh3kSri5+x168Hobl/2+laug8+9ezd00BazoQ=
Date:   Wed, 10 Jun 2020 13:07:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: License discripency in files,the words
Message-ID: <20200610110735.GA1893040@kroah.com>
References: <20200610104145.GA23025@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610104145.GA23025@Gentoo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:11:45PM +0530, Bhaskar Chowdhury wrote:
> Greg/Linus/Andrew,
> 
> I am not sure how trivial it is , but if it is , please ignore it.
> 
> I got this on Linus's tree :
> 
> ~/git-linux/linux [master|✔]
> 15:52 $ git grep "GPL-2.0-only" . | wc -l
> 14734
> 
> And ..
> 
> ~/git-linux/linux [master|✔]
> 15:55 $ git grep "GPL-2.0" . | wc -l
> 49530
> 
> 
> Well, aren't we out of uniformity??? Or is there any specific trace on
> character? I don't know either.

Please read LICENSES/preferred/GPL-2.0 for the list of valid SPDX lines
for that specific license.

In short, both are fine, don't worry about it :)

thanks,

greg k-h
