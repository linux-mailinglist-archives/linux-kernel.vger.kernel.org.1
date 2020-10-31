Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F552A1332
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 03:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJaC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 22:59:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46482 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaC7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 22:59:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604113190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uiNh5DlF5wTnHdgy+YpD+SqJcx0IkmhXz5iicz0GMY=;
        b=u0jS/W4ZA0MqKNeekd3D42zHuUiEpyDVvJspZyugAuvhh63dfnvs/vfX9pPy1beb4YCzMy
        /WWAQ6i3/9/5WU2PS6Doytd0MepaZ3ki+FxWHswwltaxoq9t7szlpKsGST0sjTsUk+md87
        1sCbXKnPkGae8SFeu78b7bJ9EfsUgzQXJUMBPYCBrGBqdBgCHI1e/QRuSlJxgu1cUSaobx
        exoBAYAyyg9jFbivuamQ7UAhPirRTK2BjObG6eOkyNRAxzHyWypUiWjrwalAbLK50nlKzt
        rmeAohrYTvriLTE4b1p+fzNZsWSp92P3EjZOGk9ta7iCjlc7QFvF0STjCFLfyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604113190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uiNh5DlF5wTnHdgy+YpD+SqJcx0IkmhXz5iicz0GMY=;
        b=sXLfoSJJWt0ILL0GgqzWEDIpCFjn9zuGoLx5jMOiMu1MtButFb/A3+GqydCSWzn0jsg0JO
        aw2KUI0cnUsxAUDA==
To:     Dongjiu Geng <gengdongjiu@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
Subject: Re: Using fixed LPI number for some Device ID
In-Reply-To: <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
References: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com> <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
Date:   Sat, 31 Oct 2020 03:59:50 +0100
Message-ID: <87eelfksm1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31 2020 at 10:19, Dongjiu Geng wrote:
>  Hi Marc,
>     Sorry to disturb you, Currently the LPI number is not fixed for
>  the device. The LPI number is dynamically allocated start from 8092.
>  For two OS which shares the ITS, One OS needs to configure the device
>  interrupt required by another OS, and the other OS uses a fixed
>  interrupt ID to respond the interrupt. Therefore, the LPI IRQ number
>  of the device needed be fixed. I want to upstream this feature that
>  allocate fixed LPI number for the device that is specified through
>  the DTS. What is your meaning?  Thanks

What's the purpose of resending the same thing within less than 24
hours? Do you really expect maintainers to be available 24/7 and being
able to respond within less than a day?


