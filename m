Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AEC2AA44F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgKGJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:53:10 -0500
Received: from depni-mx.sinp.msu.ru ([213.131.7.21]:25 "EHLO
        depni-mx.sinp.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgKGJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:53:09 -0500
Received: from spider (unknown [176.192.246.239])
        by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 94F821BF408;
        Sat,  7 Nov 2020 12:53:10 +0300 (MSK)
From:   Serge Belyshev <belyshev@depni.sinp.msu.ru>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        schwab@linux-m68k.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Use relocation offset when setting early
 hash table
References: <9e225a856a8b22e0e77587ee22ab7a2f5bca8753.1604740029.git.christophe.leroy@csgroup.eu>
Date:   Sat, 07 Nov 2020 12:53:04 +0300
In-Reply-To: <9e225a856a8b22e0e77587ee22ab7a2f5bca8753.1604740029.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Sat, 7 Nov 2020 09:07:40 +0000 (UTC)")
Message-ID: <87blg9lchr.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> When calling early_hash_table(), the kernel hasn't been yet
> relocated to its linking address, so data must be addressed
> with relocation offset.
>
> Add relocation offset to write into Hash in early_hash_table().
>
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Fixes: 69a1593abdbc ("powerpc/32s: Setup the early hash table at all time.")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Tested-by: Serge Belyshev <belyshev@depni.sinp.msu.ru>
