Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDE2EFCA4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 02:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbhAIBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 20:13:57 -0500
Received: from casper.infradead.org ([90.155.50.34]:60892 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbhAIBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GFi/a+k1HV7G0k3FC/yL6n4O7ONrdjcIj5VhIzNlBxI=; b=NFOiddK2qND7tjI20jyRG/kocz
        f1/faQ6zEiEj2bkwlIlMI3wBuSg9RwPkFslW1upnLJhVSuvoTDoncre0AXzVRGFcScPzKej9DaPKL
        2vWXD4WBtobctOcZIfYHSXg2/1UT53NYzMXCngmFERwqo9RpPoFnUfFvbuWq+s3NDfs8VkDFo4sIi
        uSc2kXxTzOa6UXrf89Mab/A/DEAfNjZzUek+Py4ujsZK7wZtc2UDp1qo390qEIAtZRKvQswPEjBMb
        7plE3QsEc68czdGdUGsn/tGxELkdNm52XBnYTKNreBpRC/yUMqvXoOmfn8Ei0Q0ViU3FFbONem1Z/
        9bFcpucg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxWlL-0009OI-K2; Thu, 07 Jan 2021 15:00:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1730D3013E5;
        Thu,  7 Jan 2021 15:59:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F117B2BB7DCC3; Thu,  7 Jan 2021 15:59:42 +0100 (CET)
Date:   Thu, 7 Jan 2021 15:59:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <X/ch3gaCCRMT/Cxw@hirez.programming.kicks-ass.net>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <20210106004956.11961-4-paulmck@kernel.org>
 <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
 <CAAH8bW9jfSeYe+d6feQUTKuqwKr_U0aCGPZEiBh6Hp=KT2iPrA@mail.gmail.com>
 <X/cYR474/PiTvjfC@hirez.programming.kicks-ass.net>
 <20210107144757.GK2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107144757.GK2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 06:47:57AM -0800, Paul E. McKenney wrote:
> > I don't really see the use of the ranges thing, CPU enumeration just
> > isn't sane like that. Also, I should really add that randomization pass
> > to the CPU enumeration :-)
> 
> Please don't!!!

Why not, the BIOS more or less already does that on a per machine basis
anyway. Doing it per boot just makes things more reliably screwy ;-)
