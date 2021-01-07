Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527BE2ED69F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAGSUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbhAGSUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610043522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jmwdppp4KSdjSBui+pFcX3CZuLo5H+3bgjVupL0lUBE=;
        b=K3zh7goRCaplikkjbRLHTunLtFbl3fEdOZfut3xspI9KNsGWkrq/1SE9QrHZ7yqhjPqY6B
        I6lQ81+y4OKXPSqiUZlvPmAj4107wJZVsy0UBoCmlfUfLZMvDHNBbIKIGacao0YI1wIzIU
        f4sxPm4LWuWMkya+mnnnOrjjh48Oulk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-2ue6GNs7N0CujjnsvCMULQ-1; Thu, 07 Jan 2021 13:18:40 -0500
X-MC-Unique: 2ue6GNs7N0CujjnsvCMULQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D848959;
        Thu,  7 Jan 2021 18:18:38 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9D210013BD;
        Thu,  7 Jan 2021 18:18:37 +0000 (UTC)
Date:   Thu, 7 Jan 2021 12:18:35 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in alternatives
Message-ID: <20210107181835.rc7lutdqujf4mead@treble>
References: <cover.1608700338.git.jpoimboe@redhat.com>
 <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2101071417440.31250@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2101071417440.31250@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:22:27PM +0100, Miroslav Benes wrote:
> On Tue, 22 Dec 2020, Josh Poimboeuf wrote:
> 
> > BTW, another benefit of these changes is that, thanks to some related
> > cleanups (new fake nops and alt_group struct) objtool can finally be rid
> > of fake jumps, which were a constant source of headaches.
> 
> \o/
> 
> You may also want to remove/edit the comment right before 
> handle_group_alt() now that fake jumps are gone.
> 
> Anyway, I walked through the patch (set) and I think it should work fine 
> (but I am not confident enough to give it Reviewed-by. My head spins :)). 
> I even like the change.
> 
> Also, 1/3 is a benefit on its own, so if nothing else, it could go in.

Thanks for the review!

That comment is indeed now obsolete.  I can squash something like so:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 81d56fdef1c3..ce67437aaf3f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -958,21 +958,8 @@ static int add_call_destinations(struct objtool_file *file)
 }
 
 /*
- * The .alternatives section requires some extra special care, over and above
- * what other special sections require:
- *
- * 1. Because alternatives are patched in-place, we need to insert a fake jump
- *    instruction at the end so that validate_branch() skips all the original
- *    replaced instructions when validating the new instruction path.
- *
- * 2. An added wrinkle is that the new instruction length might be zero.  In
- *    that case the old instructions are replaced with noops.  We simulate that
- *    by creating a fake jump as the only new instruction.
- *
- * 3. In some cases, the alternative section includes an instruction which
- *    conditionally jumps to the _end_ of the entry.  We have to modify these
- *    jumps' destinations to point back to .text rather than the end of the
- *    entry in .altinstr_replacement.
+ * The .alternatives section requires some extra special care over and above
+ * other special sections because alternatives are patched in place.
  */
 static int handle_group_alt(struct objtool_file *file,
 			    struct special_alt *special_alt,

