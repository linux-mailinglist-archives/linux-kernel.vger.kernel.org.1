Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0685230CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgG1Oy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 10:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbgG1Oy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:54:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8C3206D8;
        Tue, 28 Jul 2020 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595948067;
        bh=V730kMX6gi4l1JTsK5YD4Pcw9JkPjjfnLeUGTsYVpI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmsLm8bW6XaI3S6LnzgvA/AjnfeP7OWLiE2gEkQ95Klip682iJNjZA21gHEeUb9w1
         Pq/3dS4Q4mDDf77FOANH1L0X4r6Ac8keeQq1gWUdsBrnXwvBhvs7NTzYqpj3Pur2cE
         kRnnGzu42k2xc64R8Z87uMYz/HYsoXw1U92e4HnY=
Date:   Tue, 28 Jul 2020 16:54:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Cc:     hverkuil@xs4all.nl, stern@rowland.harvard.edu, arnd@arndb.de,
        jrdr.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: usbvision: fixed coding style
Message-ID: <20200728145419.GA3537020@kroah.com>
References: <20200728143004.3228-1-dhiraj.sharma0024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728143004.3228-1-dhiraj.sharma0024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:00:04PM +0530, Dhiraj Sharma wrote:
> As per eudyptula challenge task 10 I had to fix coding styles.

That is not needed in a changelog text.

> Thus I
> used checkpatch.pl script and fixed a chunk of warnings and few errors.

Neither is this, please be specific about what you have fixed.  My bot
should kick in soon with more specifics...

thanks,

greg k-h
