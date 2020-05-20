Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB71DB79D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 11:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETPBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:01:13 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588E72072C;
        Wed, 20 May 2020 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589986873;
        bh=rJcszFNhkFUSYwnt0XWGop6xqjAyo49vCw5FwZajQ4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7layh2lMkLVe5MF1LbCYkLg2KiM8M3olH1xTQFZO/4PgHtX3nVrdGDOJMc1iadx6
         pjBq3RQ45uEm6nvpeqWWsTO2p5FUMxaufVgA0+sk4nTQbslNLAbdnwzPVjF9jdsA0e
         XKPjsIui4HU4/j4gWRuXRpIccktQ7VAVipUh1vzQ=
Date:   Wed, 20 May 2020 23:01:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: add qe node to ls1043ardb
Message-ID: <20200520150108.GB9249@dragon>
References: <20200520040221.10536-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520040221.10536-1-qiang.zhao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:02:20PM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> Add qe node to fsl-ls1043a.dtsi and fsl-ls1043a-rdb.dts
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

Applied both, thanks.
