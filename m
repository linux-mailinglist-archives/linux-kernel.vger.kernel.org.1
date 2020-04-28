Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67B1BB786
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD1Hag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 03:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1Hag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:30:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5F9206B8;
        Tue, 28 Apr 2020 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588059028;
        bh=lt9Ss7Lhe+IkC8Wr+elmsXdyPZ1tUoSwVIeuzTfvlPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6A8DxJ/RoQ17XqK/nqiSkerPTPQmw6Q19eWiaBtJoYrWK5cf0NcSCPT0lp0iP1ni
         LOSdbhwMjadscRqRsNMLioRlN3tPMopECuN7vC1vojtpvHXvP7uxAGVAAbRiN87SKv
         0jxKOQ6qU5+1Xt469H/nO5ul9F0xUTgKPWijGGTk=
Date:   Tue, 28 Apr 2020 08:30:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     jason.hui.liu@nxp.com, anson.huang@nxp.com, aisheng.dong@nxp.com,
        catalin.marinas@arm.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        oliver.graute@gmail.com
Subject: Re: arm64: imx8qm: tlb SW workaround for IMX8QM
Message-ID: <20200428073023.GB4049@willie-the-truck>
References: <20200427082348.GA98329@archlinux.localdomain>
 <20200427130328.GA101181@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427130328.GA101181@archlinux.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 03:03:28PM +0200, Oliver Graute wrote:
> On 27/04/20, Oliver Graute wrote:
> > Hello,
> > 
> > is this nxp software workaround already proposed to linux community? can
> > someone point me to the discussion if available.
> > 
> > https://source.codeaurora.org/external/imx/linux-imx/commit/?h=3Dimx_5.4.3_=
> > 2.0.0&id=3D593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c
> 
> sry for the broken link. Here the right one:
> 
> https://source.codeaurora.org/external/imx/linux-imx/commit/?h=imx_5.4.3_2.0.0&id=593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c

Hey, if we're trading links then it should be fixed by:

https://www.hobbytronics.co.uk/jumper-kit-140

Unfortunately, I don't think there's a gift-wrap option for the hardware
folks ;)

Will
