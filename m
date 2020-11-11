Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941B92AEA35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKKHdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgKKHdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:33:33 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA40F2076E;
        Wed, 11 Nov 2020 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605080013;
        bh=JRFSkM0LzEGX/i7iJ8cU+ThPtvyf2vBq6oxvlPal01M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xuYCRovsDrVjOXqZgYYxNIcWrCG8nvnIqrq2Ml61do7I8sYNUy8xyVPmVksdMEOlj
         pS1c9Bu93MpiBECeJ8N6W994ktbGsmfyTshagvJG2pkneGQTAxdyOEwYI7I3uOff/m
         jkz8ePdbG9XPqv0EyPm4X/Z2RdHwthC1dr9rtahY=
Date:   Wed, 11 Nov 2020 08:34:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v13] binder: add transaction latency tracer
Message-ID: <X6uUCvNVFuVFXF5X@kroah.com>
References: <X6quBb28IVvyRhox@kroah.com>
 <1605063764-12930-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605063764-12930-1-git-send-email-Frankie.Chang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:02:41AM +0800, Frankie Chang wrote:
> 
> Frankie.Chang (3):
>   binder: move structs from core file to header file
>   binder: add trace at free transaction.
>   binder: add transaction latency tracer
> 
>  drivers/android/Kconfig                 |   8 +
>  drivers/android/Makefile                |   1 +
>  drivers/android/binder.c                | 430 ++----------------------
>  drivers/android/binder_internal.h       | 419 +++++++++++++++++++++++
>  drivers/android/binder_latency_tracer.c | 107 ++++++
>  drivers/android/binder_trace.h          |  49 +++
>  6 files changed, 608 insertions(+), 406 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c

Your cover letter here lost all of the information that used to be in
other versions of the series :(
