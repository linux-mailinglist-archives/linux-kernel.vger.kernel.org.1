Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3542A48C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgKCO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgKCO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:56:53 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D7C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:56:53 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id s1so7818515qvm.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yYv8SzeXH9sTex0t/oRWNoHgyhhHpDNOQ4Uo+mWi1jc=;
        b=vjbyIUfHDeeytDwg7aODBT1BcbVT18wVvaazIoQfCN/hHJj9ibtSmyeZ31i+Lha9aJ
         QVpDv9sUHKByvNdl+r4gpaXQHYauF2EEms7PKaYcRnAh+LFoHruzLFi8eEPnu2OhiAUo
         FjVxfEVnnYi92HGiUg3+kdbw/Ck6smrgNdRpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYv8SzeXH9sTex0t/oRWNoHgyhhHpDNOQ4Uo+mWi1jc=;
        b=Q7XRdC73aJP6j6IPRUUv9a3P0EhR58NWODM7WfUP5gw85IRC8ktRii/Hd4YrKWcyWb
         DsXWQ150BlAqe8CNCkQbSnR5J/ZPckGU0mkQlCNUs6hqpDerlww+Y+UcoIgw9FwOs0Ir
         aZEg4ufeb+j4MoN+T6YD4eRy7vCtvQf2Q/c0M3Wf6bghqlr1zLOwRSuW0rkpcN3ASHQw
         Zk/aOmA7BhPXMRvgvgX/BIKgCo5otzZIMGdBmMoOLffMiAQslnOe/mTsgVcC+rj4E/6W
         0CBjdEjo5aM1pFB00ZW2MdkbX4w2EKlYxgiPTRYuMyRWuIHxo3fBu6dBuXTq5mjMhXCd
         9ZPg==
X-Gm-Message-State: AOAM533FrAgUuEhJ3mEGAx+k110MacrujYYzv/n8tOGDtRU10w8Ztao3
        CmBgoJBj9fUK9Sp2pPUvGOTg6+q/r5xqVQ==
X-Google-Smtp-Source: ABdhPJzlobLYzUix2OUj3ncE0UnNkquvmZvj3PWMrzaFKHyR87dV0gs1iLUi7GMioMNq5yH23FLH9g==
X-Received: by 2002:a0c:ecc8:: with SMTP id o8mr26872223qvq.54.1604415412463;
        Tue, 03 Nov 2020 06:56:52 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t70sm10299175qke.119.2020.11.03.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:56:51 -0800 (PST)
Date:   Tue, 3 Nov 2020 09:56:51 -0500
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
Message-ID: <20201103145651.GA1304393@google.com>
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

Right, the latter is better. Let us do that.

thanks,

 - Joel

