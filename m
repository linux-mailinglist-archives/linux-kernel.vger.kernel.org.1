Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38CB1B8493
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDYIPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 04:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgDYIPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:15:24 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27072071C;
        Sat, 25 Apr 2020 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587802524;
        bh=ww/HOV88lBa4723mthKQctFHSP3uLaHiUZfFuvkpzN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiVpjzRxKYQGDxjqEYzyshB3ff3yL6gbLHbRrGRiHmT/A7L0FXZImrD7s4KT5X502
         C3/1Gu+Peba8tQbfbNEyvZUno6K4kit+aDWPqCQUAjq/kdzniJzBdUTHTkVfHwbzN1
         OBxTWQWrfYsJ/uLQRU9Yf9WblyMiMXWllLW5XWek=
Date:   Sat, 25 Apr 2020 16:15:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, horia.geanta@nxp.com, peng.fan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4] arm64: dts: imx8mp: Add thermal zones support
Message-ID: <20200425081517.GB30501@dragon>
References: <1585915404-7658-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585915404-7658-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:03:24PM +0800, Anson Huang wrote:
> i.MX8MP has a TMU inside which supports two thermal zones, add support
> for them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
