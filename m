Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240C2255E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 04:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGTCbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 22:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTCbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:31:31 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BE922BF5;
        Mon, 20 Jul 2020 02:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595212291;
        bh=BcQNnooSGwghnyBmT74Bsutjt7vV+HOXEbvFIIOA7ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhXDySn44asI/AGBP8c1ik5HTgn0pSSggAaymXaJqOrEerBVELPP3onBKd+0kLZUC
         HrN4+JaDnqVmepay3R8BhbTfRB+YN/jc/U6DPWYT7IGbKfR+ucKF8ge8iKD8PZrEBl
         A2/EWpVGMvEbuzF/0Vibcpu7M/64XGqx86XWT/pw=
Date:   Mon, 20 Jul 2020 10:31:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, meenakshi.aggarwal@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [RESEND v2] arm64: dts: lx2160a-rdb: fix shunt-resistor value
Message-ID: <20200720023123.GH11560@dragon>
References: <20200714070828.3177-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714070828.3177-1-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 03:08:28PM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Fix value of shunt-resistor property.
> The LX2160A-RDB has 500 uOhm shunt for
> the INA220, not 1000 uOhm. Unless
> it will get wrong power consumption(1/2)
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Applied, thanks.
