Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0FD1D1598
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgEMNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388599AbgEMNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:35:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51B8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:35:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYrXg-0003nv-N2; Wed, 13 May 2020 15:35:24 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 25DB8100605; Wed, 13 May 2020 15:35:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v6 1/6] arch/x86/kvm: Refactor l1d flush lifecycle management
In-Reply-To: <20200510014803.12190-2-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-2-sblbir@amazon.com>
Date:   Wed, 13 May 2020 15:35:23 +0200
Message-ID: <87o8qs2c10.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:

> Subject: [PATCH v6 1/6] arch/x86/kvm: Refactor....

arch/x86/kvm: is really not the correct subsystem prefix...

I'll fix it up this time.
