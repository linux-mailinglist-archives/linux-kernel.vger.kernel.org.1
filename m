Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591212692FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgINRWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgINRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:21:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:21:16 -0700 (PDT)
Received: from zn.tnic (p200300ec2f092600cf1eb17cace34abd.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:cf1e:b17c:ace3:4abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5265C1EC0572;
        Mon, 14 Sep 2020 19:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600104075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EQsff9eLIwXbpJL6IQRbgmzVwe3cFJypRxUOn48LrGY=;
        b=IjM1ACpKjY0MaVmVpe98YSOE/ZEOMrqf22+ZZLB6xwRKxBlhNLqFl8JQbKo9p6FsNtLLSn
        14I7wUHT48LDdmsDgazI0lmeFCr+cbGV3dwmT3PpN+gjjUopXJJkM6MhqHzloDp4TVfdcD
        hp3kzKnoTWkJDg8z/5P8D7E0/1bLCAI=
Date:   Mon, 14 Sep 2020 19:21:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] x86/mce: Stop mce_reign() from re-computing severity
 for every CPU
Message-ID: <20200914172107.GE680@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908175519.14223-2-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:55:12AM -0700, Tony Luck wrote:
> Back in:
> 
> commit 20d51a426fe9 ("x86/mce: Reuse one of the u16 padding fields in 'struct mce'")
> 
> a field was added to "struct mce" to save the computed error severity.
> 
> Make use of this in mce_reign() to avoid re-computing the severity
> for every CPU.

Yah, could go as a standalone optimization...

> In the case where we panic, we do still need one call to mce_severity to
> provide the correct message giving the reason for the panic.

... but pls do not use the "we" formulation as this ambiguous. I'll fix
that up now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
