Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBEA28C84C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgJMFhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgJMFhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:37:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87919C0613D0;
        Mon, 12 Oct 2020 22:37:37 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so26496831ejr.4;
        Mon, 12 Oct 2020 22:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gYLREbCBt05MLq9RuSN82ybwnKTixZybY8CU73x+FQs=;
        b=Qj5hb2nQfetMWun2C/7FkWH/es32ZatL0Cnqp2RbrfMMx2+/EUqr7C0gkirXAeggO3
         hoDYYnE+Sm2z6HT+A9GSfYXnxlvwrdUCsDLYHuUlc/l9kxKmQ7x30fINVAgDDG3S+553
         CWPp4Wnv7RY9HcOUwxZeY78/pXcHTV48C8SuTMLM4ZYvw27y0HHf6ubgET/Qq7epT5Yj
         HOe18eTQG/UUu1gTJUJR0wKnpdpivHucUjDUjRnF2G427S28lH17hMoDnFOsIKsQO5GW
         +SR35piZ/dGrNDeSAhFglF9tzDGGJlmj0G1C3M6TG1q/dMtWtyBjMhX5zdTv9EBIooLf
         Jl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gYLREbCBt05MLq9RuSN82ybwnKTixZybY8CU73x+FQs=;
        b=fIO0GC/tvsQ44jSmXG6HVrrYdJ4L8D37a4DDRt7i+12aJ9i3E+kT91kidPATA1a0R2
         vCRflVlPdeg9rZiXwiZ2UD0I/tZtQtprDq3D3DFjXRbW4RiL1sG1DFh2LDR1ZRb8nR+/
         Vqh1IUIQuiE7HfsHMCfzp0BNAcFUazOEW2C8Jg141R/XvWboD/ussMg5Zd/Ymz/T1HzV
         KYnZzhWioWzVz1tUj6XyQtBzt2fT8GkIbLBWybc+KeJoyw0Fg84EIa8S6B8kCHnixoyq
         K0zIVOxKPbcaMvRmQdZ62cBzfxW5eKYAOSYFMjFNhyL83Mr1U9zdHnJC0z3PCNYEnBc9
         FqiQ==
X-Gm-Message-State: AOAM532stO12GLxdTPbbtQXj4NvWmq26tQ4CQxoypFGReXCHgQ7ZOuTD
        J3xyree1R7eT70yFexlq7CM=
X-Google-Smtp-Source: ABdhPJw2++YSQXSV41iMkqWKkxe5lVcRBwcMikf48LjMGn6E+J5mnrnZBd3TBovbyjrhv3ZLRImhqQ==
X-Received: by 2002:a17:907:33d2:: with SMTP id zk18mr32207994ejb.145.1602567456047;
        Mon, 12 Oct 2020 22:37:36 -0700 (PDT)
Received: from felia ([2001:16b8:2d05:8100:95ae:bd1a:3e4e:4242])
        by smtp.gmail.com with ESMTPSA id k1sm11772846edl.0.2020.10.12.22.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 22:37:35 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 13 Oct 2020 07:37:34 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201013052317.GB330398@kroah.com>
Message-ID: <alpine.DEB.2.21.2010130725370.14590@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu> <alpine.DEB.2.21.2010121659040.6487@felia> <20201012151816.GA1559916@kroah.com> <alpine.DEB.2.21.2010122022250.17866@felia>
 <20201013052317.GB330398@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:

> On Mon, Oct 12, 2020 at 08:25:30PM +0200, Lukas Bulwahn wrote:
> > 
> > 
> > On Mon, 12 Oct 2020, Greg Kroah-Hartman wrote:
> > 
> > > On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> > > > And for the static analysis finding, we need to find a way to ignore this 
> > > > finding without simply ignoring all findings or new findings that just 
> > > > look very similar to the original finding, but which are valid.
> > > 
> > > Then I suggest you fix the tool that "flagged" this, surely this is not
> > > the only thing it detected with a test like this, right?
> > > 
> > > What tool reported this?
> > >
> > 
> > Sudip and I are following on clang analyzer findings.
> > 
> > On linux-next, there is new build target 'make clang-analyzer' that 
> > outputs a bunch of warnings, just as you would expect from such static 
> > analysis tools.
> 
> Why not fix the things that it finds that are actually issues?  If there
> are no actual issues found, then perhaps you should use a better tool?  :)
>

Completely agree. That is why I was against adding comments here and 
elsewhere just to have the "good feeling of doing something" after the 
tool reported a warning and we spend some time understanding the code to 
conclude that we now understand the code better than the tool.

If you know a better tool, we will use it :) unfortunately, there is no 
easy way of finding out that a tool just reports false positives and not a 
single true positive among 1000 reports...


Lukas
