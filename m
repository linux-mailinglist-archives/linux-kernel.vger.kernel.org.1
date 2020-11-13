Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF962B2277
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605288672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/aAhx5VVqL4lk/Wfra0s2SdMK5jFFUCUk9GqwTX8PA=;
        b=bX5GgH+vizsTYr52dAdfkZU69TYCGDlmOeEJ8//T3Ml+FS/gLMoIS5yMgQeoJrXRlOBTS1
        K3Z55WLw2+dorwPnZzxJoesn+SvCVRyho83+Mp/2Tb48w2nNXkrat0SYbDpKSeIpXFuK5s
        zwZCqO78a0QvHuKoGdA9iAY4arFe/UU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-c1MQ3t4KOeKw6d1TIhws9g-1; Fri, 13 Nov 2020 12:31:09 -0500
X-MC-Unique: c1MQ3t4KOeKw6d1TIhws9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF011016CE7;
        Fri, 13 Nov 2020 17:31:07 +0000 (UTC)
Received: from treble (ovpn-119-84.rdu2.redhat.com [10.10.119.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9DC5D9F1;
        Fri, 13 Nov 2020 17:31:01 +0000 (UTC)
Date:   Fri, 13 Nov 2020 11:30:52 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/insn: Fix vector instructions decoding on big endian
Message-ID: <20201113173052.vdy72pytmv6ztnbj@treble>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
 <patch.git-a153abbe9170.your-ad-here.call-01605283379-ext-7358@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch.git-a153abbe9170.your-ad-here.call-01605283379-ext-7358@work.hours>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 05:09:54PM +0100, Vasily Gorbik wrote:
> Running instruction decoder posttest on s390 with allyesconfig shows
> errors. Instructions used in couple of kernel objects could not be
> correctly decoded on big endian system.
> 
> insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 5
> insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> insn_decoder_test: warning: ffffffff831eb4e1:    62 d1 fd 48 7f 04 24    vmovdqa64 %zmm0,(%r12)
> insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
> insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> insn_decoder_test: warning: ffffffff831eb4e8:    62 51 fd 48 7f 44 24 01         vmovdqa64 %zmm8,0x40(%r12)
> insn_decoder_test: warning: objdump says 8 bytes, but insn_get_length() says 6
> 
> This is because in few places instruction field bytes are set directly
> with further usage of "value". To address that introduce and use
> insn_set_byte() helper, which correctly updates "value" on big endian
> systems.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  Please let me know if this patch is good as it is or I should squash it
>  into the patch 2 of my patch series and resend it again.

It all looks good to me, thanks!

Masami, does this patch look good, and also patches 1-2 of the series?
(I think you previously ACKed patch 2).

-- 
Josh

