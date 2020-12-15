Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CA2DA49E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgLOAWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgLOAWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:22:17 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF6C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:21:37 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q25so21359324oij.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULLwaynizpmVh+4PDMIxrwCK5QlahivTlX8trO7U87M=;
        b=KfRhm5ul+Qx9Y1v5Bw0PXiXxnHe+48iUmOPvJohzm2EoAQIWENlzXn1LbPEWUMvjsd
         VyQyL1B2KUr+n7Ux2v8SK1f2UPl/dWM/e2TPJA8tFCjQbsgMU77r1xBhRQ4yvQkswg8+
         biKr0O0G0FzCcN4cjLT5sxofd4e89FiCj/zwiKrks1WsZs6+xOUcThQ/w9NNURURjRTO
         LD/LmWW+xTe9ygbvlmYMlfUDhEnJXZsziCkfcR86m/8vRfChQTQ/70WlQygrNwa+kdkJ
         pqVfJWoqxewTPuaXffGV2zE0IZ9RcFcUSzh1uNfF3Np/ur43aZPXawIQhMdzoDjtv9ud
         pzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ULLwaynizpmVh+4PDMIxrwCK5QlahivTlX8trO7U87M=;
        b=MI3fvibI9BAUmdFNgY1xX1QoryeAmJ1nvis4QI+iM4+x4M86EHGkEYygWYI7G5Lz1T
         QnzJO8rmvcjvPDouv5epJ7yc0h+esiL7tuv6HqAyHh3gg1rMZx/2YpMappbTJ3Yay2qT
         CIGk9biz5mrejjKcVDc0K+Tz/l4CFsMTRJmipXQxSauHGiTUECz4JUvBJtqbsF/t4cvx
         AdJHcAFoYS92S24bgHnqNHQqTTW4qSCtss9eUX0yfOa7vdazARHHy8GGCz6kJUVCTxhK
         wxrDUzxG6PLda57VlKu/boky7wKdHQVfbRccBCi0C9v7+21+1RONE4W6n5DnQH9J7Ond
         9h2A==
X-Gm-Message-State: AOAM533oeh/JpQTOjUeVw0eueXwt1YBIvMTPXNJiM/VkcKTPJD5I53Bf
        0H+LJSL7Y7umnaTfVuLqHxqKm7ByRXk=
X-Google-Smtp-Source: ABdhPJzLwFKOjAPRniWz2qxfvY8A/9r4CsH9zMOH3ro/sBOLPVjgYwPTElh5Iaw+avLgxkwZh8e1tA==
X-Received: by 2002:a05:6808:a0e:: with SMTP id n14mr20328616oij.75.1607991697221;
        Mon, 14 Dec 2020 16:21:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10sm321otn.71.2020.12.14.16.21.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Dec 2020 16:21:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Scott Branden <sbranden@broadcom.com>,
        Marc Zyngier <maz@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
Message-ID: <20201215002134.GA182208@roeck-us.net>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109094121.29975-4-valentin.schneider@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
> As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
> handle_percpu_devid_fasteoi_ipi() isn't actually required.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

This patch results in boot failures (silent stall) for the qemu
raspi2 emulation. Unfortunately it can not be reverted because
handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
so I don't know if it is the only problem.

Guenter

---
bisect log:

# bad: [7bba37a1591369e2e506d599b8f5d7d0516b2dbc] Add linux-next specific files for 20201214
# good: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
git bisect start 'HEAD' 'v5.10-rc7'
# good: [fe5c40ab90a1f82ba97294637eaf875cfdd7a05f] Merge remote-tracking branch 'nand/nand/next'
git bisect good fe5c40ab90a1f82ba97294637eaf875cfdd7a05f
# good: [674a0d6de8bd290671f7dff405205871a70300b3] Merge remote-tracking branch 'spi/for-next'
git bisect good 674a0d6de8bd290671f7dff405205871a70300b3
# bad: [8623dae312f73a2ea3230b1c648d3004cfc224ce] Merge remote-tracking branch 'vfio/next'
git bisect bad 8623dae312f73a2ea3230b1c648d3004cfc224ce
# bad: [9e2e5ac5449f5924cc15f350b3d2feae9bb8c4c4] Merge remote-tracking branch 'workqueues/for-next'
git bisect bad 9e2e5ac5449f5924cc15f350b3d2feae9bb8c4c4
# good: [e661ba4fd1c995dd2c3cf60c1858ad6b83dd8448] Merge branch 'efi/core'
git bisect good e661ba4fd1c995dd2c3cf60c1858ad6b83dd8448
# bad: [db0c509d351fe195afcfb96fc21f4d2b5dd14e4c] Merge remote-tracking branch 'ftrace/for-next'
git bisect bad db0c509d351fe195afcfb96fc21f4d2b5dd14e4c
# good: [8c91f9e7378ef03c0e67de4388d5ddb9ab9a6bf3] Merge remote-tracking branch 'clockevents/timers/drivers/next'
git bisect good 8c91f9e7378ef03c0e67de4388d5ddb9ab9a6bf3
# bad: [2f5fbc4305d07725bfebaedb09e57271315691ef] irqchip/qcom-pdc: Fix phantom irq when changing between rising/falling
git bisect bad 2f5fbc4305d07725bfebaedb09e57271315691ef
# good: [e52e73b7e9f7d08b8c2ef6fb1657105093e22a03] irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()
git bisect good e52e73b7e9f7d08b8c2ef6fb1657105093e22a03
# bad: [91f90daa4fb2b77db7aa25ef2e0206f2e3962665] platform-msi: Track shared domain allocation
git bisect bad 91f90daa4fb2b77db7aa25ef2e0206f2e3962665
# bad: [b388fa50142510fb6477f130bb1b3f05a0a263a1] Revert "genirq: Add fasteoi IPI flow"
git bisect bad b388fa50142510fb6477f130bb1b3f05a0a263a1
# bad: [a2e042e13ff322ad523a2f131dd6e03e8bc05053] irqchip/hip04: Make IPIs use handle_percpu_devid_irq()
git bisect bad a2e042e13ff322ad523a2f131dd6e03e8bc05053
# bad: [ffdad793d579c9286c7b67a86d1a3c890fb32082] irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
git bisect bad ffdad793d579c9286c7b67a86d1a3c890fb32082
# first bad commit: [ffdad793d579c9286c7b67a86d1a3c890fb32082] irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
