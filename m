Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58D2D30EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgLHRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgLHRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:24:12 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73209C061749;
        Tue,  8 Dec 2020 09:23:32 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 28003300;
        Tue,  8 Dec 2020 17:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 28003300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607448212; bh=6noqackd9jly2jr8MVHKDLefh3lAUeOcwzrsMdVHg4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T3rhp7rrpN1+yEyU+vXPlmrcqMu9ftUEzrN2j/3mPky0j4AOhLUP9pD/LQaFdr/Xq
         OKm5hdNWd4MdeK0iyxM1qOpcn3GhFi3x1jrOxcuZkeT2L7iODIcmYTTHx0RDom9+qi
         qmYnibQiNqXm7M66Vz2aV10NlFodg3D4UIeXO853n7aGPuZQvHk+YFpb2N/cGO1jgi
         +nLF0Rt51vIUIdHv2e0srtAd8XGM9oZ4EMhr0vCVAYVDKN4Bnw0SfHJW30XOjM9Xkv
         b7jgV96sjgopGsrQMTttm2gZkMtpFVe4Ic4CV88srVo7AS02TYYELOClQaRVYqwVwS
         3/Em/jwrh5gfQ==
Date:   Tue, 8 Dec 2020 10:23:31 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Fix example in Nested structs/unions
Message-ID: <20201208102331.5ccaf8ab@lwn.net>
In-Reply-To: <20201207210027.1049346-1-ben.widawsky@intel.com>
References: <20201207210027.1049346-1-ben.widawsky@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Dec 2020 13:00:27 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Add missing ';' as well as fixes the indent for the first struct.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/doc-guide/kernel-doc.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
