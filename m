Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82F2C8109
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgK3JaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgK3JaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:30:12 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6372076E;
        Mon, 30 Nov 2020 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606728571;
        bh=M2Y4jh0/IE5UZ8mjVAOrbo0e+cGQS/EhFZC0WGmH/mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJylgqM37jfMqrMUc8NsaHoFfF5prVykUO3kbi/faQOA1uGoqBfe7eeDXQkLKa1JW
         AtF+ewjG3aAZk2WnsI0FTlQZLTo7v4mnNDJ3dfhTe9hZrRL0W994A6ghpFSfRlvQVb
         s5UmIx7jQwig1drhTyGJLpxrg7BB+6gbClshzE4o=
Date:   Mon, 30 Nov 2020 17:29:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: add optee node
Message-ID: <20201130092917.GC4072@dragon>
References: <20201115225314.8114-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115225314.8114-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 11:53:14PM +0100, Michael Walle wrote:
> Add the optee node which can either be enabled by a specific board or by
> the bootloader.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
