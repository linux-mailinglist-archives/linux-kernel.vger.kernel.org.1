Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C874F2729A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgIUPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:12:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726457AbgIUPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600701152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dBWCOBhNU2yvcyOTmz9OOc5Y/qYesvUN4o+olyLfbI=;
        b=Lh8whYf/UO7rg+FuIviZul+zkJhHKZTopdHPK3YUBY0FRRT68S6VrN+RH+qUvaHp+uxNR3
        LThFmfl31rWiwX3tnB4unHS6QHm3rYIZFju7FMZwUDQlsnKJYkYah+9D6XeA5/aqrBy6a5
        rLePXGGQRIS+0iP9PSljohEnmI0ZhcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-IXjANd15OHyVX7sY3gs82g-1; Mon, 21 Sep 2020 11:12:31 -0400
X-MC-Unique: IXjANd15OHyVX7sY3gs82g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634CF425CB;
        Mon, 21 Sep 2020 15:12:29 +0000 (UTC)
Received: from treble (ovpn-119-131.rdu2.redhat.com [10.10.119.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5101A885;
        Mon, 21 Sep 2020 15:12:28 +0000 (UTC)
Date:   Mon, 21 Sep 2020 10:12:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 3/3] objtool: check: Make SP memory operation match
 PUSH/POP semantics
Message-ID: <20200921151226.3ismmtndjn4t5z4a@treble>
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-4-jthierry@redhat.com>
 <20200918214318.2d7msla53ysxkbaz@treble>
 <249188d0-d65e-c862-7cb9-7e1db05361c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <249188d0-d65e-c862-7cb9-7e1db05361c6@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:31:28AM +0100, Julien Thierry wrote:
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index f45991c2db41..7ff87fa3caec 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -2005,6 +2005,13 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
> > >   			break;
> > >   		case OP_SRC_REG_INDIRECT:
> > > +			if (!cfi->drap && op->dest.reg == cfa->base) {
> > 
> > && op->dest.reg == CFI_BP ?
> > 
> 
> Does it matter? My unstandig was that the register used to point to the CFA
> is getting overwritten, so we need to fallback to something known which is
> the offset from the stack pointer.
> 
> Was that not the case?

Maybe.  I was wondering if it would be possible to overwrite the stack
pointer, like 'mov disp(%rsp), %rsp', which could be possible in asm.

Though I suppose the below code would be harmless, since the CFA
base/offset would already be CFI_SP/cfi->stack_size respectively.

Still, no harm in making the condition more precise.

> > > +
> > > +				/* mov disp(%rsp), %rbp */
> > > +				cfa->base = CFI_SP;
> > > +				cfa->offset = cfi->stack_size;
> > > +			}

-- 
Josh

