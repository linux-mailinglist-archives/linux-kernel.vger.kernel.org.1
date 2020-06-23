Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF7E204B57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgFWHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbgFWHic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:38:32 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1516D2073E;
        Tue, 23 Jun 2020 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592897912;
        bh=JIdlbbpifgCfE8+Yrucggvv51LNW4ZTYqEuLD5ng41Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIZVLAaB5zHZ5Qqi1lxi5N6ukq6IZ6TAqZOONqV2ETUgzh5X4YW1YhS9BqLa+4297
         HvS/GrvVU/rsVgS/nTwYXW5rjbpmrD/mWBF7WOwYZdfm9cvt/bGdL08iuwlX7LCZ5m
         HQ8GhpGB0VYx3seIDnnIeYaswRRYTaFXlLVAMaZs=
Date:   Tue, 23 Jun 2020 15:38:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, aisheng.dong@nxp.com, festevam@gmail.com,
        qiangqing.zhang@nxp.com, linux@rempel-privat.de,
        franck.lenormand@nxp.com, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V3 0/3] firmware: imx: fix/update cm4 and add resource
 check
Message-ID: <20200623073825.GW30139@dragon>
References: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 09:59:29AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Fix comments
>  Add R-b tag
> 
> V2:
>  Add R-b tag
>  Drop patch 3/4 from V1
>  Add comments and update Copyright for patch 2/3
>  keep code consistency in Patch 3/3
> 
> V1:
>  https://patchwork.kernel.org/cover/11505045/
> 
> Fix cm40 power domain, update to add more cm4 resources
> Add resource owner check, to not register if not owned by Linux.
> 
> Peng Fan (3):
>   firmware: imx: scu-pd: fix cm40 power domain
>   firmware: imx: add resource management api
>   firmware: imx: scu-pd: add more cm4 resources

Applied all, thanks.
