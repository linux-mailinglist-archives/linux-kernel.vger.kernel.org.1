Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4075223921
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 12:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 06:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQKTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:19:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7C22063A;
        Fri, 17 Jul 2020 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594981173;
        bh=UOSt48aO65gwAUB2x+iP6NI41YTkFaT/oMyZi4pbRB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEp4/wQwm+BYnpeOPkED1GCD0Sd/uO+toFmvPdeSJf8s5AWO8N1KRseke5NzbCeYF
         UcE9OPw5ZFJH58C+E6CLZm/sZeAVtjw12atWQmsuRac0fPwJO7554jIl9Um59VDGGD
         1rCI7nGtpriu6D8/SGqPKGUH+wEv65DgRMjRCKUg=
Date:   Fri, 17 Jul 2020 11:19:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] arm64: Make TSK_STACK_CANARY more accurate defined
Message-ID: <20200717101929.GA8727@willie-the-truck>
References: <1594613013-13059-1-git-send-email-guoren@kernel.org>
 <20200714083715.GE4516@willie-the-truck>
 <CAJF2gTRVHs82gwctTt7ZEvgDKrrSBw_GLjJLDqa9zLY+qNywWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRVHs82gwctTt7ZEvgDKrrSBw_GLjJLDqa9zLY+qNywWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:56:23AM +0800, Guo Ren wrote:
> BTW, Jim found a GCC security leak in arm64, and would you want to
> have a look at it?

Thanks. This seems to be tracked in their bugzilla here:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96191

I agree with Jim that this should be fixed.

Will
