Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36AE1DA7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgETCTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 22:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETCTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:19:37 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EA72070A;
        Wed, 20 May 2020 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589941177;
        bh=3fXb+EI8ngopPkb4IHKZ5B7gS7wb6BillnmOQicLI1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOWsdZKue7cvB+S0VdKBvrMGukCYla71N44Y4qdym1Nvje6ymhLLrT/reGSwoJLFq
         d9mVBvAy6mNdgjaWlzwmaT61Dm0fBKnJMmZKPFgI4/81df79NrFz09hGhlH/qQ8PiL
         JScZprkbKVrZ+UD3iCboLv0HvvM7q5DdWpzbQnTo=
Date:   Wed, 20 May 2020 10:19:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw5910: fix wlan regulator
Message-ID: <20200520021931.GQ11739@dragon>
References: <1589320954-25219-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589320954-25219-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:02:34PM -0700, Tim Harvey wrote:
> Connect the wl_reg regulator to usdhc2 such that it can be enabled
> and disabled as needed. There is no need for this to be always-on.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
