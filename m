Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9D21CDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGMD1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 23:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMD1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:27:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636D520725;
        Mon, 13 Jul 2020 03:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610840;
        bh=STGp2ZUz63RRCqrXyG2JLhnXkAw6U/ZZfYgZku3W/4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F45/0Z3DlK6+GbH0tVFdt/4eAOjBWuSZITdtmPRqyIMefhsO0jdqOa9ruSU5gZbWB
         OmJ2+sUrWYtjbDk7bYPM4Y7E/mnBhfCyqe903s3wknvv69y1i61PNVW0EmYdtJnY4w
         F+Yv66JUrqKCU/cEGzUuqykovw0sHAAl5CWnBkpI=
Date:   Mon, 13 Jul 2020 11:27:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: imx: Remove imx_add_imx_dma() unused irq_err
 argument
Message-ID: <20200713032706.GE21277@dragon>
References: <20200701221040.3667868-1-helgaas@kernel.org>
 <20200701221040.3667868-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701221040.3667868-2-helgaas@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:10:39PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> No callers of imx_add_imx_dma() need an error IRQ, so they supply 0 as
> "irq_err", which means we register a resource of IRQ 0, which is invalid
> and causes a warning if used.
> 
> Remove the "irq_err" argument altogether so there's no chance of trying to
> use the invalid IRQ 0.
> 
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: kernel@pengutronix.de
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org

Applied, thanks.
