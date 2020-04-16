Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927F41AC089
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634493AbgDPL7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634634AbgDPL6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:58:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84BA521D7F;
        Thu, 16 Apr 2020 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587038307;
        bh=C02HcDV/4ymZNiH43m0bSPRVlDyWt+JoeqGraHiMLd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URf8tVUpg0dmW48kXtETXHP24CfevH1ltJdpvaAbByZa5tCvk27qPG9Kfjtvb4RAs
         tlGYb9cWL6gOnGvPrPDx0n8WM9ShN8U2ZjoQEDehefBb+vVe2Mnw3CPY3McZnvoZ9w
         Bg39tBl0Nx4JN2v/pxk4wIRYnLg1kI+62/88Of/0=
Date:   Thu, 16 Apr 2020 12:58:22 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: Re: [PATCH 8/8] arm64: cpufeature: Add an overview comment for the
 cpufeature framework
Message-ID: <20200416115817.GB32443@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414213114.2378-9-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Apr 14, 2020 at 10:31:14PM +0100, Will Deacon wrote:
> Now that Suzuki isn't within throwing distance, I thought I'd better add
> a rough overview comment to cpufeature.c so that it doesn't take me days
> to remember how it works next time.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 43 ++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Any chance you can look at this one, please? I don't trust myself to get
all of the details right here! I'm also wondering whether we should mention
something about KVM and the guest view of the registers.

What do you think?

Will
