Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACC2DAB67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgLOKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgLOKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:42 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF62C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:49:01 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP73mT6z9sS8; Tue, 15 Dec 2020 21:48:59 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        giuseppe@sguazz.it, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e3e0d8042a3ba75cb4a9546c19c408b5b5b28994.1607404931.git.christophe.leroy@csgroup.eu>
References: <e3e0d8042a3ba75cb4a9546c19c408b5b5b28994.1607404931.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/powermac: Fix low_sleep_handler with CONFIG_VMAP_STACK
Message-Id: <160802920697.504444.16573519537431837820.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:59 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 05:24:19 +0000 (UTC), Christophe Leroy wrote:
> low_sleep_handler() can't restore the context from standard
> stack because the stack can hardly be accessed with MMU OFF.
> 
> Store everything in a global storage area instead of storing
> a pointer to the stack in that global storage area.
> 
> To avoid a complete churn of the function, still use r1 as
> the pointer to the storage area during restore.

Applied to powerpc/next.

[1/1] powerpc/powermac: Fix low_sleep_handler with CONFIG_VMAP_STACK
      https://git.kernel.org/powerpc/c/db972a3787d12b1ce9ba7a31ec376d8a79e04c47

cheers
