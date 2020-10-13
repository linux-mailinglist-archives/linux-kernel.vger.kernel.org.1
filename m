Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4D28C909
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbgJMHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389829AbgJMHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:16:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B4C0613D0;
        Tue, 13 Oct 2020 00:16:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b8so9443519wrn.0;
        Tue, 13 Oct 2020 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DcKf4Igwhaviy61SA4WHjZouchJcTwduIzK16MDmf0w=;
        b=ej7mfZMw+AJQ6G9Vucsjm+oMaAkXHHlw1ni25tfh2Lq5F+Zb3WIjtPQbaIMl58u8Pn
         PoKKaBagqq80jKCP3rHmBYKhuMFCLMfvoxNgeGQZdzFNGdX/S9t1e/8UNThBlatBHz8w
         6GwiMP+xLdF7cYTRLZYDFdM3Go574m+zk36DnWjm+EvDuwP/XS3hkXiISv24+PGADOZ4
         jBsuKkFkFDOmb7putnuDaUrW2ntFmOUOGs6ErljEXg2Sl/klcsf3lv5Pasdo9HUQirtV
         ZrnR/F2aem7501EiT/vKvhS7rO/TjrmG+msjGmUq3AGVgyMKVN4zOGFdOLbrYhooZBEE
         axXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DcKf4Igwhaviy61SA4WHjZouchJcTwduIzK16MDmf0w=;
        b=J82r+7SEKv0xf0NA3RvB2D3ur4fG8bxJvo+g0PtUUo2RdwezEz5Uo3nw/LlYEqseoJ
         3Y9myXGTI9My24UmgjTAvmHkCCieqN3iPW6FHdUrL7ebr5h7BA7W74H6N8M4ej5LVeIJ
         +eo7fYfr9B5kNCilrAJwXqjC5QIRNlZDqTqoBb8DSpcQjDMJRVa1+/XZklbkxR/tTCfe
         8DQN+OAAVKHdeA1+9Ch+Fe/ihMHOIQzZJ/npLuZyS4ntt+iGh8n9BPlETRIokUR0/Qq7
         bCRXCnnoWW1iZlPdFk98LRisF9cofZJXEEDeggqneePQ1egDQDIhdXqvzmc+wy8Fktdb
         DRUg==
X-Gm-Message-State: AOAM530btx1Feas7GmPN3PFi2T8SzOX4wvYKEPHPcwL2/eWEmUEdrcZ8
        RfaQ8MiHJBEAfFt/xSZdyXcs2F9pAbb2ZiM7
X-Google-Smtp-Source: ABdhPJyx6KT11BLP3trQp4aNEqqx6hIIuFxre/14f4df/UX7QUoLCKbM8zg+ws7q2u+RwOSNd+23Ug==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr36301800wrg.166.1602573389304;
        Tue, 13 Oct 2020 00:16:29 -0700 (PDT)
Received: from felia ([2001:16b8:2d05:8100:95ae:bd1a:3e4e:4242])
        by smtp.gmail.com with ESMTPSA id l1sm7560503wrb.1.2020.10.13.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 00:16:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 13 Oct 2020 09:16:27 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201013063636.GA1663576@kroah.com>
Message-ID: <alpine.DEB.2.21.2010130850410.14590@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu> <alpine.DEB.2.21.2010121659040.6487@felia> <20201012151816.GA1559916@kroah.com> <alpine.DEB.2.21.2010122022250.17866@felia>
 <20201013052317.GB330398@kroah.com> <alpine.DEB.2.21.2010130725370.14590@felia> <20201013063636.GA1663576@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:

> On Tue, Oct 13, 2020 at 07:37:34AM +0200, Lukas Bulwahn wrote:
> > 
> > 
> > On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:
> > 
> > > On Mon, Oct 12, 2020 at 08:25:30PM +0200, Lukas Bulwahn wrote:
> > > > 
> > > > 
> > > > On Mon, 12 Oct 2020, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> > > > > > And for the static analysis finding, we need to find a way to ignore this 
> > > > > > finding without simply ignoring all findings or new findings that just 
> > > > > > look very similar to the original finding, but which are valid.
> > > > > 
> > > > > Then I suggest you fix the tool that "flagged" this, surely this is not
> > > > > the only thing it detected with a test like this, right?
> > > > > 
> > > > > What tool reported this?
> > > > >
> > > > 
> > > > Sudip and I are following on clang analyzer findings.
> > > > 
> > > > On linux-next, there is new build target 'make clang-analyzer' that 
> > > > outputs a bunch of warnings, just as you would expect from such static 
> > > > analysis tools.
> > > 
> > > Why not fix the things that it finds that are actually issues?  If there
> > > are no actual issues found, then perhaps you should use a better tool?  :)
> > >
> > 
> > Completely agree. That is why I was against adding comments here and 
> > elsewhere just to have the "good feeling of doing something" after the 
> > tool reported a warning and we spend some time understanding the code to 
> > conclude that we now understand the code better than the tool.
> > 
> > If you know a better tool, we will use it :) unfortunately, there is no 
> > easy way of finding out that a tool just reports false positives and not a 
> > single true positive among 1000 reports...
> 
> Who is "forcing" you to use any tool?  What is your goal here?
>

No force involved.

For some of us, it is 'just for fun' and the interest to understand the 
capabilities of those existing static analysis tools. To understand their 
capabilities and limits, we simply go through those warnings and try to 
reason if they are true positives (and deserve a patch) or false positives 
(which we at least try to reasonably document for later statistics and 
learning on systematic tool weaknesses).

Some others actually believe that the use of static analysis tools 
increase software quality and ONLY IF a static analysis tool is used, a 
specific level of software quality is achieved and they want to prove 
that the software reaches a certain level that way. (I do not 
understand that argument but some have been repeating it quite often 
around me. This argument seems to come from a specific interpretation of 
safety standards that claim to have methods to predict the absense of 
bugs up to a certain confidence.)

I am doing it for the fun and learning about tools, and I am not such a 
believer but those others would be forced by their beliefs until they 
understand what static analysis tools and their janitors really already 
contribute to the kernel development and where the real gaps might be.

I hope that helps to get a bit of the motivation. Consider us 
kernel newbies :)

Lukas
