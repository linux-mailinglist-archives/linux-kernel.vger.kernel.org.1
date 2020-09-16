Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7D26C480
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIPPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgIPPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:30:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CF9223E0;
        Wed, 16 Sep 2020 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600270165;
        bh=RB9ft3ey0/nl4nE0DnYdgU8sqKfHQq8asR+gs8IID/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaM46s0HRSvFNiyCY2F3y9EamTmIzQm6/SIxtjUKZXe7dvMUh9haF+027s6z9G0mP
         vP/kizxamSHBXmDps9zNTLCDTVrKLnyx/pnFpTNsjrYHCNpUn07EXZidSQQVKsmJgC
         E1GnpfLRrWT0Xl+o9MWbmX1yK5zeJk/3i0hpyNlk=
Date:   Wed, 16 Sep 2020 17:29:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v9] binder: transaction latency tracking for user build
Message-ID: <20200916152959.GA3020510@kroah.com>
References: <1599543504.16905.65.camel@mtkswgap22>
 <1599574008-5805-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599574008-5805-1-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:06:45PM +0800, Frankie Chang wrote:
> Change from v9:
>   - rename timestamp to ts in binder_internal.h for conciseness.
>   - change 'struct timeval' to 'struct timespec64' in binder_internal.h.

These just blew up in the 0-day testing, again, so I'm dropping them
from my tree.

Can you please fix them up and resend when you have them properly
building?

thanks,

greg k-h
