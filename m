Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F262026625F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIKPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgIKPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:37:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F653C061344
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:06:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ce0009d4bcf8b2b506f0d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e000:9d4b:cf8b:2b50:6f0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1D741EC051F;
        Fri, 11 Sep 2020 16:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599833197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wfz55+m1k7uU6dMkp1Uyfs6Fe6eW5s5tKFF8uVGuBJk=;
        b=WFsYjRHtvSxBrJI9fwxStIdsRYui54MZZeUTPJpnptfw+bKcmD9pqUUHbPv+dHF3tug9wj
        Ek502qWvumnkgAMBll2WLBnJcXNUwmQtWVT5L+FXFb07FuBH4szhJ13iD9Osh6R031Qa/n
        Z7FljGAYYqZWsxMhH0jaOznsnpl4jPM=
Date:   Fri, 11 Sep 2020 16:06:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 f5ed777586e08e09c4b6f1e87161a145ee1431cf
Message-ID: <20200911140633.GB8472@zn.tnic>
References: <5f5b3f27.qfbP2yqzLurGC9yI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f5b3f27.qfbP2yqzLurGC9yI%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:11:03PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/seves
> branch HEAD: f5ed777586e08e09c4b6f1e87161a145ee1431cf  x86/sev-es: Check required CPU features for SEV-ES
> 
> Warning in current branch:
> 
> arch/x86/kernel/sev-es.o: warning: objtool: safe_stack_exc_vmm_communication()+0x209: unreachable instruction
> 
> Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> `-- x86_64-randconfig-a004-20200911
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Where do I get that randconfig from?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
