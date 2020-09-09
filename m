Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F142631DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgIIQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A05AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:41 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVs2XLBz9sVR; Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <fbe58d27cf128d5fe581e4510ded8701858f268e.1596716328.git.christophe.leroy@csgroup.eu>
References: <fbe58d27cf128d5fe581e4510ded8701858f268e.1596716328.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/hwirq: Remove stale forward irq_chip declaration
Message-Id: <159965716610.808686.6255095510129044770.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 12:19:06 +0000 (UTC), Christophe Leroy wrote:
> Since commit identified below, the forward declaration of
> struct irq_chip is useless (was struct hw_interrupt_type at that time)
> 
> Remove it, together with the associated comment.

Applied to powerpc/next.

[1/1] powerpc/hwirq: Remove stale forward irq_chip declaration
      https://git.kernel.org/powerpc/c/169b9afee572853522901b7cbf34842c0494a887

cheers
