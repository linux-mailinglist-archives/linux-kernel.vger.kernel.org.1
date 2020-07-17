Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036142234D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGQGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 02:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgGQGn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:43:29 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF6220704;
        Fri, 17 Jul 2020 06:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594968208;
        bh=DK8wLXW4Bso2Ug/1nliw14Hc5cbCm6Qaa7+yZ6pWy4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UU231FHlN9u9m9S+RrvJ6YRfedNXP/xxgfNqJI6mEieve2ujinZR7vazoZlPdNVMo
         CPRBPZ3MyE1RtQq2ZOyUB9NSKL7mrcB/j8P8aob5ldjbJ0pH4cPoblT0COglT2c/FR
         /HmnE80WCUZw1azCYrFmDhhNlY1jaufmZ5Km0wYg=
Date:   Fri, 17 Jul 2020 12:13:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/7] Tegra XUSB charger detect support
Message-ID: <20200717064324.GJ82923@vkoul-mobl>
References: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
 <20200716124809.GC535268@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716124809.GC535268@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-20, 14:48, Thierry Reding wrote:

> Hi Kishon, Vinod,
> 
> did you have any further comments on this series or is it good to go
> into v5.9?

I dont have this series in my inbox, can you please rebase and resend

-- 
~Vinod
