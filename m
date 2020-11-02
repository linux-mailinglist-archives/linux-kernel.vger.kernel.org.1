Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346052A3742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKBXlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKBXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:41:05 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90792225E;
        Mon,  2 Nov 2020 23:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604360465;
        bh=z0bNcqRwlmNyqaG17nH4donPoYZJkBcxVWVN+rYbQ3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9HQYRG1Fnn8/AG8fYtbUtXEdxISME2wGpcWXt09OUS2kZ+WgYbXzjJQ9RL7ZttxV
         vaXKprPYot2nE6vx/7xxqTa56oJBnSpcL+svpB8Y/lK/FL+JHQRs/xeDdOOGy4sjtK
         MqzRHGbSb7iY4zDu0QaD0B9fUWTbq3iyigrZqpoU=
Date:   Tue, 3 Nov 2020 07:41:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        leoyang.li@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv10] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Message-ID: <20201102234059.GW31601@dragon>
References: <20201102054417.5792-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102054417.5792-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:44:17PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add PCIe EP node for ls1088a to support EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Applied, thanks.
