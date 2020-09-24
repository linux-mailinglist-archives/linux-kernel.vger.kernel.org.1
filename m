Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5227781D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIXR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:59:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:59:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600970393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJehfIcmNapZF7M+n/Zfc+/KkGD2QoqI4n84mPsCzgg=;
        b=iWL1mEU4I4V8xP0PdlbB8DatztKp0+2gq01ao9IGOa0+jFBPYkLltmEJhAMAvThXobu5Qd
        RPjb1eXqcrzkdz3r8tWtD/uFr/amimvMYA7szMGaIRQsCsMG5wWzS/3dvosceTChu+vrnB
        a2K7CCoWpI642U/4laIrlPptcT19M4tcLLNF/bQh9gWqw/pQDoLXyhwYZazfxAV/p5wWOg
        hU59C9LR6Dn9IvRESySg5+h+NFJ2sh70re1sC5aWM3wxYJDZoXwValv3OYhjBDgRZZWgml
        P+99cT2J3miivSocLqACNZy0ejiWK71E585Ni+GUTFlVsKylByD1JsDKvX4N5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600970393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJehfIcmNapZF7M+n/Zfc+/KkGD2QoqI4n84mPsCzgg=;
        b=Ls/+icVj7dWLbhhe35jdGlmS/WmPZISu/jJkDewY2Eije9AUG+y5M++U/ztYjTsShnJbNC
        g0FLaosFp4FNxwDA==
To:     Muchun Song <songmuchun@bytedance.com>, rostedt@goodmis.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org,
        romain.perier@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] tasklet: Introduce tasklet tracepoints
In-Reply-To: <20200905060412.88560-1-songmuchun@bytedance.com>
References: <20200905060412.88560-1-songmuchun@bytedance.com>
Date:   Thu, 24 Sep 2020 19:59:53 +0200
Message-ID: <873637838m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05 2020 at 14:04, Muchun Song wrote:

> Introduce tracepoints for tasklets just like softirq does.

What does softirq?

> In this case, we can calculate tasklet latency and know what tasklet
> run.

I rather see people working on removal of tasklets.

Thanks,

        tglx
