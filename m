Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6495026C9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgIPTQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbgIPRiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:38:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DA620672;
        Wed, 16 Sep 2020 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600277892;
        bh=T8tYVDP8vYL3zSWdyAYaRjsi3VZOcNV3TAge+s8PUOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0QHBVY1koqMLfZailt+SFVSodB2A3eMh85e1FH2OdmGNY4DDdCeUt/Vdn/7AHKTT4
         y/dAXePOAX2ztYNmnhpv6JZa4T90nQZZvdjwiFln4a87ZXR5N7yEkDwAgIMyYYrK1/
         XB4dKtRp6HbbJVr0sfK9LoEB51Pp8MlVL641yskE=
Date:   Wed, 16 Sep 2020 19:38:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v9 3/3] binder: add transaction latency tracer
Message-ID: <20200916173845.GA3072065@kroah.com>
References: <1599543504.16905.65.camel@mtkswgap22>
 <1599574008-5805-1-git-send-email-Frankie.Chang@mediatek.com>
 <1599574008-5805-4-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599574008-5805-4-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:06:48PM +0800, Frankie Chang wrote:
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> +#include <linux/rtc.h>
> +#include <linux/time.h>
> +#endif
> +
>  struct binder_context {
>  	struct binder_node *binder_context_mgr_node;
>  	struct mutex context_mgr_node_lock;
> @@ -524,6 +529,14 @@ struct binder_transaction {
>  	 * during thread teardown
>  	 */
>  	spinlock_t lock;
> +	/**
> +	 * @ts and @real_ts are used to record the time
> +	 * that the binder transaction startup
> +	 */
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> +	struct timespec64 ts;
> +	struct timespec64 real_ts;

Why isn't this ktime_t?  Is timespec64 really something to be using
still?

thanks,

greg k-h
