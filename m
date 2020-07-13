Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9597721C3C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGKKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 06:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGKKjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:39:23 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B284720720;
        Sat, 11 Jul 2020 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594463962;
        bh=0tKmM3hnqlBR6wjwAtL9NeJWHhpnrj1shC9MoLhtWb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=So+3Dv31XOmsflbh95H6ny1myLUVlNMHmgO38lh/dhdu/T/xblhAW6r0gdCkK4voN
         eUrZKXqAMTDNSTtmvGsxXthpT+t41KTUj/Xee3WMIDcx3ZZI0xgRZGDgklLeFEeiYr
         hAYy+JVwRdu92whWLyV6LZSEFJRAEpizc1z8CiqE=
Date:   Sat, 11 Jul 2020 18:39:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>, Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Message-ID: <20200711103902.GA21277@dragon>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416145123.73039-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 04:51:23PM +0200, Sebastian Reichel wrote:
> From: Ian Ray <ian.ray@ge.com>
> 
> Use kernel LED interface for the alarm LEDs.
> 
> Signed-off-by: Ian Ray <ian.ray@ge.com>
> [Rebased]
> Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
> [Rebased]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

s/imx53: ppd/imx53-ppd in subject.

Applied, thanks.
