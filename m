Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADF25D6A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgIDKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIDKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:42:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E072084D;
        Fri,  4 Sep 2020 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599216136;
        bh=Xu0I2POKS+CaOprhzvVE8u5rgoy0VjamFgilzIRsWFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iK9F7Cc3oDD6ltaGLz24BF11wzYsN9OUzaGerACJp7iypbLmyaNwmel2i5hzvru0A
         AKqhHM6yrWwevs4BFG9KJnYBNmIa3E1VKztfRaCL3kV3DxEoKr5llH+NrpyigJLjs9
         mrU7C0vLa87BfrCQh9N3VhkCQdizU0xzjQn4mjNU=
Date:   Fri, 4 Sep 2020 12:42:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: PHY fixes for v5.9
Message-ID: <20200904104229.GB2718648@kroah.com>
References: <20200904101750.GA2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904101750.GA2639@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:47:50PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive the fixes for PHY subsystem. Cooupld of fixes on
> QCOM driver and one on TI driver
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.9

Pulled and pushed out, thanks.

greg k-h
