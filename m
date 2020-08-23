Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E0324EB02
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 05:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHWDCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 23:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgHWDCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 23:02:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037332078D;
        Sun, 23 Aug 2020 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598151735;
        bh=uTgQL77RPZR0fTqJoIKMvU1rRbqqWQj87K/5u9ZUZlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zuLYfPe9zkVJBM3D5REiI6WZ+8NmwakqHwHBXQgH7MTSxHFYDhc7SFK896SoIBdxH
         GFizAvgD1ST0N5sKE3DJpJSA6gAyrI+rT9gIxMFtNmldKdOntPYrBcGrQOFoLST8mb
         DmK20mecwN/tZoGrwETo9Cbt6EpSivX8yHwNzWck=
Date:   Sun, 23 Aug 2020 11:02:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mchehab@kernel.org, Anson.Huang@nxp.com, agx@sigxcpu.org,
        angus@akkea.ca, broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v6 1/3] arm64: dts: Add a device tree for the Librem 5
 phone
Message-ID: <20200823030208.GS30094@dragon>
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821121755.24599-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:17:53PM +0200, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Add a devicetree description for the Librem 5 phone. 4 hardware revisions
> have been available. Some revisions include changes that need different
> software to be run. So far, r3 ("Dogwood") is one such example, see:
> 
> 	"Aspen"		r0	not supported (very few devices exist)
> 	"Birch"		r1	supported by r2
> 	"Chestnut"	r2	added by this patch
> 	"Dogwood"	r3	added by this patch
> 	"Evergreen"	r4	tba / most likely supported by r3
> 
> See https://puri.sm/products/librem-5/ for more information.
> 
> This boots to a working console with working WWAN modem, wifi usdhc,
> IMU sensor device, proximity sensor, haptic motor, gpio keys, GNSS and LEDs.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Guido G�nther <agx@sigxcpu.org>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com> (for the audio part)
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied all, thanks.
