Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938D2DD59A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgLQQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgLQQ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:59:28 -0500
Date:   Thu, 17 Dec 2020 08:58:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608224328;
        bh=oyYoNz7kwKo0G90301ygCuBdPOGkYFptP24JCUQXhME=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=mlxebBbzeaVPONuAIwFArcOQHWRBdpZQuQ9vE2K1JvxN2s9wbL1deTLgtGGvXftgg
         pnus1zqMUv5lgQAPvUqRR++v3S3SBvoQgZcdjHDTdHzSMPpD/S1wB8lFQHaBWRLkYF
         /By8tlBGY+qPBsQsCc4iEZICfflKZfYQyYaYHRNcGp6KwJQcFJOu0ZPFDSUqZEeBSA
         6FwJyPmeefBkF6SkSMaeFU6sZxnjSFtEv/YAXDf57EgbkC3MUtbMVHnFLPwYpxTGqg
         371qld/8QxnZj9IaBBUwzs/gONIAtmqZs0KdMwOttq/cPZniGW7WlhyFLMvSwNb1UP
         P2/smkU1zydqg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mhi: Add raw IP mode support
Message-ID: <20201217085847.413f2d53@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1608219249-6297-1-git-send-email-loic.poulain@linaro.org>
References: <1608219249-6297-1-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 16:34:09 +0100 Loic Poulain wrote:
> MHI net is protocol agnostic, the payload protocol depends on the modem
> configuration, which can be either RMNET (IP muxing and aggregation) or
> raw IP. This patch adds support for incomming IPv4/IPv6 packets, that
> was previously unconditionnaly reported as RMNET packets.

Now it sounds a lot more like an extension than a fix. Is the interface
usable without this change? If it is we should merge this into net-next
after the merge window.

Either way you need to cc netdev for this patch to get into patchwork. 
