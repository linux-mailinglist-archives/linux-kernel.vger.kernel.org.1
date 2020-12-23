Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942432E1D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgLWORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgLWORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:17:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA2EF2313C;
        Wed, 23 Dec 2020 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608733018;
        bh=RwCy8pDqkaon2dDX9Ueh49ftnCXgnKlF0QO43K1UM+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+x9p3G+wxKN9Ew6sk9FKlVewyqE4EIjevahRnFFfKH3J9ree4cMxHAuA+2p80tOw
         mMzjeONl6DpmhZJJAsmKLN1N2k8hzCESTT7Ud7s5Lte7YuYQYN9BlXCYxVp5tS2otP
         /oh2dX/PNvVeES4tQMiMm41w9LyMOb+X91vvdzso=
Date:   Wed, 23 Dec 2020 15:18:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     nsaenzjulienne@suse.de, bcm-kernel-feedback-list@broadcom.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: vc04_services: use DEFINE_MUTEX (and
 mutex_init() had been too late)
Message-ID: <X+NRoV/13beGil4q@kroah.com>
References: <20201223141129.32401-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223141129.32401-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:11:29PM +0800, Zheng Yongjun wrote:
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_connected.c        | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I can not take patches without any changelog text :(
