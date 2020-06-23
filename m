Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6020530B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgFWNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgFWNFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:05:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F007920716;
        Tue, 23 Jun 2020 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592917514;
        bh=E+DOq7F5ULl1cRralKF9cu2iDyzgJSDXvsLsNukPyhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1acT84O01ZTv2OAWQnjeBfndCV/OU6pe7/Trmn6kZVTPcTC6pVzH4E91XtnzqCarP
         FU3kKISFVaOiVeAZH8By/+54IkVWtJoeguUO/4XapdCSe0MyZYw4z4bDPBS+nY71JP
         eXQaStpRLjRqXHNGMtWhpWJgJmOs35olrJXMHEZI=
Date:   Tue, 23 Jun 2020 21:04:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mfuzzey@parkeon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ARM: imx5: add missing put_device() call in
 imx_suspend_alloc_ocram()
Message-ID: <20200623130458.GA29965@dragon>
References: <20200604124206.3910721-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604124206.3910721-1-yukuai3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 08:42:06PM +0800, yu kuai wrote:
> if of_find_device_by_node() succeed, imx_suspend_alloc_ocram() doesn't
> have a corresponding put_device(). Thus add a jump target to fix the
> exception handling for this function implementation.
> 
> Fixes: 1579c7b9fe01 ("ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.")
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Applied, thanks.
