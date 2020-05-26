Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF11CC763
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgEJGzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 02:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgEJGzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 02:55:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B4120801;
        Sun, 10 May 2020 06:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589093722;
        bh=i5eGJPVlmK+E4XcF7rr2doxsy/jQO4NBL2xSdPxqnXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdYDUObf0M7RBKkgpJMQOM//qgcTHgD4HLXJMvm/0yg8PHYzmQLbD/HcCwqHXrbxf
         SgJdjqHun6gQKs6rojSgCGfRyHRsA9pIYljd5bnqC7GyjKHs7GR5Uz/gn86gfTDlbn
         dt4aKmQVM1hyuL8QYEY8YO3Vq8/4tOJh5hVKpDUo=
Date:   Sun, 10 May 2020 08:55:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] staging: vc04_services: vchiq_connected.c: Block
 comment alignment
Message-ID: <20200510065519.GB3434442@kroah.com>
References: <20200510060645.10159-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510060645.10159-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 07:06:45AM +0100, John Oldman wrote:
> Coding style issue
> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
> v1: Initial attempt.
> V2: Resubmitted with shorter comment line, as suggested by Greg KH.
> 
> This patch clears the checkpatch.pl "Block comments should align the * on each line" warning.

Why is this text not in the changelog area?  Don't you think that it is
better than the 3 words you currently put there?

Please fix up and resend.

thanks,

greg k-h
