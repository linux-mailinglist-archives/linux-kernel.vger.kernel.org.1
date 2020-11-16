Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0302B4D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgKPRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbgKPRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE8C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605548227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7ZouNJFvgWv5XQbSy0+GjGZzP06Ph3h/0kXm5/LCS4=;
        b=hUJ303smelPk5cG1KgJO8dL1pMsZibhbkOJa9SnEEOi2N8GVW3WEAjbiXRLopYPMC9YOoF
        oDvqyZpg1JZClyg/ByrdStjg5Val+CFXlRKwKwP6KzWNY4gADoc19++esxdeR5SMQRuR8d
        9r/6WFYm+yALpeNEFHP3MOjX2+YfLb1RO0K3oJR2G7J2wIp5OaLU6p+l2Smes2ZpSud6LJ
        JuiDX3O0hZzfMdhnVnSdDSGJxP2kFkoZrwe+F1eeqtpXg2mZQPpfSKhTS0rSQuDA8VskjI
        gy1FPkB0Ddei89+C7w1lMCvHl/QH8J3TasWdsVcXkTfe6mQ5DQ1qx17hLTCBEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605548227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7ZouNJFvgWv5XQbSy0+GjGZzP06Ph3h/0kXm5/LCS4=;
        b=v877+b3OBeQTYjmHLL4J+iqF6JGs6dyH2RJQq5vkZ/QGkaSnBvBfhooYuSFZuFgBMHg3T6
        SzNPvggXD9ZZfNBg==
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list\:TENSILICA XTENSA PORT \(xtensa\)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
In-Reply-To: <CAMo8BfLFZ_X8y1XLZnBb-VkOPMhXT4Daau9ydKAU9L_64Zap4w@mail.gmail.com>
References: <20201113122328.22942-1-jcmvbkbc@gmail.com> <87zh3ll6hw.fsf@nanos.tec.linutronix.de> <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com> <87sg9dl3xk.fsf@nanos.tec.linutronix.de> <CAMo8Bf+2kGmg_SvJz8R=qXgPWbYWmf-PSeG71xKe5AB2LeyZ4Q@mail.gmail.com> <87mtzklwc7.fsf@nanos.tec.linutronix.de> <CAMo8BfLFZ_X8y1XLZnBb-VkOPMhXT4Daau9ydKAU9L_64Zap4w@mail.gmail.com>
Date:   Mon, 16 Nov 2020 18:37:06 +0100
Message-ID: <874klpyzi5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max,

On Mon, Nov 16 2020 at 06:47, Max Filippov wrote:
> On Fri, Nov 13, 2020 at 2:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> I agree that the top down mechanics is not really intuitive, but that
>> does not justify the ifdeffery in the generic code.
>
> But then maybe xtensa did the right thing where everyone else just
> copied the not really intuitive implementation? If nobody else cares
> then maybe generic fix_to_virt/virt_to_fix can be changed for positive
> indexing?

Which requires to change 9 architectures instead of one for a feature
which is barely used nowadays and which we rather want to get rid of.

Thanks,

        tglx
