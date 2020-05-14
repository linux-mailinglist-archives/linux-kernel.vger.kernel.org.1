Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFEA1D317F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgENNkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 09:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENNkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:40:39 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18EC20727;
        Thu, 14 May 2020 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589463639;
        bh=jNuPA/dabcue1FHcKH317SrIIgVTgh/73Xfhxy1N3ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB1h5IvLUjxY1J5AEn8KN6oNNBIqrDgkdylvwL7wrwljvb+G/ffzjvgEUAScfgJAg
         Dq6VgU6IcGxexhTnCh/1I5MZKjNe9NrLUYDT3z70Y9Uu4jl45A9qpy/qFgYC034rSx
         r9uiLdhXe4EXqqgf9AvsAHXMruxi9zRtqskYjXJo=
Date:   Thu, 14 May 2020 19:10:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: db820c: Add pmi8994 RPM regulators
Message-ID: <20200514134027.GS14092@vkoul-mobl>
References: <20200417070303.1376290-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417070303.1376290-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-04-20, 00:03, Bjorn Andersson wrote:
> The PMI8994 provides 3 SPMS regulators and one boost/bypass regulator.
> Define s1 and the boot/bypass and update pm8994 to appropriately
> describe the supply from PMI8994.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
