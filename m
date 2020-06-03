Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0D1ECD6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFCKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:24:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5AC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 03:24:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jgQYv-0006iu-4o; Wed, 03 Jun 2020 12:23:57 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5B28F10108D; Wed,  3 Jun 2020 12:23:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <lkp@intel.com>,
        "Peter\, Zijlstra\," <peterz@infradead.org>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: Re: b614345f52 ("x86/entry: Clarify irq_{enter,exit}_rcu()"):  WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:3680 lockdep_hardirqs_on_prepare
In-Reply-To: <5ed39ad2.0a1dg5gg0oNfWJPp%lkp@intel.com>
References: <5ed39ad2.0a1dg5gg0oNfWJPp%lkp@intel.com>
Date:   Wed, 03 Jun 2020 12:23:56 +0200
Message-ID: <87v9k8fnwj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org
> #!/bin/bash
>
> kernel=$1
> initrd=yocto-x86_64-trinity.cgz
>
> wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

That results in a 404. Still the same problem as months ago.

initrd=yocto-trinity-x86_64.cgz

works ....
