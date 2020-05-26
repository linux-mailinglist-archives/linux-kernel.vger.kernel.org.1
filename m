Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406A41DA863
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 05:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgETDAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 23:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgETDAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:00:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40CE2070A;
        Wed, 20 May 2020 02:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589943280;
        bh=UbKsXSOCk2pZ+pEBMm8X9jtB4NakhE8HRYnbJhGud/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5jLggP40SKQV0/y9E16161dX3a/xjIhoJKDzMoCpKmC/FSI996OAF4nkA7ifbxK0
         ijnjVWBxS7RntuLOWi1LkFBi1stkdcMN6jKmQ5eCGgx5xndpn1lWiroLQuZ04p75gD
         L7e+0TDDTuNVL/Me9OJ4aSALMexerFpIT3GvTK0k=
Date:   Wed, 20 May 2020 10:54:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: ls1028a: sl28: keep switch port names
 consistent
Message-ID: <20200520025435.GW11739@dragon>
References: <20200519210319.21319-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519210319.21319-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:03:19PM +0200, Michael Walle wrote:
> Keep the switch port labels consistent across the different board
> variants. If the user wants to rename them, it should be done in
> user-space.
> 
> Fixes: ab43f0307449 ("arm64: dts: ls1028a: sl28: add support for variant 2")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
