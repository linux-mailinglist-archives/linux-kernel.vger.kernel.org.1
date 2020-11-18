Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342202B7D10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKRLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRLxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:53:50 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B38B207D3;
        Wed, 18 Nov 2020 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605700430;
        bh=OvcOpWYH/daMpxGjh0Ud84d8UhmjV3x6Q1H1hRHM0uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFB5hQLT2jGphVhPHsQO8w9pVhZolvHVXItR5ggY3CIe7Z472PBhl8s+QqMnMYeSX
         oLMKUpOwNZf+ZJD4P+Ws/kYPLrZbzVazwxV7Wu6M8FREA7kcPZ9qUPqxB3nFBu+Gyz
         8njUB74Qgfi5PchIdGY+fB1Sc8MDCIjU3/igjSB4=
Date:   Wed, 18 Nov 2020 12:54:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com
Subject: Re: [PATCH v2 0/8] Thunderbolt3/USB4 cable rounded and active cable
 plug link training support
Message-ID: <X7ULfA//gU3vsIqd@kroah.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:24:55PM -0800, Utkarsh Patel wrote:
> This patch series adds the support for Thunderbolt3/USB4 rounded and
> non-rounded frequencies cables and fixes the active cable plug link
> training support.
> 
> Changes in v2:
> - Removed the fixes tag as there is no functional implication from patches
>   1/8, 2/8 and 4/8.

I've queued up the first 4 patches of this series.  Feel free to redo
the rest and resend.

thanks,

greg k-h
