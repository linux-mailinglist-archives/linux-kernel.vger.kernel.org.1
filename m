Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08FE2C2E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbgKXRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390747AbgKXRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:09:26 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB03C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:09:26 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so16610658qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QEMX7b5mpMblIzXSQJkvTIsCcjYRDagRkMNRaojL7BY=;
        b=eahESHQt0XDJELoA7oRaEI8mo6EmgBLvYoqIJh5LQ2m5Dz6cSL7b7CDA0kHzirIEDe
         U9IbLkF5OP0D+ziUgLh6yPin3bZYBQmvvSWzb95x1HJu7ryUQezlP7qspLvrzUb6Qje7
         Bqc5WPrAHAvx/FuE2DUwFijKqDMG3epV5sdkQny4qK49Izeu4wSLj8pyDbrN+lm8eEcU
         prqTtLWADSwcW/dRYVTIfCqQFwtSAPNlFVHKaE0Q9nbKCZ925c64uGEQHQa2rjh+5MnA
         vEwjQkJGMiRb8Plo49gq3Asz7BtbaTuh5yib5O55Cbj82QsWojhzEdSD6WWdHMwFuKCk
         6juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QEMX7b5mpMblIzXSQJkvTIsCcjYRDagRkMNRaojL7BY=;
        b=WVV04oCJYSK0iWLTwDhYP/NtE8sHW1KuB4c4MFe7f9akhczbg9vrO8RX1tc6I0+jWr
         8YJtYUyRxyuRuM7cRPlgVDA5U1TIHBegm4WugBIl1ZBhvD7xdnbw3owTUF7XQcOpI7nP
         xqlqKX9K9C432LVQbpkHw7FiS3m4VffEy3XRtEkL9IZgypvkCQ45R7tBpSkGxUc9G0XS
         88pB4VrZqGj2b0P/BPns5doEQj6P8fIKjGr0o6cKSM9c2n+IxTXEANcuxAh2/SpVbuvi
         6H68mKChpAlYLryMvtZWDtWkm7r/xKSiEXRXtMYOAe0nwwUMZwjF9l0riuMEVRPhaha0
         YpYw==
X-Gm-Message-State: AOAM531Oysz02dYiE1iY+cMRn3NJv86dV8wJlXGBn6zl+KlGH9Bo/oHc
        kWHpAHrij1t0i+RWh6I6Q9U=
X-Google-Smtp-Source: ABdhPJyLyMDq9FoicW+HGEFllUOPTNmMXsNk0bmPnU4WOqNE6nyGep6sqAdCPecY1ErTi1iKmpAsCw==
X-Received: by 2002:ac8:43d3:: with SMTP id w19mr5255401qtn.18.1606237765454;
        Tue, 24 Nov 2020 09:09:25 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id i12sm13117404qtr.56.2020.11.24.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:09:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:09:02 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hui Su <sh_def@163.com>, mingo@redhat.com, jack@suse.cz,
        akpm@linux-foundation.org, neilb@suse.de,
        trond.myklebust@hammerspace.com, liuzhiqiang26@huawei.com,
        tytso@mit.edu, cai@lca.pw, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: fix potenial dangerous pointer
Message-ID: <X70+Ll+L2ksoeCMv@mtj.duckdns.org>
References: <20201124165205.GA23937@rlk>
 <20201124120523.34a59eed@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124120523.34a59eed@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:05:23PM -0500, Steven Rostedt wrote:
> On Wed, 25 Nov 2020 00:52:05 +0800
> Hui Su <sh_def@163.com> wrote:
> 
> > The bdi_dev_name() returns a char [64], and
> > the __entry->name is a char [32].
> > 
> > It maybe dangerous to TP_printk("%s", __entry->name)
> > after the strncpy().
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> This should go through the tree that has the code that uses these
> tracepoints.

Acked-by: Tejun Heo <tj@kernel.org>

Andrew, can you please route this one?

Thanks.

-- 
tejun
