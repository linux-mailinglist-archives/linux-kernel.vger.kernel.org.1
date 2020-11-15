Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39E62B3A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgKOWso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgKOWso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:48:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA9C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 14:48:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvI/MPpO2yHiyMQEPaqhGRdRCDf9SD2sDa51lvpJV8A=;
        b=HF/JMrCYSy9xXT8qOB84LyWBgI+6fTNiUiua0wr9u2SESR7Pti0kLjpRo83JYl3EvMkAMC
        z9VHBRhk14NY9WlH0DNtSLwTFFJvv6hv90hpB2u2Oeukx+9OVbL30au9JNqj6JEycvdVi/
        D2yPTt8hLS9fZsGx7dkVwdAd+9JI3ysqz9TF5e3ZzLCGLIdpwMvUnm4Rmb8rGCZrij0A/l
        WWmdnLe1FN1OOhv4owzw4fdfEieebX8Cc241VJIlXfd60vhvDtl4dwwnkxqzVx0uBdhx35
        SU7Dkvi4Tj/PamtkZXlqrn6vDoUT6T9Ah+VyywwPbSKIImP7rvEcBGCx3POijQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvI/MPpO2yHiyMQEPaqhGRdRCDf9SD2sDa51lvpJV8A=;
        b=s2Vzt5YV3ALfB1maSdjQT5KqTuuUBr6HMzJi8jLUWQs2Il4q/IAlJtpFAIwfRbiyFrF6gF
        UfgjoRilfl1w1vDw==
To:     Alex Shi <alex.shi@linux.alibaba.com>, john.stultz@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] time: fix kernel-doc markup
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
Date:   Sun, 15 Nov 2020 23:48:42 +0100
Message-ID: <87wnym44ol.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13 2020 at 15:24, Alex Shi wrote:

> The kernel-doc interface error cause some warning:

I fixes the lot up and applied it. Please look at the changes I did and
be more careful next time.

Thanks,

        tglx
