Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB692DD52E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgLQQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgLQQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608222333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49yV2IcmGc0QJ5YAt0WJ2wci08ptQ85ppP+Sw3Lmdeo=;
        b=ZTVDeI627f0wePT787vrbctAs/GAT6huTw97akqO0vLx9xRQ2G2jxYKIywsBAWJma1X0bg
        XUNdC9imb4DevKtuOwcSVxqM1t1TyqYPnv5RP95iHrcOVLGJ3HIiXmGxzOIBhC3tQvL1uf
        4Z/47/uMj9A0XEWdpnI1LiQx1zeFTAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-qGT79G40PZycWtFdLMCbMg-1; Thu, 17 Dec 2020 11:25:31 -0500
X-MC-Unique: qGT79G40PZycWtFdLMCbMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0B4803626;
        Thu, 17 Dec 2020 16:25:29 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A94895D9CD;
        Thu, 17 Dec 2020 16:25:28 +0000 (UTC)
Date:   Thu, 17 Dec 2020 10:25:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: New objtool warning..
Message-ID: <20201217162524.fkxiemn7aezpv7d5@treble>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
 <CAHk-=wjMoZesNgi1yWzY3nikyR11PUxHgov561UNom5mL1R4rA@mail.gmail.com>
 <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
 <20201216200158.akf356yrw44o2rlb@treble>
 <20201217104556.GT3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217104556.GT3040@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:45:56AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 16, 2020 at 02:01:58PM -0600, Josh Poimboeuf wrote:
> > So this is kind of tricky, because the unreachable() annotation usually
> > means "the previous instruction is a dead end".  Most of the time, the
> > next instruction -- the one actually pointed to by the annotation -- is
> > actually reachable from another path.
> 
> *groan*, this is why I ended up sticking a nop in
> instrumentation_begin()/_end().

Oh yeah, I forgot about that.  That would be another option if my patch
doesn't work out.

/me grumbles something about integrating objtool with compiler plugins
someday...

-- 
Josh

