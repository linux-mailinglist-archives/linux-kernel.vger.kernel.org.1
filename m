Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08ED2F6224
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbhANNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhANNiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:38:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A95E8239A1;
        Thu, 14 Jan 2021 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610631493;
        bh=PAPG/ACHTK0jyjwAkvoqv3tucAP+biSsW8x7yvJWzXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwleQ0BOOtr3D+pagKU8JoMXRuhjwvxnj4DUT2eENhwsgFsmD1qGbb2kiX9crRxB5
         b3Ei3K5PMTsjU22qnP33ExDbQPIwaPmK5rpe5vTybXuom4KH7LpAtMcvebDw//3JfW
         JrW+Qf2WkoBp3UIRNZSdwXh0ksWKuA8fHR9wKCu5MzckPVydaDPm/KpCoj+TBz+1Z7
         ypm6jHv7jD/jTSpwN/V6CDjNWTRW2H/vCWH8vDCem9kZA1/t09eHAcm7PzBHiQ/GZS
         owEuJV2dGqOTcV4+5pkbTBWYdlrT9r9gAreCvS/1hHB0beioHtXNU10DXiQaXSO4XR
         yAz5i5vMzSVgQ==
Date:   Thu, 14 Jan 2021 15:38:07 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Daeseok Youn <daeseok.youn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: remove return value of memblock_free_all()
Message-ID: <20210114133807.GK1106298@kernel.org>
References: <20210114070817.GA2868715@AD01715016>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114070817.GA2868715@AD01715016>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:08:17PM +0900, Daeseok Youn wrote:
> No one checks the return value of memblock_free_all().
> Make the return value void.
> 
> memblock_free_all() is used on mem_init() for each
> architecture, and the total count of freed pages will be added
> to _totalram_pages variable by calling totalram_pages_add().
> 
> so do not need to return total count of freed pages.
> 
> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>

Applied to memblock/for-next, thanks!

-- 
Sincerely yours,
Mike.
