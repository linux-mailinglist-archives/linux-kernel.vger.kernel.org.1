Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E021EEA65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgFDSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFDSjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:39:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DC0C08C5C0;
        Thu,  4 Jun 2020 11:39:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so8632381ljo.0;
        Thu, 04 Jun 2020 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Q/ce7fKWUL0s8qvvjbmoZjoyGz/9VTtrwk7OIonRS0=;
        b=Oe7vA6DPMtrxABtP+GfxI19vl/Np0zAoJ3rQVrPyw3dmLRNsP2ttlHE1R2QMJR6tGj
         gSecfgdkWzxznF6+OQO8LO3/ISzfkTLJoqUnXEXvGsMFoaQgvUZia22V9EkwE+Hhi3tQ
         JO1TRBRtB7c7yQrmwSBw2pfw+mz1Dnz8iGnEdDR5cLj2uTWaS9pWEdQfTFr1Z3L9vbDA
         MtXnCKWjyBwc+JtFSRDyMqHngGQxIaHv1qpjz+9EwwcVDLqwC/bq2vMJ8Ic1XWLaqa8o
         UoZNl78xswtdxfSayg/502LLf76dk9vg/YDFdVgQcOELB19l3dGFSj50fNpj7w1V+sIu
         ADqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Q/ce7fKWUL0s8qvvjbmoZjoyGz/9VTtrwk7OIonRS0=;
        b=hMONEWFgYcRJNsIWd9VWN6V+WrE2ZkB3t+U6sX+0LkdMS3BzTCvO2E0qBIeD1o41W2
         QJQzSBmj/GzP1RUxYLRdZAlTHutV1nAI8sNg4dpoeKRIVHtMcioJmEWGb2wAOTY4jWus
         Jfa4R68UYKF0RTIWL4L/xCWq4Fh2mPDt83G6znZkiTMwKckC4q6WzwlAolTF2FjCqfP7
         0iz9ihC9Q4/insu7QmwWZJiTowbjCw1NXhcq4MRhoZtCL/PcW8J2zx3tYbNBnrAjqh79
         A6VqLQIMtU8m2kdEMhgSCb586AgY4aflrukZEbadg1S+oePkGP8pzHsJ4EEvQ8YcCReJ
         s9rw==
X-Gm-Message-State: AOAM530hp31aIQO2kKf2gv72LqxEi9IliM5Zs22Qc+IIqRZCPtPcoNkw
        Z8k/scuzOByiHf8UaX9CHW4=
X-Google-Smtp-Source: ABdhPJwoA3DeXT6fj2z00w4xH93nWSIkOISXuObAIqJFwXHmR+1sygKwnnL4iCmN7If2mWM9jrGSLQ==
X-Received: by 2002:a2e:9a81:: with SMTP id p1mr2617188lji.119.1591295972392;
        Thu, 04 Jun 2020 11:39:32 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q15sm96025lfc.44.2020.06.04.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 11:39:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 4 Jun 2020 20:39:27 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Stop shrinker loop
Message-ID: <20200604183927.GA26933@pc636>
References: <20200604102320.15914-1-peter.enderborg@sony.com>
 <20200604134255.GA24897@pc636>
 <20200604163100.GB29598@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604163100.GB29598@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 04, 2020 at 03:42:55PM +0200, Uladzislau Rezki wrote:
> > On Thu, Jun 04, 2020 at 12:23:20PM +0200, Peter Enderborg wrote:
> > > The count and scan can be separated in time. It is a fair chance
> > > that all work is already done when the scan starts. It
> > > then might retry. This is can be avoided with returning SHRINK_STOP.
> > > 
> > > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index c716eadc7617..8b36c6b2887d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3310,7 +3310,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > >  			break;
> > >  	}
> > >  
> > > -	return freed;
> > > +	return freed == 0 ? SHRINK_STOP : freed;
> > >  }
> > >  
> > The loop will be stopped anyway sooner or later, but sooner is better :)
> > To me that change makes sense.
> > 
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Queued, thank you both!
> 
Thank you, Paul!

--
Vlad Rezki
