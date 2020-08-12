Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8B2428FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHLMBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHLMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:01:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD69C06174A;
        Wed, 12 Aug 2020 05:01:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w25so1883233ljo.12;
        Wed, 12 Aug 2020 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8cTKu+htZubp78ZAwaP8QB3wTAzRATflGC/Oju/GBoQ=;
        b=PNs0HnXoIuQSavbuR0nZpPKuJBn7jkw38v5RX/DSe9X5e9VxM4THmkG34NZEXV1Omk
         OJ06uQdnDQ0ckzE2KoPkH2uanV08T0Zs2sNiK/1DdAYvs4bTU3ue+7Co0L5k2lfvQGcx
         scgluk9Xh0xuLEItbBpkfumfjOgz5Wa3Ibo+ShIC3BvUYpecSDjrlEJlWib90hAzu+Ew
         GShr3hJqmvcixrs+KRxCxo0k4lG2gEyf9M6ine7sHNWhSn0IynsQCRS3b4T8YGvX6s2D
         8c8T8TFrPFn4EFB72EoXpDHCNVJCC+pDZ0xwbC2Ex5XACAHpsTDDJWDGQr2bizuszpgb
         IoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8cTKu+htZubp78ZAwaP8QB3wTAzRATflGC/Oju/GBoQ=;
        b=M4WojzDUwUQbfHtLuCwCc9k85tHAuzffQV8rCpn42yLFMRqnu4+VVhVTd72Rhd57Z5
         f/clryR1DDh9DVPIPBPKDk4FnmTlq287FH7G3mocQOu/+0rmYHJDXfZtxcATl1dnlmNn
         3iklIrgm5vcHuse43hcZKpSyhIqXf9m7Ve0BZfviNvCkeDZhxRLEqU5Cpo8FjzQU5aYJ
         wKm/La5UQo8BMs5OgfXobIQSUCP4n89FH8OoFeMRJhZywrIGg1ijSgJ+fLkDMkGMuVkh
         uX/HcMJwktSU/P7R0GH+tLG+e27Z4DUIvohIs9uOe8jxtClKnr6qT8JVKtH277uu/QSQ
         3CBw==
X-Gm-Message-State: AOAM531/ajHzlA2/YkuITSfP6sk1CbDNPAZqCk4ql2uBCOh23O37FK2y
        VQr5ZlsKLlVyYmM+V//A76g=
X-Google-Smtp-Source: ABdhPJzYbg4UqNa6DvRtK4xe/DFexc1hdIB7+hv8LtGxv0zG6zIROOuT13ZFrpOtLkMp4cwkqsxHhQ==
X-Received: by 2002:a2e:b4e1:: with SMTP id s1mr4942254ljm.433.1597233666372;
        Wed, 12 Aug 2020 05:01:06 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y21sm395029ljk.129.2020.08.12.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:01:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 12 Aug 2020 14:01:03 +0200
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200812120103.GA17445@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
 <87k0y56wc1.fsf@nanos.tec.linutronix.de>
 <87mu305c1w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu305c1w.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 01:38:35PM +0200, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Thomas Gleixner <tglx@linutronix.de> writes:
> >> Michal Hocko <mhocko@suse.com> writes:
> >>> zone->lock should be held for a very limited amount of time.
> >>
> >> Emphasis on should. free_pcppages_bulk() can hold it for quite some time
> >> when a large amount of pages are purged. We surely would have converted
> >> it to a raw lock long time ago otherwise.
> >>
> >> For regular enterprise stuff a few hundred microseconds might qualify as
> >> a limited amount of time. For advanced RT applications that's way beyond
> >> tolerable..
> >
> > Sebastian just tried with zone lock converted to a raw lock and maximum
> > latencies go up by a factor of 7 when putting a bit of stress on the
> > memory subsytem. Just a regular kernel compile kicks them up by a factor
> > of 5. Way out of tolerance.
> >
> > We'll have a look whether it's solely free_pcppages_bulk() and if so we
> > could get away with dropping the lock in the loop.
> 
> So even on !RT and just doing a kernel compile the time spent in
> free_pcppages_bulk() is up to 270 usec.
> 
I suspect if you measure the latency of the zone->lock and its contention
on any embedded device, i mean not powerful devices like PC, it could be
milliseconds. IMHO.

>
> It's not only the loop which processes a large pile of pages, part of it
> is caused by lock contention on zone->lock. Dropping the lock after a
> processing a couple of pages does not make it much better if enough CPUs
> are contending on the lock.
>
Initially i have not proposed to convert the lock, because i suspected that
from the RT point of view there could be problems. Also, like i mentioned before, 
the GFP_ATOMIC is not meaningful anymore, that is a bit out of what GFP_ATOMIC
stands for. But i see your point about "where is a stop line". 

That is why i proposed to bail out as later as possible: mm: Add __GFP_NO_LOCKS flag
From the other hand we have been discussing other options, like converting. Just
to cover as much as possible :)

Thanks Thomas for valuable comments!

--
Vlad Rezki
