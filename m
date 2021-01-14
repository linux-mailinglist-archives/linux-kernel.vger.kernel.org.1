Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855B2F5592
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 01:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbhANA3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729804AbhANAX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610583718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQYE9qw/4uCxXdaVLgXMJx++zeg60U1N2/tG8OASZDE=;
        b=VLBNQV3NiAZODW1TpANYbeocX+HbRqGux2MUlH4fVhbiKBxD38/hXw+qHAnpc10dAESV4+
        jUzTl/iE9tct9WuF0Mfj/35EzNO+DZaAUxa66Z0sy5GntWirLzoqrT9C39TvXEnagYlUnG
        GBubyl/wJ/MpLuiwoXvC60wBPsIPNTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-BI_NTVB1NsSQOYHhVm7PBw-1; Wed, 13 Jan 2021 19:21:56 -0500
X-MC-Unique: BI_NTVB1NsSQOYHhVm7PBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DB0107ACFA;
        Thu, 14 Jan 2021 00:21:54 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4B1D60BF1;
        Thu, 14 Jan 2021 00:21:50 +0000 (UTC)
Date:   Wed, 13 Jan 2021 18:21:48 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in alternatives
Message-ID: <20210114002148.fiwjiuhhigv6nzxb@treble>
References: <cover.1608700338.git.jpoimboe@redhat.com>
 <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2101071417440.31250@pobox.suse.cz>
 <20210107181835.rc7lutdqujf4mead@treble>
 <alpine.LSU.2.21.2101080914230.6998@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2101080914230.6998@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:15:43AM +0100, Miroslav Benes wrote:
> > That comment is indeed now obsolete.  I can squash something like so:
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 81d56fdef1c3..ce67437aaf3f 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -958,21 +958,8 @@ static int add_call_destinations(struct objtool_file *file)
> >  }
> >  
> >  /*
> > - * The .alternatives section requires some extra special care, over and above
> > - * what other special sections require:
> > - *
> > - * 1. Because alternatives are patched in-place, we need to insert a fake jump
> > - *    instruction at the end so that validate_branch() skips all the original
> > - *    replaced instructions when validating the new instruction path.
> > - *
> > - * 2. An added wrinkle is that the new instruction length might be zero.  In
> > - *    that case the old instructions are replaced with noops.  We simulate that
> > - *    by creating a fake jump as the only new instruction.
> > - *
> > - * 3. In some cases, the alternative section includes an instruction which
> > - *    conditionally jumps to the _end_ of the entry.  We have to modify these
> > - *    jumps' destinations to point back to .text rather than the end of the
> > - *    entry in .altinstr_replacement.
> > + * The .alternatives section requires some extra special care over and above
> > + * other special sections because alternatives are patched in place.
> >   */
> >  static int handle_group_alt(struct objtool_file *file,
> >  			    struct special_alt *special_alt,
> 
> Looks good to me.

Thanks, I squashed this in.

If there are no objections, I'll go ahead and merge this set in -tip.
It doesn't have any direct dependencies on the Juergen's changes, and it
would be nice to have some of these changes in-tree, especially the fake
jump removal.

-- 
Josh

