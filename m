Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D36204AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgFWHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgFWHNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:13:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88293206B7;
        Tue, 23 Jun 2020 07:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896400;
        bh=fMpof1t1tsVHjKLneM0RMY/Ezbl8LEqKmDA8dszw/Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxsyUamE+mhQKKxN1K6z5hQbMAt2M8TVUu9V0y1453+/GN57AOXzF3yi/p2WoYmlE
         tQ1XlR4DzYYc4YPjMxSIXJsFWOjlR7Qs3rQwJ1FFfBxsfv0/CjrhCXrs+AoNfxE2kX
         wU9dfc/6JNcNoA3JkFg/24ydg5nUmIiSquEyDnHE=
Date:   Tue, 23 Jun 2020 15:13:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: scu: use devm_kasprintf
Message-ID: <20200623071314.GU30139@dragon>
References: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 05:29:32PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use devm_kasprintf to simplify code
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
