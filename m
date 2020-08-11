Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABAF241DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgHKP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:56:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgHKP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:56:30 -0400
Date:   Tue, 11 Aug 2020 17:56:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597161388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8c8pkqGwrb51oWZfGypKhgzPBk4tDPq9OqUMb5M1Ws=;
        b=gouB0RbVYfcv0nS3Fu1yr2utgTC/gJtdlJV/JwZhWvc10eSQdiAP+ynOw3SfI4ZLchDaTi
        jf9umUeFWI9G8aiGIVXMwXdetMOLj80aNpKhd4tfPyym3Pp+7esD9LNedVA80etGiGD+gG
        PLAPoiOCCwYPjOlfXwc6hmDY3y//ex944BNksXvFyOxVrDSvt6d3XtbHJiiH8Usfk58yEJ
        GOWELOt7NHghllDF27Ieg+n8df3YIon57CSUr2s7YhRd+cwaVOcxmb0xeEo9RiISv5ijhu
        mqjOzo+lxeiO8sbMz3YpQOPWMAN/XkJuHhgLL3CHdeEqaMWr9HD4FLHsU5+X/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597161388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8c8pkqGwrb51oWZfGypKhgzPBk4tDPq9OqUMb5M1Ws=;
        b=KHIRUkBTbgou7Gab+cfKR0htx01eDtqS/sAgxNm286erHcmJYYhaliWn6gtv3ts31YhgqM
        fQSs4DZgr0/Xc6Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811155627.npamhwvyhujab7qu@linutronix.de>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
 <20200811153327.GW4295@paulmck-ThinkPad-P72>
 <87h7t96ve3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7t96ve3.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-11 17:43:16 [+0200], Thomas Gleixner wrote:
> Where?

See commit 8ac88f7177c75 ("rcu/tree: Keep kfree_rcu() awake during lock contention")

Sebastian
