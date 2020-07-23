Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCD022B7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGWUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:25:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E89C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:25:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595535936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRKsEiuRR9b7sHUbNHNtlUD00w5JDjNSexa3ryoeXck=;
        b=ub1tRD5yoP2FHkXh4E0iQ5WFJwTiQeyO273NyYHrT9tQWS6SC3NArRMTQnf5WcbciMq1i5
        Hy6DaiyjcTVMhpir1Aev9FVxgdq0KT+AgIj4zUue4NyeF8ld3zErJNLFStUX+5E33ZPfMB
        twkOzIrM1NH41oTltp55hnHWN8c0sBXFY5Q+s6XvNR7ybfIM6tVJdiMY2Gs8pvda44JftW
        Bq+duVsp7gFYTb8QEbboeS3kf4o/sari6VhcW7S83rv0hrkke8qSBaBrF5G1XfOGCFunCt
        g7mfteZLIpD1cg7qXdWj1u/km6qy5mQhZO3vAMrHSKHQXNHncu36M3GkVJ4zdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595535936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRKsEiuRR9b7sHUbNHNtlUD00w5JDjNSexa3ryoeXck=;
        b=eGKPe7xkhI+ef15OnF4zSaPkyRFwBiM4xb31TGpuJ7QZpBjskM/VtiTjsP8Zbt1yBLRxWV
        T6aFNDhCWZ6MdMBA==
To:     Andrei Vagin <avagin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
In-Reply-To: <20200723174140.GA3991167@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com> <20200705064055.GA28894@gmail.com> <20200714015743.GA843937@gmail.com> <20200722181506.GA4517@gaia> <20200723174140.GA3991167@gmail.com>
Date:   Thu, 23 Jul 2020 22:25:35 +0200
Message-ID: <87d04mvv0g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:
> On Wed, Jul 22, 2020 at 07:15:06PM +0100, Catalin Marinas wrote:
>
> I don't think that we need to handle this case in the kernel. Users
> must understand what they are doing and have to write code so that avoid
> these sort of situations. In general, I would say that in most cases it
> is a bad idea to call setns from a signal handler.

This should not be supported in the first place and just let the
offender die right there.

Thanks,

        tglx
