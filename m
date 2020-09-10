Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69412647BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgIJOGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgIJNxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:53:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3ECC061573;
        Thu, 10 Sep 2020 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qid5VVZzlgwDQXJxhD3JSaTvS0/ROxlbq6Lq5kL7DUU=; b=sJt12gg0bTIr+NVG+ai4i7knDT
        bUTdAzzbk/uv3Q0XwvdXU5kChmZXiXoSe1cHeg5Fa+M4oQd/MV5G1OMLh3fZZY/wSmjInR/T0g34f
        knMQQvnhBJguSgRQQoU4cV5ZrLLgQLgkD8QGK8F2ex96tMqX4kEID3PSzYe0GjlYLL8PBuZWDM/HD
        vBAcaL2Pr9kp3uX+kXfwwLiKy6iFv21DmkGgx4G6PmmvtW66MxJ1IBaa/FxzlYXfvQ2ku1gD8z8jP
        0g6gyvlSJzwG/5iVRYYFL8D+5oEKJ0R7m0nAwFi01zVQG5wH1f65UHEK+KOPZSHhZvCJVWTBbSakq
        u09qqaow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGMoc-0002pZ-It; Thu, 10 Sep 2020 13:40:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B994303F45;
        Thu, 10 Sep 2020 15:40:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15E812B83026D; Thu, 10 Sep 2020 15:40:40 +0200 (CEST)
Date:   Thu, 10 Sep 2020 15:40:40 +0200
From:   peterz@infradead.org
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [sparc64] kernel OOPS bisected from "lockdep: improve
 current->(hard|soft)irqs_enabled synchronisation with actual irq state"
Message-ID: <20200910134040.GZ1362448@hirez.programming.kicks-ass.net>
References: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:43:13PM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> The following git patch 044d0d6de9f50192f9697583504a382347ee95ca
> (linux git master branch) introduced the following kernel OOPS upon
> kernel boot on my sparc64 T5-2 ldom (VM):

https://lkml.kernel.org/r/20200908154157.GV1362448@hirez.programming.kicks-ass.net
