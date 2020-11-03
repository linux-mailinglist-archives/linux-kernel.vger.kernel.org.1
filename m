Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4742A4900
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgKCPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgKCPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:07:40 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC19C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:07:40 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id i17so5808180qvp.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4n4eKbeBF029LZEVM8Tx6GsjHib9jcrVPlcNT/Y/Yx0=;
        b=NSZmoJN8BVndRdwEMQQd1+hTP/RRmifn9wf265YZzYwbSlBwPLhY/7F+PPW8+Y/68Z
         WhaRUJ9ki+KpWXZMu3+oEIcJ3fB2Gebdj/gTiMHYKlV8qP+I6Q7s1tqR8f9p+oMu9ftV
         5LSvV7PyTDq2NTyClPrKeEVZGckDJ2mmhvauo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4n4eKbeBF029LZEVM8Tx6GsjHib9jcrVPlcNT/Y/Yx0=;
        b=Ikkil5UmRD1O65DARgxMC5Pv85pEhrsfad0/wyv2mowa9a/6LQ6GMKRC7Iltz1rb7l
         p2V5Z0a8cImtBHcauW9vxUtNIySM5uo4NUXkzT0YyItwYz7kBp2l8MDTrQGwsIRdwFp2
         /TtP2r6RKRWL6KXff7dGGdlwl+4gOo70Jt05wEUwt4MSbhi1doiitz/nIAsa576PANGZ
         fO8yAecNE7BGSI4wIkgYz2Q5HuN+gGEjSlhFQGm4lW6PfT7CdQ9K4kPofyVMXjT/pZFu
         QzXxXr0WYMhoBg38EU3BwZUhuoeXbL7iMUcd22On64dR9Oe6kH5mt0D1vNBCeEXRIdgQ
         Nl2g==
X-Gm-Message-State: AOAM530Wh7kIQAFJWK+CIXakjXUj7f4/BFbhtQU67i7iFqrlx6OImdPw
        o6uPFxeAnAdR04Qb7Gw7Flmu8IVIy8uJpA==
X-Google-Smtp-Source: ABdhPJzzlcDLLdFjM34pMHGZgTdfKu/8EkQtfR2uV18EK3dvw/pyiibGX7BzyhFs4My2qNIiqkFtUA==
X-Received: by 2002:ad4:4985:: with SMTP id t5mr25591422qvx.27.1604416059573;
        Tue, 03 Nov 2020 07:07:39 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c6sm4857206qke.35.2020.11.03.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:07:38 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:07:38 -0500
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
Subject: Re: [PATCH v9 3/7] srcu: Fix invoke_rcu_callbacks() segcb length
 adjustment
Message-ID: <20201103150738.GB1304393@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-4-joel@joelfernandes.org>
 <20201103144714.GA432431@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103144714.GA432431@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:47:14PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 03, 2020 at 09:25:59AM -0500, Joel Fernandes (Google) wrote:
> > With earlier patches, the negative counting of the unsegmented list
> > cannot be used to adjust the segmented one. To fix this, sample the
> > unsegmented length in advance, and use it after CB execution to adjust
> > the segmented list's length.
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This breaks bisection, you need to either fix up the previous patch
> by adding this diff inside or better yet: expand what you did
> in "rcu/tree: Make rcu_do_batch count how many callbacks were executed"
> to also handle srcu before introducing the segcb count.

Since doing the latter is a lot more tedious and I want to get reviewing
other's RCU patches today :) , I just squashed the suggestion into the
counters patch to fix bissection:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/segcb-counts&id=595e3a65eeef109cb8fcbfcc114fd3ea2064b873

Hope that's Ok. Also, so that I don't have to resend everything, here is the
final branch if Paul wants to take it:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/segcb-counts)

Thank you for your time, Frederick!

 - Joel





