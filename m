Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A869E2E0A74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgLVNMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbgLVNMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:12:08 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E183C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:11:28 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4D0cDC566zz9sWX; Wed, 23 Dec 2020 00:11:23 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu>
References: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix RTAS machine check with VMAP stack
Message-Id: <160864266272.1929899.11524659820203744470.b4-ty@ellerman.id.au>
Date:   Wed, 23 Dec 2020 00:11:23 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 07:11:18 +0000 (UTC), Christophe Leroy wrote:
> When we have VMAP stack, exception prolog 1 sets r1, not r11.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix RTAS machine check with VMAP stack
      https://git.kernel.org/powerpc/c/9c7422b92cb27369653c371ad9c44a502e5eea8f

cheers
