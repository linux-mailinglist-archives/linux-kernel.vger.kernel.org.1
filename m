Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349C62D5957
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgLJLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389445AbgLJLa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:26 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF3CC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:29:45 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXQ5CDxz9sWf; Thu, 10 Dec 2020 22:29:42 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <39a530ee41d83f49747ab3af8e39c056450b9b4d.1602489653.git.christophe.leroy@csgroup.eu>
References: <39a530ee41d83f49747ab3af8e39c056450b9b4d.1602489653.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/feature: Add CPU_FTR_NOEXECUTE to G2_LE
Message-Id: <160756607029.1313423.4029286967614030940.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:42 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 08:02:13 +0000 (UTC), Christophe Leroy wrote:
> G2_LE has a 603 core, add CPU_FTR_NOEXECUTE.

Applied to powerpc/next.

[1/1] powerpc/feature: Add CPU_FTR_NOEXECUTE to G2_LE
      https://git.kernel.org/powerpc/c/197493af414ee22427be3343637ac290a791925a

cheers
