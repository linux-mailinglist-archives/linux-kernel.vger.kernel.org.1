Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B62B39DD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKOW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:28:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgKOW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:28:19 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605479290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aCVZT0RB6+oi1VWVJCZcccG/G67XqRX9rnw94MVyt48=;
        b=fy9Ht8N0vPnGo4+FXDiJJlQcBWvtM43kSPQxu52DLgwbVblugCikHP0tKKV0/wy/9nu4dZ
        IxICeC8on0PvIO48Dtad0vxV1Cq9TkZxX0mFJp7xidaY1DGzN2ou4YOyQTYLLdcSqe8c+Y
        +WfnbvPM47oYj/SvUePyByCyG59IXOvOU+UiqsXrqf8hUmbflGRj9Fel7SjJ9TBP5l/CMy
        RzM+apg5CejT4SPfqVZ4T13jTiUlpdiXwjzpLzTjDzXshlThlRJHjftwOvd5V3hn1P4XJx
        CHzE4FIscyiSSG67GEIvd67xsRlGoHZiyt5aoRRk12X/a9Cp8xN7aDR0RImrPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605479290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aCVZT0RB6+oi1VWVJCZcccG/G67XqRX9rnw94MVyt48=;
        b=K8eMTuvY8xPsDZzP6Po0hLshFq7mz5aMX3B6N4LlwgD9mMZvG4VlINkFrCTms0ZNGk1NVr
        5kXiTzDYka4HdpCg==
To:     Alex Shi <alex.shi@linux.alibaba.com>, john.stultz@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] timekeeping: add kernel-doc markup for pvclock notifier
In-Reply-To: <1605252275-63652-3-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com> <1605252275-63652-3-git-send-email-alex.shi@linux.alibaba.com>
Date:   Sun, 15 Nov 2020 23:28:10 +0100
Message-ID: <87zh3i45mt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13 2020 at 15:24, Alex Shi wrote:
>  /**
>   * pvclock_gtod_register_notifier - register a pvclock timedata update listener
> + * @nb: a notifier entry which register on pvclock_gtod_chain.

What is a notifier entry? The struct is named notifier_block and the
argument is a pointer to a notifier block. So why making things up?

Also it's completely irrelevant for the reader to know about the name of
the notifier chain. The function documentation says:

         register a pvclock timedata update listener

which precisely describes what the function does. pvclock_gtod_chain is
an internal implementation detail and nothing external can depend on it.
It could be renamed to 'foo_bar' and the function would still do the
same thing.

* @nb: Notifier block to register

is precise and good enough, isn't it?

Thanks,

        tglx
