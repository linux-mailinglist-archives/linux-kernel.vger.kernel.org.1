Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BA32F0737
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAJMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbhAJMfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:35:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33CAD229C7;
        Sun, 10 Jan 2021 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610282081;
        bh=dQmMkxPxNUhQmCqd+MQpR7iMNocKWEFH3dWqe7unvuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8xtN8+OxQHvG6C9lRCLabJdFOXWiM6LjqMQAZ4Rezvt/ny4Eb/5iteztCrcgIJ30
         xlFzfoo35AfGFn95E1tXCDnMPgwV3zEY1Et08BWE7JDpEGeb9O+o7YgNcp5YMrco0E
         5Oo2lfYR1BxLFduW3Jsr2E3QgQn/u/OyaH/crNYyqeGO2yC/zfM5IqOqx9a9pnp7xN
         p2QpiW5eBvgZe8IxJ+7UnLy5j6d0H9/+8ZrQbx3ZTyQ3Z4cAMYopoFIyLXaAqq6SRm
         GgeDyK+lXKKilUY6HDLzEACDS3yBGa2vPzK+FU6/7Jn6lP3gsn8DVqM62WiGD3Ak2K
         c0YmTdDjswdhQ==
Date:   Sun, 10 Jan 2021 20:34:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6q-logicpd: Drop unused clock-names
 reference
Message-ID: <20210110123434.GN28365@dragon>
References: <20201217172530.1459503-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217172530.1459503-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:25:28AM -0600, Adam Ford wrote:
> The wlf,wm8962 driver does not use the clock-names property.
> Drop it.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied both, thanks.
