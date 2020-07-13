Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B6E21CE00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 06:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGMEHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 00:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMEHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:07:55 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9162070B;
        Mon, 13 Jul 2020 04:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613275;
        bh=ejHWS99iEEHSjQVTIhlMEgtZRGyaaFODIq5arWHElTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMRky2EF0+s1MYuktOpuzwqbOHFfV888W0AMabjYGdu6pIQ5Vl0YaMszC5rGWBcrB
         k30A25pvuexHe7mn9ZHC9TrKWh0PDLGR6wqeigKcx11owSM4mHXOuvIVdTqRDxLGB7
         sbTl/C090td2NSEXoX/Z055KR9RG8+CbQr2dgkHk=
Date:   Mon, 13 Jul 2020 12:07:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable sata
Message-ID: <20200713040746.GA12113@dragon>
References: <1594369848-28627-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594369848-28627-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:30:47PM +0800, Richard Zhu wrote:
> Enable SATA on iMX6QP SABREAUTO board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.
