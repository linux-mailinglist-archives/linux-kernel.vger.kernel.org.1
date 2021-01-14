Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085552F5D03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbhANJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbhANJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:13:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73208C061795
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/5Zz0p2oJ5TA6sIaD5hjXMpw1Dava3EZAquKucaVYXA=; b=daxvThX9yb1jhpfOHQo81F3XDc
        UXko2aQGZpWZkBR9htUUH14eQiftil+FcDu2j31Y3oqTNHxfPKAxyqu8duyCjRrosTDtSSIaiXcud
        NgJYIJ8jlhCztI+rTV0Bk5gbtBZd/vU4BnGGnVBurm2F5FIqi1m6xZeyM+TB4ZEbbafklwdUigQkM
        TqVdLawaIIrHFD6qMGZ8AbQhNqIlvPTpsrrLMj//E/woYqerkjxZruE/LTuKWKdHf+eDmvNAQeW/m
        0tAxJCBu0NqVz3yFld0Y+8O1B7z1hDvQRDxszvzcFIOhKtau5WRfN6i5COI9c9kYoEEk+tEqbu4HO
        Qp4natuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzyfX-007Mpo-Gw; Thu, 14 Jan 2021 09:12:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEB3F301324;
        Thu, 14 Jan 2021 10:11:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0E042C3CFB7B; Thu, 14 Jan 2021 10:11:48 +0100 (CET)
Date:   Thu, 14 Jan 2021 10:11:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question on   workqueue: Manually break affinity on hotplug
Message-ID: <YAAK1MOPAPjrbSIt@hirez.programming.kicks-ass.net>
References: <BYAPR11MB2632FC41FF64133708F4537FFFA80@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2632FC41FF64133708F4537FFFA80@BYAPR11MB2632.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:03:23AM +0000, Zhang, Qiang wrote:
> Hello Peter
> 
> Excuse me, I have some questions for you, about a description of this change:
> 
> ''Don't rely on the scheduler to force break affinity for us -- it will
> stop doing that for per-cpu-kthreads."
> 
> this mean when cpuhotplug, scheduler do not  change  affinity for per-cpu-kthread's task, if we not active setting affinity?
> but if per-cpu-kthread's task is not run state, when wake up,  will reset it's affinity, this  is done automatically.
> 
> or is it,  this place modified to fit the new one hotplug mechanism which
> ("sched/hotplug: Consolidate task migration on CPU unplug")?

https://lkml.kernel.org/r/20201214155457.3430-1-jiangshanlai@gmail.com
https://lkml.kernel.org/r/20201218170919.2950-1-jiangshanlai@gmail.com
https://lkml.kernel.org/r/20201226025117.2770-1-jiangshanlai@gmail.com
https://lkml.kernel.org/r/20210111152638.2417-1-jiangshanlai@gmail.com
https://lkml.kernel.org/r/20210112144344.850850975@infradead.org
