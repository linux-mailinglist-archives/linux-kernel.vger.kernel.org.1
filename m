Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0127D6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgI2TSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgI2TSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:18:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601407124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwDF8sRN981dD8fydiaK/PhWhCr08TO1kfBL5+e7gjw=;
        b=X4EEo2oZNlI4Pg1lVOIq/NHpKU23xvh+Qsf85DfmS6TH1sdkpSLoSVgdxcBA+TdwRQdu9l
        mQGrJJzra4lUVhso69ffXBJ+SciJjChjPhkkEahlNQ48/8fLzoQQmgq/o0VWrOGlG98z60
        2iiLgnkrVbw2eMj5ErIdQpalp0lmuv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-8LXkHtqgOoW2pfy9EyuA1g-1; Tue, 29 Sep 2020 15:18:40 -0400
X-MC-Unique: 8LXkHtqgOoW2pfy9EyuA1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE36425CE;
        Tue, 29 Sep 2020 19:18:38 +0000 (UTC)
Received: from treble (ovpn-113-70.rdu2.redhat.com [10.10.113.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11DAF7838A;
        Tue, 29 Sep 2020 19:18:36 +0000 (UTC)
Date:   Tue, 29 Sep 2020 14:18:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 1/3] objtool: check: Fully validate the stack frame
Message-ID: <20200929191834.7daofidv6b5aef3y@treble>
References: <20200928093631.210610-1-jthierry@redhat.com>
 <20200928093631.210610-2-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928093631.210610-2-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:36:29AM +0100, Julien Thierry wrote:
> +++ b/tools/objtool/arch/x86/include/cfi_regs.h
> @@ -22,4 +22,7 @@
>  #define CFI_RA			16
>  #define CFI_NUM_REGS		17

A few more naming nitpicks:

> +#define STACKFRAME_BP_OFFSET	-16
> +#define STACKFRAME_RA_OFFSET	-8

"Stack frame" has more than one meaning now, I suppose.  i.e. it could
also include the callee-saved registers and any other stack space
allocated by the function.

Would "call frame" be clearer?

  CALL_FRAME_BP_OFFSET
  CALL_FRAME_RA_OFFSET

?

> +++ b/tools/objtool/cfi.h
> @@ -35,4 +35,6 @@ struct cfi_state {
>  	bool end;
>  };
>  
> +#define STACKFRAME_SIZE	16

CALL_FRAME_SIZE ?

I'm sort of contradicting my previous comment here, but even though this
value may be generic, it's also very much intertwined with the
CALL_FRAME_{BP|RA}_OFFSET values.  So I get the feeling it really
belongs in the arch-specific cfi_regs.h next to the other defines after
all.

-- 
Josh

