Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45122FB89E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405037AbhASNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393928AbhASNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:11:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D3CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:10:22 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca001beaf3e1446171b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:1bea:f3e1:4461:71b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B2AF1EC05D3;
        Tue, 19 Jan 2021 14:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611061819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3432NVoKItbvt57UHGsrVESw9gNhJFapX368cqg5Saw=;
        b=DL/CCBp8E1ebktjF7YMzJdO5VlxlNoeO0L4ejvES9JKgJfKrlWJE4WKEE2JCqjGiiUCTmJ
        5vBJcNb5KJT62EE+0+6DpzkW8zfxnnKfmrjq+UuyW42H+sSpoK1qCNTQwCsEH5P6KVy5Y7
        CKBEdazSkutyeDWg6WeOdcStEj01qXw=
Date:   Tue, 19 Jan 2021 14:10:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [PATCH v4] tools/x86: Add a kcpuid tool to show raw CPU features
Message-ID: <20210119131013.GK27433@zn.tnic>
References: <1610955311-77910-1-git-send-email-feng.tang@intel.com>
 <20210119051942.GA87207@shbuild999.sh.intel.com>
 <20210119091116.GA27433@zn.tnic>
 <20210119125639.GA7976@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119125639.GA7976@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 08:56:39PM +0800, Feng Tang wrote:
> Right! So this is better?
> /* Skip line parsing for non-existing indexes */

Of course!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
