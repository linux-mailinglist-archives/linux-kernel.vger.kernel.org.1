Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B422DA191
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503341AbgLNUbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503334AbgLNUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:30:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:30:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyvnDUNbFYWmumoIKd0vV6gFzgLV5tEpBq/C0vCsK5E=;
        b=E6WmGYbA/3fdNRsYrCx4UNsVtwEWGZ2k7UiCS5CjCyU9BmR4Ums6RHo9S6z+b/+F+ypUhh
        ik/hZ8E0B6JZHziDjQ4bBcWt4wji3maPygNkKtbLwMdn2OadfxsyEh1vw/AyZyZzAGWzim
        rts6YI1IFGIGRTgcvbne5qdIBS2xd3fUiXmzfWqK5WuJDfmaTA7hBlsKYPoUhhbjwZu0p3
        z4SdfZ+NlvNdzipJZUSPo8HBKejgWanexJGeD0ZKz/+RrE8JEOFb81B5Dt8l9YQta07XX1
        VMahSfB8YsRFVJcA5hcbYjrd+C12VHMl8i95TKELjiTKGhUmgFnEXW4gfmx/FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyvnDUNbFYWmumoIKd0vV6gFzgLV5tEpBq/C0vCsK5E=;
        b=7lmSysuQ0IBG9UJyTdN/0X8ctAE1VHBrZvbfzQ9SuDMy+3NZtsVxtW7L/fxXvqf4meL8TO
        +aSNCz+cNFD52WAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] efi/core for v5.11-rc1
In-Reply-To: <160797733182.10793.8402797805442982544.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733182.10793.8402797805442982544.tglx@nanos>
Date:   Mon, 14 Dec 2020 21:30:08 +0100
Message-ID: <87o8iwdtbj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Mon, Dec 14 2020 at 20:22, Thomas Gleixner wrote:

> Linus,
>
> please pull the latest efi/core branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-12-14

please ignore this one. There is some last minute unclear issue with
this lot. Ard is working on an update.

Thanks,

        tglx
