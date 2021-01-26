Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740D2304E74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbhA0Ab2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:31:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391190AbhAZRWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:22:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 643C420829;
        Tue, 26 Jan 2021 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611681680;
        bh=rdBQGgtRC6g1GAnUIOAav3Aud5HLHMk8F/g0t4XS8Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlNwl/PR35t9YK+vq4a2j0oWS94SnoBThYTMMoerbxPfbzA99wSF7To/81LdGF+vv
         aSaAJ14X1XJSTJxn8tt3Kq0ErLU8/py3ypeh4LSZhWJWvIs6ACJ6bgbugsrlEnb+bZ
         usvPkrPjoA+AwvJ2YmcZOG54Sz80MA/Z+FzXP16mCUgAx7OW4WYKoLGfx6TeFEZyw8
         VZGKhJvBs9pv+vmiOxCuGPQ9iwmpgCKi0wnFf6UwnsjwQzUkv5LPast3arl0fUVOix
         Nzz9oOW1SFcRyBe4UEIO7YEl93ebcRcO2a5p4L8YmoNp985mvaiH/uZPvH68+ZlqK3
         a9vOXgQuzxbCw==
Date:   Tue, 26 Jan 2021 22:51:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, chuanhua.lei@intel.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: intel-ldma: Fix $ref specifier
Message-ID: <20210126172116.GT2771@vkoul-mobl>
References: <20210120180939.1580984-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120180939.1580984-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 10:09, Bjorn Andersson wrote:
> The $ref for "intel,dma-poll-cnt" is missing an '/', causing
> dt_binding_check to fail. Fix this.

Applied, thanks

-- 
~Vinod
