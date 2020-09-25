Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A101F2791E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgIYUTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIYURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:17:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BBC05BD0B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:17:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1A061EC02C1;
        Fri, 25 Sep 2020 22:17:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601065036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cFc9UfE5wmCfFhSizovUaopt8fw6YJ+w3Zy1pLblqW8=;
        b=g1hRVfwU/UWlbeD+XKTHhaqJ4GA9g4hXlnySuyR/17jbkNZd73MSyWC/xC5FB9qFk14rwL
        jalnEZQtksC9sJwU8v2jvDm0fNv+5csg22jhOaweeokkrZWeiMUupMSzz3hUKzVBhCyWII
        C1JHQZEgyvq1sAP7lJ/tkcDhAdBy/yQ=
Date:   Fri, 25 Sep 2020 22:17:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Feng Tang <feng.tang@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200925201707.GQ16872@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
 <20200922221523.GA1185357@rani.riverdale.lan>
 <20200923024529.GA15894@shbuild999.sh.intel.com>
 <20200925171631.GL16872@zn.tnic>
 <20200925194804.GA757220@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925194804.GA757220@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:48:04PM -0400, Arvind Sankar wrote:
> Ok. Another suggestion: while designing the format for the cpuid.txt
> file, would it be possible to include enough information for
> cpufeatures.h to be auto-generated from it?

I think you're missing the previous discussion on this topic. In short:
/proc/cpuinfo is not CPUID but what the kernel supports. The kcpuid tool
is supposed to dump CPUID leafs and it should be updatable the easiest
way possible.

Here's some more documentation which should make this more clear:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ea4e3bef4c94d5b5d8e790f37b48b7641172bcf5

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
