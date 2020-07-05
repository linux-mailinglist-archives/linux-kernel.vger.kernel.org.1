Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF638214F53
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 22:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGEUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgGEUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:32:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8DC061794;
        Sun,  5 Jul 2020 13:32:14 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EC414739;
        Sun,  5 Jul 2020 20:32:13 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:32:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fix incorrent references to DMA APIs
Message-ID: <20200705143212.446c50f3@lwn.net>
In-Reply-To: <20200628143017.17399-1-dust.li@linux.alibaba.com>
References: <20200628143017.17399-1-dust.li@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 22:30:17 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> dma-api
> dma-api-howto
> dma-attributes
> dma-isa-lpc
> 
> The above 4 documents have been renamed and moved to
> Documentation/core-api/, but there are still some old references
> refer to the old files, this patch tries to correct them.
> 
> Fixes: 728c1471b544 ("docs: move DMA kAPI to Documentation/core-api")
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

Thanks, but these have already been addressed in the docs tree.

jon
