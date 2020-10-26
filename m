Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE37298692
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 06:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769502AbgJZFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 01:46:01 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42975 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769493AbgJZFqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 01:46:01 -0400
Received: by mail-il1-f193.google.com with SMTP id c11so4075590iln.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPdTQ1PhfZhRRPXMROU07q6mswRw0Z2rrWcG2UvF3K4=;
        b=qi6Sj4Li60olorDiCltHElQhHrEOEUkilTwugUpbXAL5bEgaerax0LSJP052TT7FsZ
         ttIQoWdBRnRzpMMiDtZFobiVaj4CT+Wy3YZ9UKS1MYvSUC6dwhQIrXgDEzXUHulrUR6n
         YtZqsCxZfvkZsxvN29YRNKGrT5YF39ncILQ4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPdTQ1PhfZhRRPXMROU07q6mswRw0Z2rrWcG2UvF3K4=;
        b=JrAEHYtDcXcB00DVMqiT0e7XHjXQqV+/ceYCDABTDwNfXKdUS4l6JGfe/OZJzJ48k1
         sXPSJS95FlPWbUAw/eTDpjV952FKRPimeFyzTtD8d1CXuTHC0KvWW/QctHEMVx9GJDfh
         8p0uv7CIWks2Dn3nvjMaWECjI60m1ukwMuvnBHF5ADTVlmvi1L/8w7nEcD0519UEKwJC
         xysZrEoked4iKcYBLWuDUqKORqP8UnfIEMzTIl8MrqqScDP7gMRQ2/UerukVB0D1s/W/
         /4kETuKnX2Y4qDuw4cl8i6SKh8qLe6kYH6f7xpL5ONv7p3hlFBBcQwJzcLxmDg//M1iT
         kIrQ==
X-Gm-Message-State: AOAM531PsjE8JNya1h6thpqfxYXj9FMtStF7ax4huIB6AGY4bYnpsENQ
        VJRhmfRoxaUQj8oh6HWl5jRQ1Q==
X-Google-Smtp-Source: ABdhPJzxULDj+S29M5YgN9h83NkEIYBykH1HhRuUGajq9t05NEPOZUO8o7stxRu2lUnNE3b4Yz2tQQ==
X-Received: by 2002:a92:5b46:: with SMTP id p67mr7692480ilb.150.1603691158960;
        Sun, 25 Oct 2020 22:45:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id e4sm4835132ils.75.2020.10.25.22.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 22:45:58 -0700 (PDT)
Date:   Mon, 26 Oct 2020 01:45:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201026054557.GB4192074@google.com>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
 <20201026005058.GB104441@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026005058.GB104441@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:50:58AM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 21, 2020 at 03:08:09PM -0400, Joel Fernandes (Google) wrote:
> >  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  {
> > -	int i;
> > +	int i, j;
> >  
> >  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
> >  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> > @@ -487,6 +508,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
> >  		return false;
> >  
> > +	/* Accounting: everything below i is about to get merged into i. */
> > +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> > +		rcu_segcblist_move_seglen(rsclp, j, i);
> > +
> 
> Can you perhaps reuse the below loop to move the seglen?

Not easily, because we will need to store 'i' into another variable then, which
does not change.

Besides IMHO, the code is more readable with the loops separated.

thanks,

 - Joel
 

> >  	/*
> >  	 * Merge all later callbacks, including newly arrived callbacks,
> >  	 * into the segment located by the for-loop above.  Assign "seq"
