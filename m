Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0282B1B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMMop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgKMMop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:44:45 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DC920797;
        Fri, 13 Nov 2020 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605271485;
        bh=71vyXhvdQDIzP2+xax8cCSFLana8q4zON8WGxo2Yx54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2drqydKB+bWHi9Mk+8QfsZIb0K0UELTn9r1f15MWcdPpCyLuNrhAqMCU2dNqKmHu0
         HDRNaGbWyy361DNMP1oH5kGtxan1d9vbseDWTHlSg19kvHHTZhDIVyv23HAlpvISlU
         DQ8tU1kUJyZUGNzpAeQjZklQ/0ld2yXByxzEZgME=
Date:   Fri, 13 Nov 2020 12:44:40 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        peterz@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20201113124440.GB22014@willie-the-truck>
References: <20201113123934.GA22014@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113123934.GA22014@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:39:34PM +0000, Will Deacon wrote:
> Hi Linus,
> 
> Please can you pull these arm64 fixes for -rc4? It's all fairly simple
> and there's a summary in the tag; Paul has reviewed the trivial RCU change.
> 
> The main issue remaining at this stage is the ongoing irqtracing problem
> [1]. People are working on it, but no patches yet.

Looks like I managed to munge the subject for this (somehow dropped the
leading '['); I've fixed it here in the hope that it gets past whatever
filters you may have, but I'll resend if I haven't heard anything by
tomorrow afternoon.

Ta,

Will
