Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53C243AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:27:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD8C061757;
        Thu, 13 Aug 2020 06:27:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597325235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLyLSUGNtgpJOrlFymmeq1eXF9NowSd0reO+cbW3gxk=;
        b=XXN6iCM9IfvwUhlJiBUdZ3gFD8uaSxhzOMBhsKu/Dfw0uu90UWdvgLoOn7Y6bnNmCCsH1D
        ShHUIaH6w0DGTWeS8LBkdcBqeVyVGaxR9snEoXvhlICmb37h/t12c/YVYIc5YPggKuAalV
        FDrDCwa/842BgH4nEgnFUCDSAozG1oECXUiBBSSrIg6/vTJRfuHVDSX/WcULAOZJBU6DhF
        8Z/42GuFc/UGtV2XYuzJ/L/v32aQKNBnkzvJtki4JvZRYU4UbHbf4cgCG4MpypuzvKR3TT
        9OeORr6GB2LLBnhNJGoc1qmHOnkixLatWxkX1Lj/5t1UJJdLw89b94BxMsjn3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597325235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLyLSUGNtgpJOrlFymmeq1eXF9NowSd0reO+cbW3gxk=;
        b=cAskV80QNABzVTov1TRBknTMX6D3WbNDcEdhhj1hgOnsbOzunBse2vBp7OVAy21hhgkEbi
        fI7dyxBdcY1kmqBQ==
To:     Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200813111505.GG9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200813075027.GD9477@dhcp22.suse.cz> <20200813095840.GA25268@pc636> <20200813111505.GG9477@dhcp22.suse.cz>
Date:   Thu, 13 Aug 2020 15:27:15 +0200
Message-ID: <871rkallqk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:
> On Thu 13-08-20 11:58:40, Uladzislau Rezki wrote:
> [...]
>> Sorry for jumping in. We can rely on preemptable() for sure, if CONFIG_PREEMPT_RT
>> is enabled, something like below:
>> 
>> if (IS_ENABLED_RT && preemptebale())
>
> Sure. I thought this was an RT specific thing that would be noop
> otherwise.

Well, even if RT specific it would be still something returning either
true or false unconditionally.

And guarding it with RT is not working either because then you are back
to square one with the problem which triggered the discussion in the
first place:

raw_spin_lock()
  alloc()
    if (RT && !preemptible())  <- False because RT == false
    	goto bail;

    spin_lock(&zone->lock)  --> LOCKDEP complains

So either you convince Paul not to do that or you need to do something
like I suggested in my other reply.

Thanks,

        tglx


    
