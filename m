Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C02DAB68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgLOKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgLOKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:39 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E3C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:48:59 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP51pD9z9sRR; Tue, 15 Dec 2020 21:48:56 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c10b263668e137236c71d76648b03cf2cd1ee66f.1607076733.git.christophe.leroy@csgroup.eu>
References: <c10b263668e137236c71d76648b03cf2cd1ee66f.1607076733.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/process: Remove target specific __set_dabr()
Message-Id: <160802920801.504444.13663524234718108662.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:56 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 10:12:51 +0000 (UTC), Christophe Leroy wrote:
> __set_dabr() are simple functions that can be inline directly
> inside set_dabr() and using IS_ENABLED() instead of #ifdef

Applied to powerpc/next.

[1/1] powerpc/process: Remove target specific __set_dabr()
      https://git.kernel.org/powerpc/c/ad3ed15cd04b96de7c38204ba7c698cbccd8fe88

cheers
