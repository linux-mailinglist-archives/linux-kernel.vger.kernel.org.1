Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8761D18A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 17:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEMPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgEMPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:05:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DFC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:05:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYswJ-0006J4-Pg; Wed, 13 May 2020 17:04:55 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 15344100605; Wed, 13 May 2020 17:04:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v6 5/6] Optionally flush L1D on context switch
In-Reply-To: <20200510014803.12190-6-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-6-sblbir@amazon.com>
Date:   Wed, 13 May 2020 17:04:55 +0200
Message-ID: <87d0773mg8.fsf@nanos.tec.linutronix.de>
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
>  
> +	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
> +		arch_l1d_flush(0); /* Just flush, don't populate the TLB */

Bah. I fundamentally hate tail comments. They are just disturbing the
reading flow. Aside of that, this states the WHAT but not the WHY. And
if you add that explanation then you need more than 20 characters and
end up with

	if (prev_mm & LAST_USER_MM_L1D_FLUSH) {
        	/*
                 * Proper comment explaining why this is flushing
        	 * without prepopulating the TLB.
                 */
 		arch_l1d_flush(0);
        }

anyway. And even for a short comment which fits after the function call
it's way better to have:

	if (prev_mm & LAST_USER_MM_L1D_FLUSH) {
        	/* Short explanation */
 		arch_l1d_flush(0);
        }

Hmm?

> +	/*
> +	 * Leave last_user_mm_spec at LAST_USER_MM_IBPB, we don't
> +	 * want to set LAST_USER_MM_L1D_FLUSH and force a flush before
> +	 * we've allocated the flush pages.

Ah here is the comment. I still like the explicit define for the (re)
init.

