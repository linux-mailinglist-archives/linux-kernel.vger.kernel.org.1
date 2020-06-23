Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA820510D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgFWLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbgFWLpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:45:49 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A45E20724;
        Tue, 23 Jun 2020 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592912749;
        bh=PBiD7necVNVOoCJzR6OIuIBIITs01eGX9suQZGD9qkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXKCfC8YSiO+6l7JzlCajY56+mwVquPQuVadxjxehJIGefonQktOfruREC2eADtSZ
         uUorVc/2uuCaBrF/2CPCkHkx4PIZnYS0PxJ70zKf2iiKceCnxqTxANEXJ4e41GQ3Yl
         9l5Vt9X2SCQrXvi3150F9DWHAgIZ4VjyXw9j5hzo=
Date:   Tue, 23 Jun 2020 19:45:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V3] soc: imx8m: Correct i.MX8MP UID fuse offset
Message-ID: <20200623114543.GA30139@dragon>
References: <1591783382-27033-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591783382-27033-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:03:02PM +0800, Anson Huang wrote:
> Correct i.MX8MP UID fuse offset according to fuse map:
> 
> UID_LOW: 0x420
> UID_HIGH: 0x430
> 
> Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc driver")
> Fixes: 18f662a73862 ("soc: imx: Add i.MX8MP SoC driver support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
