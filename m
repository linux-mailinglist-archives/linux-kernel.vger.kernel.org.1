Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD5295BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896018AbgJVJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896011AbgJVJet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:34:49 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E36F223BF;
        Thu, 22 Oct 2020 09:34:47 +0000 (UTC)
Date:   Thu, 22 Oct 2020 10:34:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rui.xiang@huawei.com,
        weiyongjun1@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH] Kconfig: Move CONFIG_DEBUG_KMEMLEAK_TEST to
 samples/Kconfig
Message-ID: <20201022093445.GC1229@gaia>
References: <20201022021234.6638-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022021234.6638-1-chenjun102@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 02:12:34AM +0000, Chen Jun wrote:
> From: Chen Jun <c00424029@huawei.com>
> 
> commit 1abbef4f51724fb11f09adf0e75275f7cb422a8a
> ("mm,kmemleak-test.c: move kmemleak-test.c to samples dir")
> make CONFIG_DEBUG_KMEMLEAK_TEST depend on CONFIG_SAMPLES implicitly.
> And the dependency cannot be guaranteed by Kconfig.
> 
> move the definition of CONFIG_DEBUG_KMEMLEAK_TEST from lib/Kconfig.debug
> to samples/Kconfig.
> 
> Signed-off-by: Chen Jun <c00424029@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
