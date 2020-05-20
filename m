Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB621DA83F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 04:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgETCwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 22:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETCwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:52:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF3A2070A;
        Wed, 20 May 2020 02:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589943165;
        bh=7N4JAIZvOiJfPBd1SQlUYC1IFT+NKDEVWtcM1h2yEr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QU19nGrQZmqubwxJfN+T+Y0R0/nOlQcJ91q+J8TAqwDjsBST8CiBKWbolk3+UR4oE
         E+frl6PrI7LeEHssj7fTii/6HMILvTKQRdmWie62SRcGMqmKYY/cDIDIEzzUJ5O6HK
         w5/yX1Qv/w+hRksuRy7MoedeLyTMjqxTwwTv4sv8=
Date:   Wed, 20 May 2020 10:52:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx: make src node name generic
Message-ID: <20200520025239.GU11739@dragon>
References: <1589805593-14164-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589805593-14164-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 08:39:53PM +0800, Anson Huang wrote:
> Node name should be generic, use "reset-controller" instead of "src" for
> i.MX6/i.MX7 SoCs src nodes.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
