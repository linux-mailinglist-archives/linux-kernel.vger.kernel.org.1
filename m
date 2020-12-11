Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5392D7F86
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393778AbgLKTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393573AbgLKTjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:39:51 -0500
Date:   Fri, 11 Dec 2020 11:39:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607715550;
        bh=U5rxTv/oE3jx6HklcCmBGmro94C4bmSbpwe8ZVtbESs=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=tGaPNds9nNLIuZR3ejOz+yBohOgC7o2Q5h0m/NYNa9zd3uyUnGP/IP4+kW9R5Klpf
         ww7M2K+hdZO6jYV7elyNeRzaTtP4WsT6sCZElRWWE9lkbWbLyEygFlEho9rV2A3BLV
         362MqgQHWa/jgbGJVMKxfO/qT9+2CbZ95+dC4qCQ=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "qcai@redhat.com" <qcai@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        walter-zh.wu@mediatek.com
Subject: Re: [PATCH] kasan: fix slab double free when cpu-hotplug
Message-Id: <20201211113909.230e68fcb66193aa71661ddd@linux-foundation.org>
In-Reply-To: <X9N3i+EwydXFc4HW@chrisdown.name>
References: <20201204102206.20237-1-qiang.zhang@windriver.com>
        <1607083295.22062.15.camel@mtksdccf07>
        <20201204172521.ed9f77164ff9f9fc91f35ee0@linux-foundation.org>
        <1607185035.22062.42.camel@mtksdccf07>
        <20201205170914.e380173074b2deded2ade3d3@linux-foundation.org>
        <X9N3i+EwydXFc4HW@chrisdown.name>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 13:43:39 +0000 Chris Down <chris@chrisdown.name> wrote:

> Hi folks,
> 
> Andrew Morton writes:
> >@@ -188,6 +190,10 @@ void quarantine_put(struct kasan_free_me
> > 	local_irq_save(flags);
> >
> > 	q = this_cpu_ptr(&cpu_quarantine);
> >+	if (q->offline) {
> >+		local_irq_restore(flags);
> >+		return;
> >+	}
> > 	qlist_put(q, &info->quarantine_link, cache->size);
> > 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
> > 		qlist_move_all(q, &temp);
> 
> I'm afraid as well as the issues already identified, this also fails, because 
> `quarantine_put` now returns a bool after "kasan: sanitize objects when 
> metadata doesn't fit":
> 
>      mm/kasan/quarantine.c: In function ‘quarantine_put’:
>      mm/kasan/quarantine.c:198:3: error: ‘return’ with no value, in function returning non-void [-Werror=return-type]
>        198 |   return;
>            |   ^~~~~~
>      mm/kasan/quarantine.c:171:6: note: declared here
>        171 | bool quarantine_put(struct kmem_cache *cache, void *object)

Yup, thanks.  I think I have this all fixed now, using the old
apply-one-patch-compile-everything-repeat approach.

