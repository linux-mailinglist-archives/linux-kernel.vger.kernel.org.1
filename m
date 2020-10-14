Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8301628E08F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgJNMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgJNMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:30:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84019C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BN1NbFTyEUnp5yl42P5UagkxlMNHTr9O8eohuyqeiko=; b=eo/zTaCHHriX4YMAVz4KFHP/2j
        cPx5lwbJ5TRYN31eGBQgZJnqpN2ka0Tm9WSKz0qoh3ywVW7sCSgC6UIxIpHQiETV6/y/T5zECu8ih
        IiUt92Tsil/Eb8oeO7rwWgV6bVLcZNIYsS1aY8pgUf6Qgq9sz0ET1P94Bci6lV/kcr1Vp1q1mZzQu
        wCyaLHY6OLNhxAxWz1hpP3gQ2RiQ+jx0ME5Kt1pqVpNy94DwNVeyeICYKEc6qh1QjZloDBJBP4goW
        T6GUiBSU082/BMH1f3ZRkWlrjA7bcFNhdJSiSMo4LUM1Y2HlilpDIH9/KvSVnd1jzoO32JiviX3hK
        bG9fco4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSfvD-0003l8-5x; Wed, 14 Oct 2020 12:30:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 507CB300DB4;
        Wed, 14 Oct 2020 14:30:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3E0029AE5411; Wed, 14 Oct 2020 14:30:19 +0200 (CEST)
Date:   Wed, 14 Oct 2020 14:30:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v3 0/3] objtool: Extend CFA updating/checking
Message-ID: <20201014123019.GE2628@hirez.programming.kicks-ass.net>
References: <20201014073802.436630-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014073802.436630-1-jthierry@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:37:59AM +0100, Julien Thierry wrote:
> Julien Thierry (3):
>   objtool: check: Fully validate the stack frame
>   objtool: check: Support addition to set CFA base
>   objtool: check: Make SP memory operation match PUSH/POP semantics

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
