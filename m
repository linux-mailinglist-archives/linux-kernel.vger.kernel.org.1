Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D452AF478
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKKPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgKKPLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:11:49 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57602053B;
        Wed, 11 Nov 2020 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605107507;
        bh=JVudpR2kXGb3lmYOn0xtZG7ieU5rTHW3yfn2i0UMa98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZBkcuXSY/stQI4ZflxGY21oeFtiRAJhA2NN6Eb+Nm10XBAcCMwIrD4cChGmGQ4np
         7i8N7XU9FrvNxC6kVV4wILK7Xhl8Mw1iVb83QzZttYfrdurdlCgwmWU1sr/nvnoE2F
         T9RERl2Rb5eGpFGiKYm8WmDJop2McL88z/jRNKgc=
Date:   Wed, 11 Nov 2020 16:12:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v14 1/3] binder: move structs from core file to header
 file
Message-ID: <X6v/b+uMi+GwyDAC@kroah.com>
References: <X6uT941IJ3uf/7aE@kroah.com>
 <1605106964-25838-1-git-send-email-Frankie.Chang@mediatek.com>
 <1605106964-25838-2-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605106964-25838-2-git-send-email-Frankie.Chang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:02:42PM +0800, Frankie Chang wrote:
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
> 
> Moving all structs to header file makes module more
> extendable, and makes all these structs to be defined
> in the same file.
> 
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> Acked-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c          |  406 -------------------------------------
>  drivers/android/binder_internal.h |  406 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 406 insertions(+), 406 deletions(-)

This, and patch 2/3 was already accepted, right?

I can't do anything with them again :)

thanks,

greg k-h
