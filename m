Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17DC2F760D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbhAOJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbhAOJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:57:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B46A523772;
        Fri, 15 Jan 2021 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610704631;
        bh=yeOWo8C3eKT6mSb+i4/tuEN2cQzZwDlH6c7HfpvI7S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMuufcOcIvdZ63FsK9gD320B2w2aKuWLZzNQc+dgLs67s+TnBi8rFAqKSOVELZTEO
         lLHR0eNkmRbd9j/LAQds20iF06STgLm5j14Y8IDKByBTMn+Si5MOo4yiV6OMBngcyx
         fc13e3jHMuwXWCnbEb0WvbpKMHvy2+TiW7shU7Cry/pBNY0V64gX3IctYirotA9Jc2
         Pr93W0oVBbv2/OHmOFkrNIufhEzBJbLuT2JYHkAwPNWO5/LUqB6NDEwRpixjvrfrkz
         PMbO5x1sCfGuIT3xDHdIaIYf1I6a55SDjOwWcKb5EWdrNAjCSH+O2QNe65QxvvBOC3
         rJEaY5pGWlJyg==
Date:   Fri, 15 Jan 2021 17:57:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add Kontron sl28 variant 1
Message-ID: <20210115095705.GM28365@dragon>
References: <20210111082134.24704-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111082134.24704-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:21:33AM +0100, Michael Walle wrote:
> Add the a new variant for the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied both, thanks.
