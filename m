Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0447D1DB0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 13:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETK74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 06:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETK7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:59:55 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C77C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:59:54 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49RqX93lSgz9sT6; Wed, 20 May 2020 20:59:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>, erhard_f@mailbox.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2c50f3b1c9bbaa4217c9a98f3044bd2a36c46a4f.1586361277.git.christophe.leroy@c-s.fr>
References: <2c50f3b1c9bbaa4217c9a98f3044bd2a36c46a4f.1586361277.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/kasan: Fix stack overflow by increasing THREAD_SHIFT
Message-Id: <158997212859.943180.2820921951061590486.b4-ty@ellerman.id.au>
Date:   Wed, 20 May 2020 20:59:53 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 15:58:49 +0000 (UTC), Christophe Leroy wrote:
> When CONFIG_KASAN is selected, the stack usage is increased.
> 
> In the same way as x86 and arm64 architectures, increase
> THREAD_SHIFT when CONFIG_KASAN is selected.

Applied to powerpc/next.

[1/1] powerpc/kasan: Fix stack overflow by increasing THREAD_SHIFT
      https://git.kernel.org/powerpc/c/edbadaf0671072298e506074128b64e003c5812c

cheers
