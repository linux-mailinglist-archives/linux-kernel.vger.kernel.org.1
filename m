Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F3205132
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgFWLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732393AbgFWLs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:48:58 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE5220724;
        Tue, 23 Jun 2020 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592912938;
        bh=UtsqBxThkfbChyNwVMO1H972tp+j29upvVPrfA//D+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzPvF3eAjgSjvSUYEevvaIroAuUcX2/FbUPugDVpLUzbnD5OtOOuGgjWWzE8QqGuT
         FyzPpbxbGEwjVONJ4wAhuh9fDPsxohGPZEC9vfJzjD311Z91mnKgd2ii/sAm+mehQ3
         RPJTrvejOs0HrR7EJJBZZVSFUFZQQGfC6di/yH84=
Date:   Tue, 23 Jun 2020 19:48:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, horia.geanta@nxp.com,
        peng.fan@nxp.com, fugang.duan@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mp: Add fallback compatible to ocotp node
Message-ID: <20200623114851.GB30139@dragon>
References: <1591839413-32102-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591839413-32102-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 09:36:53AM +0800, Anson Huang wrote:
> Add "fsl,imx8mm-ocotp" as fallback compatible of i.MX8MP ocotp
> to support SoC serial_number read.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
