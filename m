Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02302FB84A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbhASMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbhASMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:07:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0170C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:06:48 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca001beaf3e1446171b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:1bea:f3e1:4461:71b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DADA1EC05EE;
        Tue, 19 Jan 2021 13:06:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611058007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPXx7ay2V44AgCssSyLw2TWN0kEvnnYpYLyIi2rGm9E=;
        b=VfgYL0z6AhrXAsCdTYExDc3qsl4GrIJx5YeHyG28zEDvLJP5MPmdhBUihH4Hz2uesBl7+f
        HVbxLA6k7FMZqSDIz7TqmfH7jSQai3jOAZ/5wU/hnxP0f2NrqYofRnn9xa0TN8eu0SOPyl
        M5JOobSpu2Jc1F7Iyvq5GvNya9vPZ64=
Date:   Tue, 19 Jan 2021 13:06:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 07/15] x86/alternative: support "not feature" and
 ALTERNATIVE_TERNARY
Message-ID: <20210119120647.GJ27433@zn.tnic>
References: <20201217093133.1507-1-jgross@suse.com>
 <20201217093133.1507-8-jgross@suse.com>
 <20210107190819.GI14697@zn.tnic>
 <5ed34a1d-86c4-ed03-4c92-b275a555c41c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ed34a1d-86c4-ed03-4c92-b275a555c41c@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:35:42PM +0100, Jürgen Groß wrote:
> In fact this should rather be named "X86_FEATURE_TRUE", as this is its
> semantics.
>
> And I think I can define it to the value 0xffff instead of using a
> "real" bit for it.

A real bit is cheap - a special value to pay attention to in the future
not so much. Also we do have X86_FEATURE_ALWAYS already which has a
similar purpose...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
