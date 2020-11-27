Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79C2C5E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 01:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbgK0AMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 19:12:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392049AbgK0AMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 19:12:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606435932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MA5VUTRQqVug2OypRf6jMK+Dq0EZLfXoQgeogMBHwdg=;
        b=cLkIliaUvl7GY7AXC8yFW48gpOuSXVgQLx0PrtEiiRO9IwgchC5nyPG/KPfRGwUDppzVhz
        pQfXJ/nNj8i66aBl2amz/OC3OFXqxgf8mKaf9kHnv9uhNgbiyTWGzxON2nQlNGM1J3vWpb
        VM3zJsYdpDLiQ2TSr1nO1PUWvi7+wzm2oR6vmizx8vLzZD+AYZpJ6MA0KYA8JJrOIibLdh
        aUiJrY4347ScRTqJwCkCI9k4lmG8i7Cs1Frzd8ylMFIeQO/SQ8Q8GpDojMiqMcoUuYRPrB
        HQB0th7xoiTQo9v9+FTAXRknbUtMQNxhxgivXTCVgGxjNYky96XSzbXBvxfnsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606435932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MA5VUTRQqVug2OypRf6jMK+Dq0EZLfXoQgeogMBHwdg=;
        b=YA/u1/kVJBnhihmj+F0tijBnZeqpB5nJx5lqzqqIKVMWbfekXLABoF9ZQzfi0UOOp1uq71
        WOVV72ekux3zX5Dw==
To:     =?utf-8?Q?Lauren=C8=9Biu?= Nicola <lnicola@dend.ro>
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
In-Reply-To: <20201126074734.12664-1-lnicola@dend.ro>
References: <20201126074734.12664-1-lnicola@dend.ro>
Date:   Fri, 27 Nov 2020 01:12:12 +0100
Message-ID: <875z5rk68z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26 2020 at 09:47, Lauren=C8=9Biu Nicola wrote:
> These messages are described as warnings in the MSI code.

Where and what has MSI to do with these messages?

> Spotted because they break quiet boot on a Ryzen 5000 CPU.

They don't break the boot.

The machine boots fine, but having interrupts raised on a vector which
is unused is really bad.

Can you please provide the actual message from dmesg?

Thanks,

        tglx
