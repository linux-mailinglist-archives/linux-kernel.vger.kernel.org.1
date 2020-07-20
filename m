Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED75225620
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGTDTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 23:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTDTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:19:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA832080D;
        Mon, 20 Jul 2020 03:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595215148;
        bh=U4xZaTXPavwGjE6wjx6abzQrdFTPKV9Q1lnbcwX5aQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SC8+13t9DW8+6+LqNG30/oWMv3xC6Rkq4Fv6+to44/1jeuYiGYsuWm9lRIn77tEmg
         Eq7j3dcIQw4p05g79arhiUvKs1ughB9Qy66Pr65Yj4jEgEWWbRwMF2RdiWrwztcDcb
         DTsWz4pH9EIM5TwNBIkCKWuMjP62C1d0D97gq0iI=
Date:   Mon, 20 Jul 2020 11:18:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     s.hauer@pengutronix.de, stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-ssmb-dtu: Add no-sdio/no-sd
 properties
Message-ID: <20200720031734.GK11560@dragon>
References: <20200715213148.26905-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715213148.26905-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:31:48PM -0700, Chris Healy wrote:
> esdhc0 is connected to an eMMC, so it is safe to pass the "no-sdio"/"no-sd"
> properties.
> 
> esdhc1 is wired to a standard SD socket, so pass the "no-sdio" property.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
