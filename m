Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CFB2CD06C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbgLCH3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgLCH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:29:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389CDC061A4F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=T6h320uJxACQFW4BX2n5jJxDf1GK3qi420zD9MAfA5M=; b=QOrRo4a3yhumIojieyeC1iwfzP
        HLojEmSPVW1vXYSlrE4qHQq9cH0bSRY+5ibUmX4w83z15JJeHGHhtLwMWXshROdoh7gIk8+INWpqs
        p46SUup4x55yLq4ZZNAIZ1LZHWYLYhcjxzupo3gIyZqTsGLCPtoG6nvnfEAIILrDTex0DWRiH4kEU
        STmLAMBeN4xYuyaym3vSbw7nlZdPNdweC1Br+Vm1mTk5+9zYYNLNqAY1OL1FSNLdChfWA+UWt5QUz
        Qe6Hbh1cXJsmWrUObsTT4d2+eJ59hPpx7lLKX0dK4D1ozjImqxNqntnVyk2pEzMlvVFe2xfBfYcMt
        LeA2Qksw==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkj32-0004Im-NB; Thu, 03 Dec 2020 07:29:05 +0000
Subject: Re: [PATCH] (fixed after review) Documentation: fix typos found in
 admin-guide subdirectory
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
References: <20201203072247.GA41394@spblnx124.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5951ef35-9507-5108-071f-45eeb92e42d8@infradead.org>
Date:   Wed, 2 Dec 2020 23:28:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203072247.GA41394@spblnx124.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 11:22 PM, Andrew Klychkov wrote:
> Fixed twelve typos in cppc_sysfs.rst, binderfs.rst, paride.rst,
> zram.rst, bug-hunting.rst, introduction.rst, usage.rst, dm-crypt.rst
> 
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/admin-guide/acpi/cppc_sysfs.rst        | 4 ++--
>  Documentation/admin-guide/binderfs.rst               | 2 +-
>  Documentation/admin-guide/blockdev/paride.rst        | 2 +-
>  Documentation/admin-guide/blockdev/zram.rst          | 2 +-
>  Documentation/admin-guide/bug-hunting.rst            | 2 +-
>  Documentation/admin-guide/cifs/introduction.rst      | 2 +-
>  Documentation/admin-guide/cifs/usage.rst             | 6 +++---
>  Documentation/admin-guide/device-mapper/dm-crypt.rst | 4 ++--
>  8 files changed, 12 insertions(+), 12 deletions(-)
> 

(as previously:)
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
