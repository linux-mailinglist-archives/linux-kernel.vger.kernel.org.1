Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5B26E402
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIQSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIQRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:19:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:18:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f105300d80be81ad57dea02.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:d80b:e81a:d57d:ea02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0CBD1EC032C;
        Thu, 17 Sep 2020 19:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600363137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WU5uCzjAtxqK1mwx7rQrEjQuAmt9/FJg9bmOpsWfM5g=;
        b=XxZqzp9yxOxK+AiJsoXf7Nt2uhPsR3sU4Oq3YAjmssSjcf8rFOJ3TJS0tafGBkpH8Y7Dka
        CPO66Bq2xmvjSDo+QAXMTWEPQAwnAQVENAKAgc5FqKw02PfmQ0ds/Y+VB906mByT9ba9R0
        PyiQ9Gvp9Gh4CQakJo9rN4W8UJLODuo=
Date:   Thu, 17 Sep 2020 19:18:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v8 3/9] Documentation/x86: Add documentation for SVA
 (Shared Virtual Addressing)
Message-ID: <20200917171849.GO31960@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
 <20200917075338.GC31960@zn.tnic>
 <20200917145609.GB91028@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917145609.GB91028@otc-nc-03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:56:09AM -0700, Raj, Ashok wrote:
> Just tweaked it a bit: 
> 
> "When ATS lookup fails for a virtual address, device should use PRI in
> order to request the virtual address to be paged into the CPU page tables.
> The device must use ATS again in order the fetch the translation again
> before use"

Thanks, amended.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
