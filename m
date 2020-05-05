Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE141C5FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgEESR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEESR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:17:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:17:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so3320807qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIiFqeYteULkt8HMXHFpwisB9MG8IKcghiZqCMsoJ0I=;
        b=g0cWg6SkdohT/vZF+L3QxQRRKnCQYIjurKEE6hl5xzqEYuQiqBcmUrC+JQPXp8O1TN
         HQSXJxGfRGkqYGXiM6V9+JhCYn6OUadVtrBqlrMuvKhLKncFXEj6eRvKcqeZ6QP8wVf9
         4h81ocOjTyHlbB1rWLIF47faxU2noJt8Gbcd9t7B7URgQvKiEtgcZ42A8EyZQ00/m2/C
         Wc3ewrATPCp+GxMnOMzHhY55vcuFBhXQhipjo3J2w2VsG85e47AtrUSQx9UZA6qvRmxC
         RApjwNKqE7U0DrElZuV6UF3sZKup1FaogxFi1ccOpTiR6MINHEgiBrt1AqsZRhR8KGj/
         84Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIiFqeYteULkt8HMXHFpwisB9MG8IKcghiZqCMsoJ0I=;
        b=Fzg1A831usB/9hDY7hwKNVonA6qaJibyffofTAVo2j1G1U6JW0c7XhVtaY+5HN1Ch+
         MmJ3misgnPngHnTgjBHCtY5nwoQTfmjCLJrfFVYGXIRiZuq+a0J8oPslfkTF10PXZIgO
         MPdED3c9DrpQXWpverLNKU7U0DXawsfSk0cJEyYxcNnHp/oAbLpczbiVuHD7JtBaiCT4
         w29Nzkzc0IezlXKIrMfBCwYD80oETLR0I1xQ9ZVH4cUQUnlonCYnS9KtpqsDAzNYIIgJ
         yFIKUAlx9YizE6WNdHdzQpMzwpK9Oc50uzHh1sA3lkD8SnjAejkX0E5E/HUnJFnJaii4
         TrjA==
X-Gm-Message-State: AGi0PubUxKSbdp9SICaK5CCPb+K1unFMTteOHUiHRrYfQMtp8sIHA5i1
        v/BHdQcM2yYWAb6KeE1JPvPhLQ==
X-Google-Smtp-Source: APiQypJpAEYkFq2pucmgqMDdD7u0YkaYfB8Yx+SoZ7vYqW8xB1eQ6l7p5WKDojX4s1Ivx/jdf5bZmg==
X-Received: by 2002:a37:9d55:: with SMTP id g82mr4120636qke.407.1588702678150;
        Tue, 05 May 2020 11:17:58 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k2sm2602061qta.39.2020.05.05.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:17:57 -0700 (PDT)
Date:   Tue, 5 May 2020 14:17:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200505181743.GA109369@cmpxchg.org>
References: <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org>
 <20200423180249.GT17661@paulmck-ThinkPad-P72>
 <20200423182750.GA32451@pc636>
 <20200423192115.GV17661@paulmck-ThinkPad-P72>
 <20200423195955.GA476@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423195955.GA476@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:59:55PM +0200, Uladzislau Rezki wrote:
> b) Double argument(with rcu_head)
> This case we consider as it gets called from atomic context even though
> it can be not. Why we consider such case as atomic: we just assume that.
> The reason is to keep it simple, because it is not possible to detect whether
> a current context is attomic or not(for all type of kernels), i mean the one
> that calls kfree_rcu().
> 
> In this case we do not have synchronize_rcu() option. Instead we have an
> object with rcu_head inside. If an allocation gets failed we just make
> use of rcu_head inside the object, regular queuing.
> 
> In this case we do not need to hard in order to obtain memory. Therefore
> my question was to Johannes what is best way here. Since we decided to
> minimize reclaiming, whereas GFP_NOWAIT wakes up kswapd if no memory.
> GFP_ATOMIC also is not good, because for (b) we do not need to waste
> it.

Waking kswapd is fine, because it's a shared facility that doesn't
just reclaim on your behalf but on behalf of a central goal: to get
the freelist back to the watermarks. If they're low, somebody will
sooner or later kick kswapd anyway to do exactly that.

So unless you ask kswapd for a high order page that is unlikely to be
needed by anybody else, you're only doing the inevitable.
