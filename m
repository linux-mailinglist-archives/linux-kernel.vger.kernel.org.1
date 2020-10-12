Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8728C45D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgJLV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:56:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgJLV4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:56:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5F46AE93;
        Mon, 12 Oct 2020 21:56:52 +0000 (UTC)
Date:   Mon, 12 Oct 2020 23:56:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/platform updates for v5.10
Message-ID: <20201012215642.GN25311@zn.tnic>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <CAHk-=wg6MBLPzRrRYGQ6EeoUGV+-MdMraFiUiiQyenVk=t6=Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg6MBLPzRrRYGQ6EeoUGV+-MdMraFiUiiQyenVk=t6=Bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:46:10PM -0700, Linus Torvalds wrote:
> At least "git grep" only shows two assignments to it.
> 
> Of course, that would miss any cases that play games with preprocessor
> token pasting etc, so it's not entirely meaningful, but it's certainly
> a hint..

From a quick staring at gcc asm, it looks write only. And gcc didn't
warn because it optimized that assignment away completely AFAICT.

> And yes, I expect that the fix is to just make it "unsigned long", but
> if it truly isn't actually used, maybe removal is better.

Yeah, below is a proper patch which builds fine with gcc and clang-10.
You guys have fun - I'm going to bed. :-)

---
From: Mike Travis <mike.travis@hpe.com>
Date: Mon, 12 Oct 2020 23:46:34 +0200
Subject: [PATCH] x86/platform/uv: Correct uvh_nmi_mmrx_mask's type

Clang rightfully warns:

  arch/x86/platform/uv/uv_nmi.c:250:23: warning: implicit conversion
  from 'unsigned long' to 'int' changes value from 1152921504606846976
  to 0 [-Wconstant-conversion]
                  uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
                                  ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make the variable unsigned long.

 [ bp: Productize it. ]

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/platform/uv/uv_nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 0f5cbcf0da63..8566730f154d 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -59,7 +59,7 @@ DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
 static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
 static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
-static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
+static unsigned long uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
 static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
 
 /* Non-zero indicates newer SMM NMI handler present */
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
