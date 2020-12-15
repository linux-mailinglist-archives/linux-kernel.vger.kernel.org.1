Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334DA2DAB75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgLOKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLOKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:38 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:48:57 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP35MqDz9sTL; Tue, 15 Dec 2020 21:48:55 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b2f71f39eca543f1e4ec06596f09a8b12235c701.1607076683.git.christophe.leroy@csgroup.eu>
References: <b2f71f39eca543f1e4ec06596f09a8b12235c701.1607076683.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Fix early debug when SMC1 is relocated
Message-Id: <160802920774.504444.8233931629187109687.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:55 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 10:11:34 +0000 (UTC), Christophe Leroy wrote:
> When SMC1 is relocated and early debug is selected, the
> board hangs is ppc_md.setup_arch(). This is because ones
> the microcode has been loaded and SMC1 relocated, early
> debug writes in the weed.
> 
> To allow smooth continuation, the SMC1 parameter RAM set up
> by the bootloader have to be copied into the new location.

Applied to powerpc/next.

[1/1] powerpc/8xx: Fix early debug when SMC1 is relocated
      https://git.kernel.org/powerpc/c/1e78f723d6a52966bfe3804209dbf404fdc9d3bb

cheers
