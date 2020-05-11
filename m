Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E687F1CDD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgEKO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 10:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:29:39 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E8C206D6;
        Mon, 11 May 2020 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589207379;
        bh=IiuDF+mmYlvq92MMyscTeA2Brp0Juu3RwrbvqlWvpic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCLpQO603HEwcbPxEVy/6e92zLYF7oQFEemtokhcGJliQ6Rmr61hG/vx2x7TtB6wt
         8gUrHr4CMEV8Q6JXjxzOvASzGmz9kBv0lVZn7kVbYLtduXWUTLwQN9isEJpzEfVQCN
         GEpWNxKEK/UP3s0K/6dIGKvcefqMXn3Xfv4qi7Vo=
Date:   Mon, 11 May 2020 22:29:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a: add more thermal zone support
Message-ID: <20200511142926.GB26997@dragon>
References: <20200417061618.48032-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417061618.48032-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:16:18PM +0800, Yuantian Tang wrote:
> There are 7 thermal zones in lx2160a soc. Add the
> rest thermal zone node to enable them.
> Also correct one of the values for tmu-calibration property.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied, thanks.
