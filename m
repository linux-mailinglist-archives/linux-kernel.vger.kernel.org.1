Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813521A3465
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDIMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 08:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgDIMxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:53:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DCA2078E;
        Thu,  9 Apr 2020 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586436785;
        bh=Kk1SW3weqdz4tmBHA5UhYBHVxFwphct/t4b5tGbPZms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plUHnHQ3DZTmwFicvlj+/ZUHcc/JJKaTER7h0q1lrZfzH8M8hXI4jqM2gx+UHAFwE
         4sTt1RMsjYezWLsw3Ozs992kSNzE1YN/3BJ1lZTQ/3D6NURIdvH+diuQ9oaQ5a2p2M
         N4YiLbY+T15eZQfyFnwwLedPk9yyGN6IKUS9N+YQ=
Date:   Thu, 9 Apr 2020 13:53:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64/cpufeature: Drop TraceFilt feature exposure
 from ID_DFR0 register
Message-ID: <20200409125255.GA13078@willie-the-truck>
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-6-git-send-email-anshuman.khandual@arm.com>
 <bb4d5175-1c72-a1a6-1e79-116991717fdf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4d5175-1c72-a1a6-1e79-116991717fdf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:19:21PM +0000, Suzuki K Poulose wrote:
> On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
> > ID_DFR0 based TraceFilt feature should not be exposed.
> 
> ... to guests.
> 
>  Hence lets drop it.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Hmm, doesn't dropping cause it to become NONSTRICT? In general, I'd prefer
that we list all fields in these tables, rather than have implicit behaviour
in their absence.

Will
