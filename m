Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2482F51BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbhAMSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbhAMSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:12:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE0C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:12:17 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kzkcu-005sJl-BD; Wed, 13 Jan 2021 19:12:12 +0100
Message-ID: <0f2b134140bc7a8d4a2619a26e1ca87339b220bd.camel@sipsolutions.net>
Subject: Re: [PATCH] mm/slub: disable user tracing for kmemleak caches
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Date:   Wed, 13 Jan 2021 19:11:55 +0100
In-Reply-To: <1db7c986-25c4-884e-4fbf-9af348bdff6f@suse.cz>
References: <20210113170931.929f808099d2.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
         <1db7c986-25c4-884e-4fbf-9af348bdff6f@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-13 at 17:59 +0100, Vlastimil Babka wrote:
> On 1/13/21 5:09 PM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > If kmemleak is enabled, it uses a kmem cache for its own objects.
> > These objects are used to hold information kmemleak uses, including
> > a stack trace. If slub_debug is also turned on, each of them has
> > *another* stack trace, so the overhead adds up, and on my tests (on
> > ARCH=um, admittedly) 2/3rds of the allocations end up being doing
> > the stack tracing.
> > 
> > Turn off SLAB_STORE_USER if SLAB_NOLEAKTRACE was given, to avoid
> > storing the essentially same data twice.
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> How about stripping away SLAB_STORE_USER only if it's added from the global
> slub_debug variable? In case somebody lists one of the kmemleak caches
> explicitly in "slub_debug=..." instead of just booting with "slub_debug", we
> should honor that.

Good point, that makes a lot of sense.

TBH, I mostly sent this to see if anyone would think it acceptable. I've
now disabled slub debugging completely for the kmemleak caches by
command line, and as expected that improves things further. I'm _hoping_
of course that kmemleak itself doesn't contain egregious bugs, but seems
like a fair bet for now :)

So what do you/people think? Should we disable this? Disable all?
Subject to the above constraint, either way.

Thanks,
johannes

