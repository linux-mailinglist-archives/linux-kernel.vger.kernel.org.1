Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AC2571E5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHaCa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgHaCa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:30:57 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E60920720;
        Mon, 31 Aug 2020 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598841057;
        bh=zatcY7DLqD+EK1YglnfTs7ODxJ1nZRXSAejUpAPUtKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YF7XTnNawQAIhVvEFTwo5g2HN1AkTDdfrNqiM2Xwhkvr+SBML2+FkAzX3JgAJSKuw
         H01ANlof0m2l55AJPq4Ab+aeuHFkanHru/2p0wrM/X+HtcaxrUhBck0SVdo3fA1Mmg
         IKGHEJ9bSoaJRAB0HmUT73h8qCBjDi9/zdgHRChg=
Date:   Mon, 31 Aug 2020 10:30:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add headphone detection for sound card
Message-ID: <20200831023051.GD4488@dragon>
References: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:50:36PM +0800, Shengjiu Wang wrote:
> Add headphone detection for sound card
> and add audio sound card node for imx6sll.
> 
> Shengjiu Wang (3):
>   ARM: dts: imx6sx-sdb: Add headphone detection for sound card
>   ARM: dts: imx6sl-evk: Add headphone detection for sound card
>   ARM: dts: imx6sll-evk: Add audio sound card node

Applied all, thanks.
