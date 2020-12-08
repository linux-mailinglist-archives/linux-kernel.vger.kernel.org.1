Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82F52D36C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgLHXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:12:22 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46291 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:12:21 -0500
X-Originating-IP: 62.210.143.248
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A3724240002;
        Tue,  8 Dec 2020 23:11:36 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id 206BD720488DE; Wed,  9 Dec 2020 00:11:36 +0100 (CET)
Date:   Wed, 9 Dec 2020 00:11:36 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Yue Hu <huyue2@yulong.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update documentation to reflect what
 TAINT_CPU_OUT_OF_SPEC means nowadays
Message-ID: <20201208231136.GA1455290@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>, Yue Hu <huyue2@yulong.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201202153244.709752-1-me@mathieu.digital>
 <20201208105439.23e2349b@lwn.net>
 <1254edd7-25ee-b73d-da2c-194d38ba7890@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254edd7-25ee-b73d-da2c-194d38ba7890@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Tue, Dec 08, 2020 at 09:58:32AM -0800, Randy Dunlap wrote:
> On 12/8/20 9:54 AM, Jonathan Corbet wrote:
> > On Wed,  2 Dec 2020 16:32:43 +0100
> > Mathieu Chouquet-Stringer <me@mathieu.digital> wrote:
> >> Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
> > 
> > Hearing no objection, I've applied this.

Thanks Jon.

> Hm, I was glad to read this new info since my old testing laptop
> now tells me that it needs a microcode update.  :(

In my case I first saw the error because tuned uses
x86_energy_perf_policy which uses to poke at MSRs [1]. And that was
tainting my kernel and I initially couldn't understand why.

It's been fixed but will be released in an upcoming kernel version (it's
in tip at the moment [2]).

Thanks to Borislav for work and for helping me out!

[1] https://lore.kernel.org/lkml/20201117210018.GA4247@weirdfishes/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fe0a5788624c8b8f113a35bbe4636e37f9321241
-- 
Mathieu Chouquet-Stringer                             me@mathieu.digital
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
