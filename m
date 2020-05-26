Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E151D37BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 19:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgENRNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 13:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgENRNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:13:51 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2222065D;
        Thu, 14 May 2020 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589476430;
        bh=Z3p3h1N/BubQRakbv/vf4PelC3tt6O0uXYZd9qIxMfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1wLjHlhHzKMqmcUJm+i8cO0py6KLJXLDxpkQrHKoYiuZ6gTudzpPf6QUL7k1GkdG
         F72j7RAnF6JT7yv/xpem3MYg0dU130Ro3cRsCnyaqDsKffdS0ZoToubIv0LWdxqINe
         EdefdJu99PN4juHbZZaoylfcHxEBM+xwLwREZU30=
Date:   Thu, 14 May 2020 22:43:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: c630: Specify UFS device reset
Message-ID: <20200514171339.GD14092@vkoul-mobl>
References: <20200406060049.227029-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406060049.227029-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-04-20, 23:00, Bjorn Andersson wrote:
> On some device the reset line for the UFS memory needs to be tickled in
> order for UFS to initialize properly, add this to the ufs_mem_hc node.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
