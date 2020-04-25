Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF01B84A2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDYI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:26:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7CDC09B049
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 01:26:17 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jSG8T-00G7g6-5s; Sat, 25 Apr 2020 10:26:05 +0200
Message-ID: <b86f5469f9b888942b7a6f9862ec98c909121375.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix "time-internal.h" include in xor.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 25 Apr 2020 10:26:04 +0200
In-Reply-To: <20200425042814.132920-1-davidgow@google.com>
References: <20200425042814.132920-1-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-24 at 21:28 -0700, David Gow wrote:
> It looks like the wrong header was included in xor.h, breaking make
> allyesconfig on UML (or, more specifically, kunit.py run --alltests).
> 
> ----------------------
> In file included from crypto/xor.c:17:
> ./arch/um/include/asm/xor.h:3:10: fatal error: shared/timer-internal.h: No such file or directory
>     3 | #include <shared/timer-internal.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> ----------------------
> 
> Replacing this with "linux/time-internal.h" builds fine.
> 
> Fixes: d65197ad5249 ("um: fix time-travel=inf-cpu with xor/raid6")

Yeah, sorry about that. Some patches overlapped here, i.e. were pending
from separate branches I had.

I sent Richard a fix quite about three weeks ago:

https://patchwork.ozlabs.org/project/linux-um/patch/20200405213357.b6ce1024b276.I7c370e20580d3122c58df5727ee2d6fb53545576@changeid/

but I guess he hasn't applied it yet.

johannes

