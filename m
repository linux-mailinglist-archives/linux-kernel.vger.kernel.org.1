Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1D293D95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407617AbgJTNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:46:37 -0400
Received: from smtp2.axis.com ([195.60.68.18]:63826 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407595AbgJTNqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2418; q=dns/txt; s=axis-central1;
  t=1603201595; x=1634737595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9iORr10Q1lfNph/u/UEQ+PUIt5U6T3S2ZrfX/J8M5ZI=;
  b=SzDYebO5oo8ieW2CC2utiTcU54iIvy1zd/tvpI+/aLIJYFQwhtDeZAOd
   mw2EZyAhflNWmOKj445c9rk1p/NXl//lfzyWczT2pjDXPa2m5KFVqVeOb
   HykwV0/XjTooVgBvLvPfMkH9pCPVMFy2Gs0i2Sr3gvambDEh1hxHyeMf9
   zKKpv1HUBjETWQl6KrtitIJYoZelwEgY8ogqg6i1fRVdJ6qIYW8Nc3rpv
   57cigxpPSQppNHR3jGYQASDdUUiTkjp0CoAn6wfGdacznx5rwrJeWjiNy
   q+12Vkvu+1ka5Kj6nJltVKQhbqFXkeprm7kvdRFBcmzfbGgnjX24y0vXL
   w==;
IronPort-SDR: jSnpuDpmn7vEOWEe5+CPPhvpIngqKbk+fIwqjt8Nowuhc1gAhqbc4HJxyawXktE4ZjJtX7qKH3
 V4Iw5HytCaAfOma94axzPGK+fZpcrn4O07ipRHbi+nGjHlZckNCNWpyk5bc/EDCDVRBDB52Ebi
 J6ldrvb3ovyDTybp/reWVvHOpWryhvCc3NoPp1r1Jdgu2mxsVSCQnqgdYR+86PLJnr5C+7yipn
 9HrtQLegJgygWNwXwJlmWTG/v7dLHrHjs4qYPbQBSbmAx0LIG6bkJVtE3pOE29TSkv1WHcHHAW
 wO0=
X-IronPort-AV: E=Sophos;i="5.77,397,1596492000"; 
   d="scan'208";a="13712496"
Date:   Tue, 20 Oct 2020 15:46:33 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>, kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of: Fix reserved-memory overlap detection
Message-ID: <20201020134633.3vv7hyvodg4tbro2@axis.com>
References: <20201020073558.3582-1-vincent.whitchurch@axis.com>
 <CAL_JsqL=mpw9KxiYe_bMa+y4mU8ybrRnJ2LcO8jRco9C3N_n_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqL=mpw9KxiYe_bMa+y4mU8ybrRnJ2LcO8jRco9C3N_n_w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 03:00:14PM +0200, Rob Herring wrote:
> On Tue, Oct 20, 2020 at 2:36 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > The reserved-memory overlap detection code fails to detect overlaps if
> > either of the regions starts at address 0x0.  For some reason the code
> > explicitly checks for and ignores such regions, but this check looks
> > invalid.  Remove the check and fix this detection.
> 
> Wouldn't 'base' be 0 for nodes that have a 'size' and no address? The
> base in those cases isn't set until later when
> __reserved_mem_alloc_size() is called.

Ah, yes, I guess that's why the check was there.  I see that those
entries have both a zero address and a zero size, so this seems to work:

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 623246f37448..6627e71c7283 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -81,6 +81,18 @@ vram: vram@4c000000 {
 			reg = <0x4c000000 0x00800000>;
 			no-map;
 		};
+
+		foo@0 {
+			reg = <0x0 0x2000>;
+		};
+
+		bar@1000 {
+			reg = <0x0 0x1000>;
+		};
+
+		baz {
+			size = <0x1000>;
+		};
 	};
 
 	clcd@10020000 {
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46b9371c8a33..fea9433d942a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -200,6 +200,16 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->base > rb->base)
 		return 1;
 
+	/*
+	 * Put the dynamic allocations (address == 0, size == 0) before static
+	 * allocations at address 0x0 so that overlap detection works
+	 * correctly.
+	 */
+	if (ra->size < rb->size)
+		return -1;
+	if (ra->size > rb->size)
+		return 1;
+
 	return 0;
 }
 
@@ -212,13 +222,19 @@ static void __init __rmem_check_for_overlap(void)
 
 	sort(reserved_mem, reserved_mem_count, sizeof(reserved_mem[0]),
 	     __rmem_cmp, NULL);
+
+	for (i = 0; i < reserved_mem_count - 1; i++) {
+		struct reserved_mem *this = &reserved_mem[i];
+
+		pr_info("i %d base %x size %x\n", i, this->base, this->size);
+	}
+
 	for (i = 0; i < reserved_mem_count - 1; i++) {
 		struct reserved_mem *this, *next;
 
 		this = &reserved_mem[i];
 		next = &reserved_mem[i + 1];
-		if (!(this->base && next->base))
-			continue;
+
 		if (this->base + this->size > next->base) {
 			phys_addr_t this_end, next_end;
 
