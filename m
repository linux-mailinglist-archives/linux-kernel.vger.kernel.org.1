Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82862486BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHROJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:09:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9567C20786;
        Tue, 18 Aug 2020 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759787;
        bh=HgHc4ESZwhbbEAe1yXtGZBgMlETAW1fB2DVt/PGNgAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl5bZUyFmc5LcO7VsYG+6oHb1jwgmNvUKSUS+Re5X9wyvNupQoisEwg8uCoN7T0fr
         AF8HGohr0LWYljWy+CdrGRYPBQtq7zBpk2M5iv4UV6UczHP208ZnLKWO1uuhoAHoCa
         qnfifpuWkbsm0GcmelwQIYP6O4ZxJw/zAf2w4gss=
Date:   Tue, 18 Aug 2020 16:10:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 2/4] staging: android: Add error handling to
 ion_page_pool_shrink
Message-ID: <20200818141009.GA562377@kroah.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
 <73d1b8b904ae867f59e7ada14c3fb90e27f12bbb.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d1b8b904ae867f59e7ada14c3fb90e27f12bbb.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:24:22PM +0300, Tomer Samara wrote:
> Add error check to ion_page_pool_shrink after calling
> ion_page_pool_remove, due to converting BUG_ON to WARN_ON.
> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>

So this fixes a previous patch?  That's not good, please merge them
together so you do not cause a bug and then fix it up later on.

thanks,

greg k-h
