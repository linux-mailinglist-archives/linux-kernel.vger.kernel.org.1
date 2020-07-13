Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1149421CE09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 06:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGMENR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 00:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMENQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:13:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC502070B;
        Mon, 13 Jul 2020 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613596;
        bh=sjIr7qNn8Hd9iJBnNiQpe4AvTa3VFSgoqkSuFvHUPWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGDzSoUXOoGe9dfOFkAifGVOW2YyxolW8dy9oeG1NiJkt6bEXeV6p+U2Nl55eC1Wg
         s6nzseWUajiviLsci4x8KVHqtVwEOJbewGg5ah7YJC0sC0DCCdNZdaYFEX+1IMW9Dk
         VE5WPD/I6ER8DWYADGDuxtVdn5zBzqkKehz0qoDw=
Date:   Mon, 13 Jul 2020 12:13:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: enable RTC and audio support on
 Kontron sl28 boards
Message-ID: <20200713041311.GD12113@dragon>
References: <20200703221143.31839-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703221143.31839-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 12:11:43AM +0200, Michael Walle wrote:
> Although the Kontron SMARC-sAL28 board is now supported, there is still
> missing driver support for the hardware clock, audio interface and audio
> codec. Let's enable them as modules (where possible).
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
