Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25A62A7B12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgKEJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEJzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:55:07 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C682151B;
        Thu,  5 Nov 2020 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604570105;
        bh=KGIP1wr1jvU77ylGCI/rcGT14bE4bc1Zp9eOPTIJAtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPSzj4nXW/qRfDl3lskAsYdXJUEgRGo9BQABrS/fXN1kBjtarewaITzkhFhU4RIqa
         eQOaMIP1w4rg/iPuvx/o1wWmRr+l79dQhfkyVQtZOvG3gASITDJjZQK/RjjcKxDltT
         HHnbYn/DLE19V+Sz1omD8IN96EhVm+Q/uUn/8yms=
Date:   Thu, 5 Nov 2020 10:55:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Message-ID: <20201105095554.GA3451966@kroah.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <69E3975E-A4D0-4472-80F0-9FAB2E0024FA@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69E3975E-A4D0-4472-80F0-9FAB2E0024FA@microgate.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:39:36AM -0800, Paul Fulghum wrote:
> 
> 
> > On Nov 5, 2020, at 1:10 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
> > 
> > OK, let the loop alone. I would bet a half a pig that noone is able to test this driver. But one has to write this for someone to raise and admit they are still using it. In fact, there are _4_ google replies to "Microgate Corporation" "SyncLink Multiport Adapter" "lspci".
> 
> 
> 
> The hardware used with synclink.c and synclinkmp.c has not been manufactured for 15 years and was low volume. The chances of either driver still being in use is very low. Not even Microgate (me) has the ability to test either anymore (no hardware). I don’t know the policy about driver removal, but I think both could be removed without upsetting anyone.
> 
> synclink_gt.c is still in production and the driver still actively used.
> 
> If there are no objections to removing the the old drivers (synclink.c/synclink_mp.c) I could make a patch to do so tomorrow (it is 1:30am here now). Nothing eliminates niggling warnings like removing dead code.

Great, please submit a patch to remove these, I will always take patches
to delete lines :)

thanks,

greg k-h
