Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01EB2C3F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgKYL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:58:09 -0500
Received: from ozlabs.org ([203.11.71.1]:49073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgKYL6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:58:08 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsx31zPz9sVs; Wed, 25 Nov 2020 22:57:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Youling Tang <tangyouling@loongson.cn>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1604487550-20040-1-git-send-email-tangyouling@loongson.cn>
References: <1604487550-20040-1-git-send-email-tangyouling@loongson.cn>
Subject: Re: [PATCH] powerpc: Use the common INIT_DATA_SECTION macro in vmlinux.lds.S
Message-Id: <160630540225.2174375.6381548076973269685.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:57 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 18:59:10 +0800, Youling Tang wrote:
> Use the common INIT_DATA_SECTION rule for the linker script in an effort
> to regularize the linker script.

Applied to powerpc/next.

[1/1] powerpc: Use the common INIT_DATA_SECTION macro in vmlinux.lds.S
      https://git.kernel.org/powerpc/c/fdcfeaba38e5b183045f5b079af94f97658eabe6

cheers
