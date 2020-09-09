Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C02631E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgIIQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11DC061796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:41 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVt10gLz9sTN; Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e0bcdabac45fcd26c02d7df273bd4a5827c6033d.1596716375.git.christophe.leroy@csgroup.eu>
References: <e0bcdabac45fcd26c02d7df273bd4a5827c6033d.1596716375.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/irq: Drop forward declaration of struct irqaction
Message-Id: <159965716629.808686.18358177011917781182.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 12:19:46 +0000 (UTC), Christophe Leroy wrote:
> Since the commit identified below, the forward declaration of
> struct irqaction is useless. Drop it.

Applied to powerpc/next.

[1/1] powerpc/irq: Drop forward declaration of struct irqaction
      https://git.kernel.org/powerpc/c/b134cfc3e3276ccd5d29e39de5c848a45b08e410

cheers
