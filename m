Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2121027A994
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgI1Iea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgI1IeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12398C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:34:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f072200afd3fa405d8d6d26.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2200:afd3:fa40:5d8d:6d26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70DC81EC00F4;
        Mon, 28 Sep 2020 10:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601282062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HqdxqAl+E5SZ8tKdgd7tiAOTNLf2p6sYGiq2D0zF27A=;
        b=HCfs/g2SRTezMmqtmmUnuiJlvTQSM2hTs6NKZulowK3KgvE/+TQkwFzWzHXNKiq7Z7I1Kc
        G16VlpkcCRtAIpAoStqfkMS+ciUXzjB2wNmx3Ci+6Z/Fu2gbHjEHqw+HEbzi7r6lBbitky
        jfAAwMkcy+d0M/HF/W6rs6zv59Yvtmk=
Date:   Mon, 28 Sep 2020 10:34:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200928083420.GC1685@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200925172437.GM16872@zn.tnic>
 <20200928070723.GA25109@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928070723.GA25109@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:07:23PM +0800, Feng Tang wrote:
> Thanks, it looks good to me. One thing is in v2 we supported ',' in the
> long name field, but that's minor as we could avoid using it in .csv

We can always use ';' or some other symbol as divider if we wanna use
',' in the long name field but I can live with either solutions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
