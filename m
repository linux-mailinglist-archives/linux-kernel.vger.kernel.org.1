Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F121628302F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJEFnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 01:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEFnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 01:43:45 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB05F20795;
        Mon,  5 Oct 2020 05:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601876624;
        bh=UIfs/QjJhr/15MgKIx4LXx9zHHFqHKPgnpSoA3A3h/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8PkLNVlLUhhTKj46FC/a8JCNB5IuL+oUAa7MMJTGVnbpSxsqvWC1KNbXP9wypBpI
         L4AqVwJjgj5Jam08Ix6i7F0hxN6KmbdLnpMcFuQ3DIdR+t2wJPUVfK3LMmj2btzLhm
         pA7r9XCmZ8RUqEEQvhEsfrqZikrsD7qWI/iu4+iY=
Date:   Mon, 5 Oct 2020 11:13:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/2] phy: phy-brcm-sata: Allow configuration SATA AFE TX
 amplitude
Message-ID: <20201005054333.GM2968@vkoul-mobl>
References: <20201001031916.411999-1-f.fainelli@gmail.com>
 <e2ff572e-8934-bf98-0bcc-06220b277810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ff572e-8934-bf98-0bcc-06220b277810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 04-10-20, 19:56, Florian Fainelli wrote:
> 
> 
> On 9/30/2020 8:19 PM, Florian Fainelli wrote:
> > Hi Kishon,
> > 
> > This patch series allows the configuration of the Broadcom SATA PHY TX
> > amplitude which may be required in order to meet specific tests.
> 
> Hi Vinod,
> 
> Would you need me to resend these two patches? For some reason
> get_maintainers.pl did not pick up your email. If not, here are the two
> patches from lore:

Yes I dont have these in my inbox. Unfortunately it is late in the cycle
and I have already sent PR to greg for 5.10 so I am not accepting
patches till rc1. Please rebase on rc1 and resend...

> https://lore.kernel.org/linux-devicetree/20201001031916.411999-2-f.fainelli@gmail.com/
> https://lore.kernel.org/linux-devicetree/20201001031916.411999-3-f.fainelli@gmail.com/
> 
> Thanks
> -- 
> Florian

-- 
~Vinod
