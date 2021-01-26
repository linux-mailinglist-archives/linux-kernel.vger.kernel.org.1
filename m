Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BE303BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404945AbhAZLoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404858AbhAZLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:08:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:07:21 -0800 (PST)
Date:   Tue, 26 Jan 2021 12:07:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611659236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkPU/hX7e8KAUGBs+8Xq5YFkeqG2HTJf4MGRstA6AwQ=;
        b=LOTtMY+pdaRCJZdqDkCezplZ9/BMaIWcDNsxGxhj94CLTHbHuUp3HyswBpFH1FN2MJPdGi
        61MfuHrBzJf4yQOm+6nby3m8VAi3BBb1McepZQ1M1kkxRj9xxV+oFZxbsqEguT589nNF5u
        XEvPVHmeQhCkPc6kzDoRCz1OxEwURtUepaHKDSzkbjJU32Jly8o3SgmhyYvSYqv4zrQa4/
        HSHgOT9BAJAgIoxq24O9f+0Z6JKjyzcggoXd2+YRVoWgytVQHXApbMk2QvQ8Eq8mRhYwo0
        n3dE3tFzcxB9O5I8+DWu2H5WMX2wqOVdGnFa1i9pqNtHplQYto2YkptDjJtv2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611659236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkPU/hX7e8KAUGBs+8Xq5YFkeqG2HTJf4MGRstA6AwQ=;
        b=a70BsVVvtj11dHf5ptAh7cMCsdzynscjtdvw5MMb3ErI/Q3ljLaTONjD5UE6pu2PSjcgLp
        mKYFa1Ua4HbpadCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        peterx@redhat.com, rppt@kernel.org, walken@google.com,
        yj.chiang@mediatek.com, tglx@linutronix.de
Subject: Re: [PATCH] ARM: mm: harden branch predictor before opening
 interrupts during fault
Message-ID: <20210126110716.wv4igts76n3kg3ch@linutronix.de>
References: <20201203092738.11866-1-lecopzer.chen@mediatek.com>
 <20210126091708.3461-1-lecopzer.chen@mediatek.com>
 <20210126105932.GG1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126105932.GG1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-26 10:59:32 [+0000], Russell King - ARM Linux admin wrote:
> On Tue, Jan 26, 2021 at 05:17:08PM +0800, Lecopzer Chen wrote:
> > Hi all,
> > 
> > I don't see any fix for this issue now(maybe I missed it..?),
> > could we fix this if there is better solution?
> > This issue exists almost two years.
> 
> I don't think anyone provided an acceptable patch.
> 
> The first patch moved the hardening out of the translation/section
> fault handling. Since the kernel is mapped with sections, these
> are above TASK_SIZE, and the whole point of the branch prediction
> hardening is to prevent the prediction in the kernel being exploited,
> missing the hardening effectively makes the mitigation useless.
> 
> The discussion in February 2019 never concluded from what I can see.

My memory is that I never got a reply which I understood.
Let me try again this week with the information above.

Sebastian
