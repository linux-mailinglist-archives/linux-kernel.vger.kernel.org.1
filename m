Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E791F7830
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFLM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 08:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLM7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:59:52 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEBB20792;
        Fri, 12 Jun 2020 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591966792;
        bh=MKQQpvr7EQJhmEioJJE4VZbRGd6MocMRhIpMoJJ7U60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1erF+Gnz10eFlYO5+Gpah2ueDrWqubNymiRTSfA6na+vakPD8ZmpEbDufK7C04M7H
         sDVGiR0doXlAxrBzXjGQ42xREvMlrDywEIOJwsIJ9gUamRRKYfe2mozRngC+P4GAcG
         vFknS9PLCrY7qm6VNDwDU9OY7rsoqlJdsi9812Ak=
Date:   Fri, 12 Jun 2020 18:29:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: qcom: common: set correct directions for
 dailinks
Message-ID: <20200612125948.GH1393454@vkoul-mobl>
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
 <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-20, 13:37, Srinivas Kandagatla wrote:
> Currently both FE and BE dai-links are configured bi-directional,
> However the DSP BE dais are only single directional,
> so set the directions as supported by the BE dais.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
