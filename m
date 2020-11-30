Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA662C8B64
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgK3Rin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:38:43 -0500
Received: from ms.lwn.net ([45.79.88.28]:54598 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgK3Rim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:38:42 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B1F2B2BA;
        Mon, 30 Nov 2020 17:38:01 +0000 (UTC)
Date:   Mon, 30 Nov 2020 10:38:00 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bailu Lin <bailu.lin@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] Documentation: Chinese translation of 
 Documentation/arm64/elf_hwcaps.rst
Message-ID: <20201130103800.7175bb67@lwn.net>
In-Reply-To: <20201124023846.34826-1-bailu.lin@vivo.com>
References: <20201124023846.34826-1-bailu.lin@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 18:38:14 -0800
Bailu Lin <bailu.lin@vivo.com> wrote:

> This is a Chinese translated version of
>  Documentation/arm64/elf_hwcaps.rst
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
> Changes in v2:
>  - Modify five translation issues as Alex sugguested.
> ---
>  Documentation/arm64/elf_hwcaps.rst            |   2 +
>  .../translations/zh_CN/arm64/elf_hwcaps.rst   | 240 ++++++++++++++++++
>  .../translations/zh_CN/arm64/index.rst        |   1 +
>  3 files changed, 243 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/elf_hwcaps.rst

Applied, thanks.

jon
