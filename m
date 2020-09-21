Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6327266E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgIUN76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIUN75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:59:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F1E20866;
        Mon, 21 Sep 2020 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600696796;
        bh=a4DF4W7dtH8e/HdbJnpntS4I8yTDTPerCU7Lh31WhNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wg9S+ccqsDems1XcMj6eWPCpdmJ2G7w+rjxlyHduxbE5H7pjT+kzuyEjIROlO22rH
         JDTh02rcsjIObg8hrRocIUlihWizF1Ghdv/loTWSlrG9BWmGad/xgg14LZ+oJjN6wZ
         MgIcADkUToN3Vu5HCUYF0wrTHg+++B8cNEo52KJw=
Date:   Mon, 21 Sep 2020 14:59:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        swboyd@chromium.org, sumit.garg@linaro.org
Subject: Re: [PATCH v6 0/7] arm_pmu: Use NMI for perf interrupt
Message-ID: <20200921135951.GN2139@willie-the-truck>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819133419.526889-1-alexandru.elisei@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:34:12PM +0100, Alexandru Elisei wrote:
> The series makes the arm_pmu driver use NMIs for the perf interrupt when
> NMIs are available on the platform (currently, only arm64 + GICv3). To make
> it easier to play with the patches, I've pushed a branch at [1]:

This mostly looks good to me, but see some of the comments I left on the
code. One other thing I'm not sure about is whether or not we should tell
userspace that we're using an NMI for the sampling. Do any other
architectures have a conditional NMI?

Will
