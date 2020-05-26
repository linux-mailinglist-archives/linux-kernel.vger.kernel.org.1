Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3B1B2BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDUP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgDUP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:57:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F7C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:57:52 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0D9B00ACA0DFD8B73013F7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:9b00:aca0:dfd8:b730:13f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CCD71EC0D20;
        Tue, 21 Apr 2020 17:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587484669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bohw3tvId2iBa/iT+oM/S7NnfikNv9CXoGhTiUDbOFg=;
        b=aimMpP+BaqtLcgLSBNt0mYNRfgzdAdUDSUXGBv01ZAKHRg3trnlLjr+vJ6hmc35mPHKU9F
        /NYi7fkaq9AlOb/M/jsgV4qv2u5acwqD+Pcx/icgjSsV0rAlGOzSGC4ZYzDizzr2iA4exW
        +DtEdEf304tKjFRV84wQHlpA5e94YjI=
Date:   Tue, 21 Apr 2020 17:57:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     youling257 <youling257@gmail.com>, tglx@linutronix.de,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 14/26] objtool: Optimize read_sections()
Message-ID: <20200421155744.GG19515@zn.tnic>
References: <20200324160924.739153726@infradead.org>
 <20200421144714.12479-1-youling257@gmail.com>
 <20200421154928.GU20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421154928.GU20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:49:28PM +0200, Peter Zijlstra wrote:
> Excuse me for not considering 32bit a priority.

rm -rf 32bit already!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
