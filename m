Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70A1E6A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406236AbgE1TMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406147AbgE1TMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:12:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF9C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:12:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeNx8-0006xd-EA; Thu, 28 May 2020 21:12:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BE9D2100D01; Thu, 28 May 2020 21:12:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/5] x86/entry: introduce macro idtentry_swapgs_and_switch_to_kernel_stack
In-Reply-To: <20200527073107.2127-2-laijs@linux.alibaba.com>
References: <20200527073107.2127-1-laijs@linux.alibaba.com> <20200527073107.2127-2-laijs@linux.alibaba.com>
Date:   Thu, 28 May 2020 21:12:29 +0200
Message-ID: <87mu5roov6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai,

Lai Jiangshan <laijs@linux.alibaba.com> writes:

> Move a portion of code to be a macro, and it will also be used in
> next patch.
>
> Just move around the code, no functionality changed.

interrupt_enter does not exist anymore. See:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

Thanks,

        tglx
