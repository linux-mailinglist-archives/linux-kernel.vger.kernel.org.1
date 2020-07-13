Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBA218C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgGHQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730315AbgGHQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:00:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C8020672;
        Wed,  8 Jul 2020 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594224033;
        bh=ED6gPmS2pxwsH8wu3RDoLEtf9jeO4RJN8yvW12G4s7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayUz3Xurv51Ig4FvbJPtgj6zLljIM0rmKlqn1CAhfGAXvJ4EoltLa30RuMKOEPJwC
         ZwoVHozMljQBsQx1THxMs0R4aP9K9cSNQN9Buo/Yo8wzcHScEF/pIxRqGIuOHrSROq
         9KF1wIdAJSh32Gax4IH+gDQoungeT2s+H3cJdIFM=
Date:   Wed, 8 Jul 2020 18:00:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PHY: fixes for 5.8
Message-ID: <20200708160029.GB720524@kroah.com>
References: <20200707042134.GA676979@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707042134.GA676979@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:51:34AM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive fixes for phy for 5.8. Kishon is bit busy and has
> asked me to send the PR for phy this time around.
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.8

Pulled and pushed out, thanks.

greg k-h
