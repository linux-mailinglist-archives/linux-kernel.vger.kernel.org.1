Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F211C70DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEFMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 08:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgEFMxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:53:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2E22073A;
        Wed,  6 May 2020 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588769601;
        bh=GLqGiShNV7uuHX1J4JVdEeZ8Lm493f3dGVJYOjNFwFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecG4eBfuUCMEVv8mQ1OercE8djLhgASVwNICQvA98pjw2xky52wgWRWglzCHCz2+r
         R3UAk95i0uT52IkxlFoJan8cyKK6F3Rnge3TttIYTQ1Y4mAqbAwsXSa8DmbgWTYcIo
         a4uziYES9AHwqBmU2vcNSY6Eta7vOlPn5ecrl5oU=
Date:   Wed, 6 May 2020 13:53:16 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?77+91rXvv73vv73vv70vRE9OR0hZRU9L?= CHOE 
        <d7271.choe@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hosung0.kim@samsung.com, changki.kim@samsung.com,
        hajun.sung@samsung.com, gregkh@google.com, youngmin.nam@samsung.com
Subject: Re: Reqeust export symbol for API in arch/arm64/*
Message-ID: <20200506125315.GH8043@willie-the-truck>
References: <CGME20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae@epcas2p2.samsung.com>
 <00bc01d623a4$669d1e70$33d75b50$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00bc01d623a4$669d1e70$33d75b50$@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 09:46:45PM +0900, �ֵ���/DONGHYEOK CHOE wrote:
> I am software engineer in charge of BSP (Samsung SOC vendor).
> 
> Recently, Google introduced GKI from Android R version.
> We cannot use mainline API without 'export symbol' by the GKI policy.
> But we want to make an arm64 specific vendor driver in {kernel source
> root}/drivers/soc/samsung/*.
> 
> Could you support us to use the below APIs?

Sorry, but as a general rule of thumb the kernel doesn't EXPORT symbols
that are not used by in-tree modules. You'll need to submit your drivers
along with the patches doing the exports if they are to be considered
for inclusion.

Thanks,

Will
