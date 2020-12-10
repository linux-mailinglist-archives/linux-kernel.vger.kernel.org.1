Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C62D5947
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbgLJLbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389511AbgLJLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:52 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5483FC061285
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:30:34 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBYH5WwXz9shq; Thu, 10 Dec 2020 22:30:27 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Youling Tang <tangyouling@loongson.cn>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1606460857-2723-1-git-send-email-tangyouling@loongson.cn>
References: <1606460857-2723-1-git-send-email-tangyouling@loongson.cn>
Subject: Re: [PATCH] powerpc: Use common STABS_DEBUG and DWARF_DEBUG and ELF_DETAILS macro
Message-Id: <160756605971.1313423.7998345002974297044.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:30:27 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 15:07:37 +0800, Youling Tang wrote:
> Use the common STABS_DEBUG and DWARF_DEBUG and ELF_DETAILS macro rule for
> the linker script in an effort.

Applied to powerpc/next.

[1/1] powerpc: Use common STABS_DEBUG and DWARF_DEBUG and ELF_DETAILS macro
      https://git.kernel.org/powerpc/c/a21df7a1d6ca9bd387a17841863a99431c4aa730

cheers
