Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFC278F98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgIYR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgIYR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:27:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:27:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C31431EC0284;
        Fri, 25 Sep 2020 19:27:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601054859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1zxzNx7WjXwoGXF8dvMId40KkzFC16LXVdvcZoI8BjE=;
        b=GEI+HVJ9W0OcAhxOdcl5tsOOnTNlnNht5vMHqhCmFAwiGcvWBkAPgKD4QIPyL9sMjygd4s
        tk0+FAzvD1moJAgg3xCQ5xW9Mb9fgSx8mndaBjkpO3kuXC02xWtxWpRot2Nf1abgskuQIU
        jQuFFYIwy4OXlPnoKloIcSthaQqaLlo=
Date:   Fri, 25 Sep 2020 19:27:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200925172738.GN16872@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <51821d92-8c77-7661-5cf6-bd5dbe0cdbaf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51821d92-8c77-7661-5cf6-bd5dbe0cdbaf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:38:30PM -0700, Dave Hansen wrote:
> or something.  It also needs a "-f" argument to override this default
> location.

Yah, the -f thing is almost mandatory. I can imagine simply downloading
the latest cpuid.leafs or so and then running kcpuid on it. Can't get
any better than this I'd say.

Which reminds me: we probably should aim at not changing that text
file's format too often and design it to contain the required info
from the get-go so that we don't have uglies with old kcpuid not
understanding the new format or the other way around. That would be a
pain.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
