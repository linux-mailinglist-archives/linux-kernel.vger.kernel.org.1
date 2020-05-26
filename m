Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7971D6860
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 16:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEQOOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 10:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQOOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 10:14:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DD8207BB;
        Sun, 17 May 2020 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589724848;
        bh=rXwkDivezZXP/XFZhS7IyRVb7wzlv+BY+3/avjDVnWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paBKGAz6p+6u9Cstj8rqmp0heJ8wHCUh+obdcLD5zFsSHuBi7IAjEykc+5xeA1Hrx
         0IWSzjcgKMlRuTqtYD1DebL6W0DklhUq4vrQyt+xUGDSbIjIHEyaLioHHLqQAbimmr
         sKnsh6sfseOEMHoRpHBNkZhn1SJOoi82nv1kNQrk=
Date:   Sun, 17 May 2020 22:14:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     fugang.duan@nxp.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec" compatible
 string
Message-ID: <20200517141402.GC25973@dragon>
References: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:04:14PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> Add "fsl,imx6sx-fec" compatible string for fec node, then
> i.MX8MP EVK ethernet function can work now.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Applied, thanks.
