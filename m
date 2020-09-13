Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A75267D67
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIMDGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 23:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgIMDGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 23:06:39 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9067020709;
        Sun, 13 Sep 2020 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599966399;
        bh=u2/sq/twu/2OMBd96kjOaxoHUtwy04jPreQvHnp5zcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N++sc4XCrvsYB37IYnO9s6WsoNvj/yUUYJt6x+o9hmIZ3j5SZmeVQKYAq5VEkMcsI
         MduZDGu3BM3UhWnVPiBlgAgRrQtcAjDJK+FRBdKzUjhjKTFjjP72LILWNbEGZz0QxG
         cgfdrLSOs9s45gQGylwXXtjO3qA0FvmTJK2o4dxY=
Date:   Sun, 13 Sep 2020 11:06:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH] ARM: imx7ulp: enable cpufreq
Message-ID: <20200913030633.GL25109@dragon>
References: <1599795104-7016-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599795104-7016-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 11:31:44AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable cpufreq for i.MX7ULP when imx cpufreq dt driver enabled.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
