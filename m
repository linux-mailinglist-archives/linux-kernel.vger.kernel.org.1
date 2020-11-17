Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E582B57AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKQDHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKQDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:07:36 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F38C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:07:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CZrTd0nsVz9sSs;
        Tue, 17 Nov 2020 14:07:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1605582453;
        bh=R5WCF4I49UY8wfGLb6M2fPkbB9GljRtb7YtY1xSQRFE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P4oIDwMK/anM/QTrDNLaU3orPQ2ggHQolEh9D6w7S2BXMz4iv2lthO1lKtuFl1DwC
         DBV7nRa8PofxPQ3ciO6PIuf4T8hXA1oASrQU6AswYNGHNK1+IO9p04qeNenyHnlXOe
         +oTKZD3qfMUF9gxO7PIxN9Zn22L33TYKWYH4dCwvowtJBP2h/anWjkdSwgasbXX9rG
         gIPUbfUVOKjosnlNYUf9cUBk74+2k8pBahYde3EZhTGcQt/0VgpJMcPQVWnnw44nCL
         Jbp+nrT0BK3Sjd7V/188EFcjLklRBMaJO3gZEqn5TxBWe8kKCzx4p8Krv2NCuvY6Fk
         mhVJg6EIS978Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Donnellan <ajd@linux.ibm.com>, xiakaixu1987@gmail.com,
        fbarrat@linux.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] powerpc/powernv/sriov: fix unsigned int win compared to less than zero
In-Reply-To: <40b8ba6f-4916-55c2-a1f0-b7daa3c2e201@linux.ibm.com>
References: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com> <40b8ba6f-4916-55c2-a1f0-b7daa3c2e201@linux.ibm.com>
Date:   Tue, 17 Nov 2020 14:07:29 +1100
Message-ID: <87zh3g3clq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Donnellan <ajd@linux.ibm.com> writes:

> On 10/11/20 10:19 pm, xiakaixu1987@gmail.com wrote:
>> From: Kaixu Xia <kaixuxia@tencent.com>
>> 
>> Fix coccicheck warning:
>> 
>> ./arch/powerpc/platforms/powernv/pci-sriov.c:443:7-10: WARNING: Unsigned expression compared with zero: win < 0
>> ./arch/powerpc/platforms/powernv/pci-sriov.c:462:7-10: WARNING: Unsigned expression compared with zero: win < 0
>> 
>> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
>> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
>
> This seems like the right fix, the value assigned to win can indeed be 
> -1 so it should be signed. Thanks for sending the patch.
>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

I'll add:

  Fixes: 39efc03e3ee8 ("powerpc/powernv/sriov: Move M64 BAR allocation into a helper")

Which I think is the culprit as it changed:

  if (win >= phb->ioda.m64_bar_idx + 1)

to:

  if (win < 0)


cheers
