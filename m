Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C79F273143
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgIURxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgIURxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:53:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF0B20BED;
        Mon, 21 Sep 2020 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600710816;
        bh=rHqhMXLrc2euBYg5DgO9SILeP95LxH71eqk44hTG9fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=whrzXfYPbw8odytdwpTt8k+qKtDPsccHgGGWL3LMfjU7nImxPpZdkYj4L5d4A1Hna
         LYD49Cej2p/1b2Z1Yvz7zj+7a4qaePi+iNj02ULwJDI+quZEN6/H1CSmd38WH/cAc+
         5C5uUnbagc+d1d+LvDl4mE1CbXGDVSRM+jYSp4SI=
Date:   Mon, 21 Sep 2020 18:53:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        swboyd@chromium.org, sumit.garg@linaro.org
Subject: Re: [PATCH v6 0/7] arm_pmu: Use NMI for perf interrupt
Message-ID: <20200921175330.GE3141@willie-the-truck>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200921135951.GN2139@willie-the-truck>
 <296304b8-aadd-817d-bb12-dc7524b6f0f5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296304b8-aadd-817d-bb12-dc7524b6f0f5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 04:41:00PM +0100, Alexandru Elisei wrote:
> On 9/21/20 2:59 PM, Will Deacon wrote:
> > On Wed, Aug 19, 2020 at 02:34:12PM +0100, Alexandru Elisei wrote:
> >> The series makes the arm_pmu driver use NMIs for the perf interrupt when
> >> NMIs are available on the platform (currently, only arm64 + GICv3). To make
> >> it easier to play with the patches, I've pushed a branch at [1]:
> > This mostly looks good to me, but see some of the comments I left on the
> > code. One other thing I'm not sure about is whether or not we should tell
> > userspace that we're using an NMI for the sampling. Do any other
> > architectures have a conditional NMI?
> 
> I'm not sure about other architectures being able to configure the perf interrupt
> as NMI or a regular interrupt, I'll try to find out. Regardless of what the other
> architecture do, I am of the opinion that we should spell out explicitly when the
> PMU is using pseudo-NMIs, because it makes a huge difference in the accuracy of
> the instrumentation and the overall usefulness of perf.
> 
> If I spin a v7 quickly, is it still time to merge the series for 5.10?

I'm on holiday for the rest of the week, but please post something when you
have it and I'll queue it if I manage to get to it.

Will
