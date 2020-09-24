Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402A9276C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgIXIeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgIXIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:34:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6FAC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:34:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600936463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtegJ8fVIFuCiOSfvGCiHOL/tiQeXSNyiBzMrNmz3DM=;
        b=ALWdNLiF/9XHvH8mcviSPCyUYMGoxx7vJ4Exfpj8HAmhe0BXbXunVcTOP2pUhxLKrlCCYy
        dETzD3EgQhy0ovJD08+ihCj3K+a0uQ+YXNJOdGEHgxG6Cn7Ax9auc+iTdGpobCDJQTA9fj
        V+AnVp5KJUnGlLuc56O19H0OS6cgsBkxSEbIQ5yRvrVRz1H74hdVytvizOD0ea5KnPnuag
        QQT8LD4p0g3H2P2ShU958W90sr9AS+8RhMC6eJX5HVJswrKSkozXTCLC3kXlazD2oq0FUJ
        2YSuJXdiv08ym1hZWVGm5BEHnZ7ieC/f0FUnGTb9lMNyk4bZ6TfO4CRclZJOaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600936463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtegJ8fVIFuCiOSfvGCiHOL/tiQeXSNyiBzMrNmz3DM=;
        b=NxKa9LzJQRH5vBdmfQQlaud3qx+yn7OoI+hi8dZwRTkHtHlhXbawFM5H/2Vs+SEM5pvcj8
        4UEpTBi14MGw9IAQ==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: Re: [PATCH V7 1/4] softirq: Use sched_clock() based timeout
In-Reply-To: <20200915115609.85106-2-qianjun.kernel@gmail.com>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-2-qianjun.kernel@gmail.com>
Date:   Thu, 24 Sep 2020 10:34:23 +0200
Message-ID: <87y2kz8tf4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15 2020 at 19:56, qianjun kernel wrote:
> From: jun qian <qianjun.kernel@gmail.com>
>
> Replace the jiffies based timeout with a sched_clock() based one.

Changelogs have to explain the WHY not the WHAT. What the patch is doing
is already in te subject line and the exact WHAT (implementation) is in
the patch itself.

This applies to all 4 patches in this series. Each wants to have an
explanation of why this makes sense and which problem this is trying to solve.

Thanks,

        tglx
