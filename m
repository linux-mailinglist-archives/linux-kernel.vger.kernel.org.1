Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5252B1BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKMN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:28:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD2C0613D1;
        Fri, 13 Nov 2020 05:28:21 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:28:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605274099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXWiWkQSkMaH2+lNu6mt3jtJ0LZIwn7gxSqUVpMIUGM=;
        b=xFPZJeUg90c7ostUkheKJZF3LSpoO2jEGJuWPacDvgsketVmXMRcSQgV16LufDzB2SnfYO
        b8ghlObBsj8P1us+WiVhtRHr8feOcbV28k4bNdB96f3OuyO5+mUDMLLRD6fNrE1+sUISWV
        JnttxgB/bwxjLo/gNhcRghb2/lIEu+JRgl/AfkYk1G2EhWyVphsfwDVvlnuyswc8XSmbQm
        +x5zfh+E2UE9uD/FDQrG+tB82KHvl9wzU4zAVnJZKI+TmgtmvXHP8nmlH++83JuasWo6Gj
        hD8Lp+8hI3UH6t9M1KswXDb3k6QNw+aumDJJMlloVMOBJZEKIdO/cVRBELu0KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605274099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXWiWkQSkMaH2+lNu6mt3jtJ0LZIwn7gxSqUVpMIUGM=;
        b=0ADZiL2vlR5OZhWpc+E9jIBZv7ajQ/BWfNJWXBis872jhqDm1int5/I6FviQ1gEqOeU4f0
        g3Rump6jCpWoyaBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] kcov, usb: only collect coverage from
 __usb_hcd_giveback_urb in softirq
Message-ID: <20201113132818.zhtdhzg6ukv4wgxl@linutronix.de>
References: <f3a7a153f0719cb53ec385b16e912798bd3e4cf9.1602856358.git.andreyknvl@google.com>
 <20201113123035.tjllvijjzd54npsf@linutronix.de>
 <CAAeHK+zd0ucaj8EJ8ro+0ekubrxp5GiBMaBULHJB05dDrzpQGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAeHK+zd0ucaj8EJ8ro+0ekubrxp5GiBMaBULHJB05dDrzpQGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-13 13:51:19 [+0100], Andrey Konovalov wrote:
> Hi Sebastian,

Hi Andrey,

> Replaced with what and why?

Linus requested in
	https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com/

that drivers should not change their behaviour on context magic like
in_atomic(), in_interrupt() and so on.
The USB bits were posted in
	https://lkml.kernel.org/r/20201019100629.419020859@linutronix.de

and merged (which is probably the same time as this patch).

I haven't look what this code should do or does but there are HCDs for
which this is never true like the UHCI/OHCI controller for instance.

> Thanks!

Sebastian
