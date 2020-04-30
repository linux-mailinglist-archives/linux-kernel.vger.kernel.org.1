Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB31BF9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgD3Nh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 09:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbgD3Nh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:37:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2A02074A;
        Thu, 30 Apr 2020 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588253847;
        bh=1vT+EtxYHzImcO4bWVmeMuLcvY1FrycEoaBP+jfTfEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vk2dletAXWqMkwiP+CWvcLVl7zT25QHkz5sHbxHfdqR2/GFq5qMcWkHW5pe/4SrrL
         VrXn8QNiH9sz1+BEYV6NJXipvdDYaMTnIXZgggkw5/D8nZf/IHdejHG7+MzaOOmvya
         cuqfuK3aeU7XIHt5UC3pGlY5ILYhmY7TsgtIBh/0=
Date:   Thu, 30 Apr 2020 15:37:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [GIT PULL] PHY: For 5.7 -rc
Message-ID: <20200430133718.GA3048289@kroah.com>
References: <20200430130741.2396-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430130741.2396-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 06:37:41PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the PHY pull request for 5.7 -rc below.
> 
> Vinod Koul has kindly agreed to co-maintain PHY subsystem. So we are
> also moving linux-phy to a shared repository. I've included a patch
> to update MAINTAINER file to reflect both these changes in the pull
> request.
> 
> Other than that it includes couple of Qualcomm driver fixes and Kconfig
> depenecy fix in Tegra PHY. For the full list of changes see tag message
> below.
> 
> Consider merging this for the upcoming -rc cycle and let me know if
> I have to make any changes.

Pulled and pushed out, thanks!

greg k-h
