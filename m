Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7858D29146E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439159AbgJQVBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439116AbgJQVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 17:01:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FCC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:01:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602968476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ai1Uzc13uhocuU3eLVJfTQZIISzuUjnF1sAm2+jwNbs=;
        b=1n4kBKvDyAkXzhlgdivrmeADkSrpO2/j8er5fQsRX84ORcCx5+54kB0K+GAWajrNk0d3JX
        GjJ1HBdipBoZNcXsyN3nC7263D07fYHpK7E2gwVk/3rvKoCDcWINHZWC0Of3cy62e3vRP/
        S6Xm0vRQHOnamZoa7Ea4FjAAXQIZ4bTe+ID894w2bfvPJblG71HucLNVUf4NHYUemO3cIZ
        yhCFlDzBs1YblnYqDNPW0F8Lx/lwb4PmvkMCwFdL+nFWQoIURjy0kR2EmLJSesk38MZRVs
        Ipx/+JK0GkKG+QX8fQsnlBjRhW82p2VWpXXaaiPgb1DCau7rbefHoMpnYg20kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602968476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ai1Uzc13uhocuU3eLVJfTQZIISzuUjnF1sAm2+jwNbs=;
        b=d7DX20a/4JI52lYrBx4NJtyepJd0IJkj9hXJw4oCb+oy6UcE6w3CMvb9dia+C8hOe+L55e
        Q4rompygR21RfECg==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <ffd90972-d664-b024-f537-8d02f91d12d7@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk> <87tuutalre.fsf@nanos.tec.linutronix.de> <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk> <87zh4lix8l.fsf@nanos.tec.linutronix.de> <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk> <87wnzpivvx.fsf@nanos.tec.linutronix.de> <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk> <87tuusj2ch.fsf@nanos.tec.linutronix.de> <4a2f1a71-3548-1f13-23a4-2f7e73408cf3@kernel.dk> <87k0voip1w.fsf@nanos.tec.linutronix.de> <ffd90972-d664-b024-f537-8d02f91d12d7@kernel.dk>
Date:   Sat, 17 Oct 2020 23:01:15 +0200
Message-ID: <87h7qsin38.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

On Sat, Oct 17 2020 at 14:32, Jens Axboe wrote:
> On 10/17/20 2:18 PM, Thomas Gleixner wrote:
>
> Thanks! Fixed the two typos, and also included the guest mode. If you're fine
> with it now, would be great to have your reviewed-by or similar.

Sure. I assume you ship it to Linus, otherwise let me know and I'll pick
it up.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
