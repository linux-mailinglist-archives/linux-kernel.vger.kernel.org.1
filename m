Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3102EEE68
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAHIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:16:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:37456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbhAHIQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:16:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0343EACAF;
        Fri,  8 Jan 2021 08:15:44 +0000 (UTC)
Date:   Fri, 8 Jan 2021 09:15:43 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in
 alternatives
In-Reply-To: <20210107181835.rc7lutdqujf4mead@treble>
Message-ID: <alpine.LSU.2.21.2101080914230.6998@pobox.suse.cz>
References: <cover.1608700338.git.jpoimboe@redhat.com> <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com> <alpine.LSU.2.21.2101071417440.31250@pobox.suse.cz> <20210107181835.rc7lutdqujf4mead@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That comment is indeed now obsolete.  I can squash something like so:
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 81d56fdef1c3..ce67437aaf3f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -958,21 +958,8 @@ static int add_call_destinations(struct objtool_file *file)
>  }
>  
>  /*
> - * The .alternatives section requires some extra special care, over and above
> - * what other special sections require:
> - *
> - * 1. Because alternatives are patched in-place, we need to insert a fake jump
> - *    instruction at the end so that validate_branch() skips all the original
> - *    replaced instructions when validating the new instruction path.
> - *
> - * 2. An added wrinkle is that the new instruction length might be zero.  In
> - *    that case the old instructions are replaced with noops.  We simulate that
> - *    by creating a fake jump as the only new instruction.
> - *
> - * 3. In some cases, the alternative section includes an instruction which
> - *    conditionally jumps to the _end_ of the entry.  We have to modify these
> - *    jumps' destinations to point back to .text rather than the end of the
> - *    entry in .altinstr_replacement.
> + * The .alternatives section requires some extra special care over and above
> + * other special sections because alternatives are patched in place.
>   */
>  static int handle_group_alt(struct objtool_file *file,
>  			    struct special_alt *special_alt,

Looks good to me.

Miroslav
