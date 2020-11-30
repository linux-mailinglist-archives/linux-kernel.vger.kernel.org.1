Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745182C7E79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgK3HJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgK3HJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:09:20 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8246206CB;
        Mon, 30 Nov 2020 07:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606720119;
        bh=mFUuIntHAhQo2P1S4HmxmSxg0t9IOqSG4xwPV9Odzlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wM0eGD2isWWBn/ZSVcRZfH/LccAWlRX2WQrmZHiWTu1qCDtsbanBJURnMTwxo3ixB
         4dpkDLWCaNTQKY16jrK+D8E4E/UQqq2/XV1ejl8jTsFxwFvCj8+UtFQJeRXBXEUmFF
         tvXYsl8KTyI+YVSSvOzm4rxdMDjWFxSAn5Bz+4uI=
Date:   Mon, 30 Nov 2020 15:08:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm: dts: ls1021a: fix rcpm failed to claim
 resource
Message-ID: <20201130070830.GB28406@dragon>
References: <20201102072652.34893-1-ran.wang_1@nxp.com>
 <20201102072652.34893-3-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102072652.34893-3-ran.wang_1@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:26:52PM +0800, Ran Wang wrote:
> The range of dcfg reg is wrong, which overlap with other device,
> such as rcpm. This issue causing rcpm driver failed to claim
> reg resource when calling devm_ioremap_resource().
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks.
