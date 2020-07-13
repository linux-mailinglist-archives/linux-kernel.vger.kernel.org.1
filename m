Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB69021CD10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 04:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGMCR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 22:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMCR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:17:57 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1A5206D9;
        Mon, 13 Jul 2020 02:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594606676;
        bh=v31vMi7ynx1XiseH1ZOMeZU6ugOoDG2CHW9KHbrBmaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wg/hHcHDNbDrO2lEUyNe08emznimj5pe7YaRk/C3wLGMOKEvgMnckk/oGOhgpPlr2
         MvuVMNugN5Gn9DVAeVB1qKJRXwywXJ/PwO01xPVJbY7SAPPilOCvkbo14hCk//9eKb
         /AyuSpI7ZekWYHFfd/YfP4qhwoMf3Dh+JlUEfyNE=
Date:   Mon, 13 Jul 2020 10:17:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     andy.tang@nxp.com
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: ls1046a: add more thermal zone support
Message-ID: <20200713021735.GV21277@dragon>
References: <20200629074519.28851-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629074519.28851-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 03:45:18PM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> There are 5 thermal zones in ls1046a soc. Add the rest thermal zone
> nodes to enable them.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied both, thanks.
