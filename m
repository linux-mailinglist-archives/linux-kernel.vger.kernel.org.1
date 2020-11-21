Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBF2BC20B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgKUUaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgKUUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990607;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=jIrMvS3fqSg9X4blIZwjBFdkrYYk3E5Uj4UHcmCYcYw=;
        b=DA16yGLCu7U6kFlBgzpci/hQudexghZn/nJsEGG0VkR4TabjBgnq2RHhDwlz16hVSuf5Ne
        Kg6ewepl7UpbBt+CvC4xM1YRY4/cPvlYUP4gQFvyqL1CXB5TbmubqXzDYFlu15m7yM+0LA
        s3/9bcKcO9+hiNOaSQJVlKf9atEcJI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-tvJV7NueNYawQwS84FWyHQ-1; Sat, 21 Nov 2020 15:30:03 -0500
X-MC-Unique: tvJV7NueNYawQwS84FWyHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B6F81842174;
        Sat, 21 Nov 2020 20:30:02 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-113-127.ams2.redhat.com [10.36.113.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADB161349A;
        Sat, 21 Nov 2020 20:30:01 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 0ALKTwiO2730785
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 21 Nov 2020 21:29:58 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 0ALKTs3I2730784;
        Sat, 21 Nov 2020 21:29:54 +0100
Date:   Sat, 21 Nov 2020 21:29:54 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        rdunlap@infradead.org
Subject: Re: [PATCH] ilog2: Improve ilog2 for constant arguments
Message-ID: <20201121202954.GW3788@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20201120125154.GB3040@hirez.programming.kicks-ass.net>
 <20201121202310.lx2iqqebal3fmmmo@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121202310.lx2iqqebal3fmmmo@ltop.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 09:23:10PM +0100, Luc Van Oostenryck wrote:
> On Fri, Nov 20, 2020 at 01:51:54PM +0100, Peter Zijlstra wrote:
> > 
> > Other option would be to change the const_ilog2 macro, though as the
> > description says it is meant to be used also in C constant expressions,
> > and while GCC will fold it to constant with constant argument even in
> > those, perhaps it is better to avoid using extensions in that case.
> 
> Just for info, the description is outdated and Sparse is just fine with
> __builtin_clzll() and friends in constant expressions (since Feb 2017)

Why is the description outdated?  It is still an extension that not every
compiler might fold in constant expressions.  And, the large expressions
aren't really a problem in constant expressions, they will be folded there
to constant or error.
The problem the patch was trying to solve is that the large expressions are
a problem at least for GCC in runtime code when guarded by
__builtin_constant_p, because __builtin_constant_p is folded quite late
(intentionally so, so that more constants can be propagated into it, e.g.
after inlining etc.), and the large expressions might confuse inliner
heuristics.

	Jakub

