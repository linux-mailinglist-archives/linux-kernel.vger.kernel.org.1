Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF01DB240
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 13:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 07:49:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETLtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:49:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEDD61045;
        Wed, 20 May 2020 04:49:49 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC6C13F52E;
        Wed, 20 May 2020 04:49:48 -0700 (PDT)
Date:   Wed, 20 May 2020 12:49:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: Move BUG_ON() inside
 get_arm64_ftr_reg()
Message-ID: <20200520114941.GB18302@gaia>
References: <1589937774-20479-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589937774-20479-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:52:54AM +0530, Anshuman Khandual wrote:
> There is no way to proceed when requested register could not be searched in
> arm64_ftr_reg[]. Requesting for a non present register would be an error as
> well. Hence lets just BUG_ON() when the search fails in get_arm64_ftr_reg()
> rather than checking for return value and doing the same in some individual
> callers.
> 
> But there are some callers that dont BUG_ON() upon search failure. It adds
> an argument 'failsafe' that provides required switch between callers based
> on whether they could proceed or not.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

BTW, there should be no empty line between the Cc block and the SoB.

The patch looks fine. Just a note that the patch transforms a current
WARN_ON in a BUG_ON but that's fine by me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
