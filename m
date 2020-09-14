Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E92695C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:42:12 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99897C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:42:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v54so1034530qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bV57W/EOWURMleEzGNWcf5dyMu6bebp1Bh//1ts4NWM=;
        b=ycFv4BvlBYEkf4hQQlNujtn6QNIE5wc63ULQhK/2rdi3VgfJU/q02dwetcIo2piGTH
         rh/aYu1xqMcmOyvTuxx+ofXk9NejE5iYqXBRPCZv1yZGAewKXIe8FTxOdG7k/J6M1sxE
         7G4lDmw6QFHiyI5TTTVyysspAIwYVgx7l5jrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bV57W/EOWURMleEzGNWcf5dyMu6bebp1Bh//1ts4NWM=;
        b=HFCdX52RxCW2SDV3A+X1WtC1YlGFNCOwKeN6njn0fM3+dxv15xtG1AyYvnkGKArp1I
         8+TQG8Aobb2W6U7ygFBJbWm26nmEc/JU3vwCjwSBDemco83VpA9OA1e7hpxTcbnTxnIe
         xO5n5YU+l7P79+ubxOev7GJlE1QNdhx6FwWKN8UhW35kG5VrXAm1g0mKfuTT7OfKV3gz
         frQJd2Hpv+I8sW+VfUgvch4IJTVxwtBYAaJGnUkTB8gjFuA171fR0gM0ZDV/D4BXWAGR
         BdRwtyGZ1d2pLONDni8Dkj9dvgCZSH5DiFr8yZIGQrFAK5sap0AP93j8yWnaRAvMWVhT
         Acmg==
X-Gm-Message-State: AOAM532gP3qmMnlbY0GLsV2MaFNrrzMzq5Awsfl7SC4uAyxQntwchFpI
        zRrxh++vczsbKZOPJ1M/WfDyS0YrRhj31A==
X-Google-Smtp-Source: ABdhPJxbhI7ln6hIC6I1YHJZhDkQq9/+B5olyYYdwWGSbKtZqDX4OuVuBiAuMqDC7ZA4iMYVUGfbAQ==
X-Received: by 2002:aed:38c9:: with SMTP id k67mr2489411qte.6.1600112529305;
        Mon, 14 Sep 2020 12:42:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k68sm13520108qkc.33.2020.09.14.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 12:42:08 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:42:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RCU: Question on force_qs_rnp
Message-ID: <20200914194208.GA2579423@google.com>
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:55:18AM +0000, Zhang, Qiang wrote:
> Hello Paul
> 
> I have some questions for you .
> in force_qs_rnp func ,  if  "f(rdp)" func return true we will call rcu_report_qs_rnp func
> report a quiescent state for this rnp node, and clear grpmask form rnp->qsmask.
> after that ,  can we make a check for this rnp->qsmask,  if  rnp->qsmask == 0, 
> we will check blocked readers in this rnp node,  instead of jumping directly to the next node .

Could you clarify what good is this going to do? What problem are you trying to
address?

You could have a task that is blocked in an RCU leaf node, but the
force_qs_rnp() decided to call rcu_report_qs_rnp(). This is perfectly Ok. The
CPU could be dyntick-idle and a quiescent state is reported. However, the GP
must not end and the rcu leaf node should still be present in its parent
intermediate nodes ->qsmask. In this case, the ->qsmask == 0 does not have
any relevance.

Or am I missing the point of the question?

thanks,

 - Joel

