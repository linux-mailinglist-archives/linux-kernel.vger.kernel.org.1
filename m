Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A033E2C8B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgK3Rg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbgK3Rg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:36:26 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABECCC0613CF;
        Mon, 30 Nov 2020 09:35:46 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6336C2BA;
        Mon, 30 Nov 2020 17:35:46 +0000 (UTC)
Date:   Mon, 30 Nov 2020 10:35:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2] Documentation/admin-guide: mark memmap parameter is
 supported by a few architectures
Message-ID: <20201130103545.3fde4e8f@lwn.net>
In-Reply-To: <20201128195121.2556-1-song.bao.hua@hisilicon.com>
References: <20201128195121.2556-1-song.bao.hua@hisilicon.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Nov 2020 08:51:21 +1300
Barry Song <song.bao.hua@hisilicon.com> wrote:

> early_param memmap is only implemented on X86, MIPS and XTENSA. To avoid
> wasting users’ time on trying this on platform like ARM, mark it clearly.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  -v2:
>  * add reviewed-by of Mike, thanks!
> 
>  Documentation/admin-guide/kernel-parameters.rst | 1 +
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

jon
