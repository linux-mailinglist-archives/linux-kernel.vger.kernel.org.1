Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318AB29F98B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgJ3APx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ3APw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:15:52 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3643C206ED;
        Fri, 30 Oct 2020 00:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604016952;
        bh=RZvtjjQmqkl4SIvyuR+kk6gCKrTWbtQ7gKKlCkvzWMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yoEceTKh9y3g7dFbR+lOAOl9GOXwRXKKPENVVGaTN/wFqRNwKrKxe+BfjfBp63M8r
         r6TdtNOVhA59zHM1AA+Jimu9+WdSst3MJmC3a+DNFwFSj3p8Hgro0ruR11mkX3WaLQ
         rEO/aLQiivPlHRNo+Du/OnBuuKS6upjMobUl7zWs=
Date:   Fri, 30 Oct 2020 08:15:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, peng.fan@nxp.com,
        aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: imx: Add revision support for i.MX7ULP revision 2.2
Message-ID: <20201030001544.GV28755@dragon>
References: <1601190193-29074-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601190193-29074-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 03:03:13PM +0800, Anson Huang wrote:
> On i.MX7ULP revision 2.2, the value is 3, so add support for this
> revision, otherwise, it will use default revision of 1.0 which is
> incorrect.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
