Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F081DDA35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 00:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgEUW0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 18:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUW0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:26:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC1EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:26:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbte3-0002iw-16; Fri, 22 May 2020 00:26:31 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5E621100CA6; Fri, 22 May 2020 00:26:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        keescook@chromium.org, mingo@redhat.com, bp@alien8.de
Cc:     arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH v2 0/9] Function Granular KASLR
In-Reply-To: <20200521165641.15940-1-kristen@linux.intel.com>
References: <20200521165641.15940-1-kristen@linux.intel.com>
Date:   Fri, 22 May 2020 00:26:30 +0200
Message-ID: <87367sudpl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen,

Kristen Carlson Accardi <kristen@linux.intel.com> writes:

sorry for not following this work and a maybe stupid question.

> Proposed Improvement
> --------------------
> This patch set proposes adding function reordering on top of the existing
> KASLR base address randomization. The over-arching objective is incremental
> improvement over what we already have. It is designed to work in combination
> with the existing solution. The implementation is really pretty simple, and
> there are 2 main area where changes occur:
>
> * Build time
>
> GCC has had an option to place functions into individual .text sections for
> many years now. This option can be used to implement function reordering at
> load time. The final compiled vmlinux retains all the section headers, which
> can be used to help find the address ranges of each function. Using this
> information and an expanded table of relocation addresses, individual text
> sections can be suffled immediately after decompression. Some data tables
> inside the kernel that have assumptions about order require re-sorting
> after being updated when applying relocations. In order to modify these tables,
> a few key symbols are excluded from the objcopy symbol stripping process for
> use after shuffling the text segments.

I understand how this is supposed to work, but I fail to find an
explanation how all of this is preserving the text subsections we have,
i.e. .kprobes.text, .entry.text ...?

I assume that the functions in these subsections are reshuffled within
their own randomized address space so that __xxx_text_start and
__xxx_text_end markers still make sense, right?

I'm surely too tired to figure it out from the patches, but you really
want to explain that very detailed for mere mortals who are not deep
into this magic as you are.

Thanks,

        tglx
