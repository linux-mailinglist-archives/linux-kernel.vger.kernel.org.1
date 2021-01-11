Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE23B2F10A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbhAKK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbhAKK5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:57:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E99432222D;
        Mon, 11 Jan 2021 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610362601;
        bh=UabdiQgMnRelLbDNYfsejOMhiMqoAHCDXremH9CD1Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwiq6ikbvb/3TrG/Np1zrlibqef889hpY37+VDi8Dg5mLvFJufff2+vJlCgAcdHCk
         jOnjGzDYRivZst9s3LtX0Ba4IaN0UBe+uSpkfCHnZsZJ1EKo//7MiR2w85n5ZjkUiT
         on9N4oMvMh1Tx5pTmp1m1GKcFLiWCpzJil2GuqPLHopOLzFi38QA5fwXDtBsHljAAI
         cBtN+CJfruF4QdeF52cgsjGmA3ebc9PsEiqVkOfF+QXGOXO2DSfD44pF6c6j1A0FH1
         E+sHQSx+7IA95KOdnXHzraOzQJl3d8Cle3hrNf0AFwAMguqyH1Yd97ereqWSuCNMKL
         uqGOtCBp+4Adw==
Date:   Mon, 11 Jan 2021 10:56:36 +0000
From:   Will Deacon <will@kernel.org>
To:     vanshikonda@os.amperecomputing.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, patches@amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Message-ID: <20210111105636.GA7071@willie-the-truck>
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> 
> Increase the default value of NR_CPUS to 512 from 256. This will
> enable the defconfig kernel to support platforms that have upto
> 512 cores.

Do we already support such a platform, and what is it? I'm fine with bumping
the number, it's just nice to be able to say specifically _why_ we're dong
it.

Thanks,

Will
