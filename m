Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D192B42FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgKPLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgKPLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:36:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA7C0613CF;
        Mon, 16 Nov 2020 03:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJEPnRL4Bt+W45Ld93fb8AMd5s0crtJuuJ0+CxOiB0c=; b=G0Y9NhesjqTSBZ/Dgd68wa8YyT
        low1lTB1pCLpw73yHvvZsZLjVE1GmkBko8sRGYeU6cGEpNBziLiw442cVIyFNGHZKLRpMBvWWP/tL
        0rWjm8nyJUcmMPOV5kP91xqEwgIsqx++y4YqNVQg5b9BMqIGYDkD8aw028J6igc/6y4wpThV6HY5j
        +PIjE8IZRY4Np6A/45n65i40odDABpsO9VGXpn0dgbgXNLNOnUqNpU1a26LfNLNVzxsULPLTcmUUb
        XB4+Vu6ttFW0wi0EipMztXD8ccpwdKADaXD1RUbUTZlwaWDJ2Sr5TufmoqgpdZ0xcQAt9sFUvEPOk
        j2tKdZ7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kecnn-000195-BQ; Mon, 16 Nov 2020 11:36:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 949DA3060AE;
        Mon, 16 Nov 2020 12:36:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7187A2025A325; Mon, 16 Nov 2020 12:36:05 +0100 (CET)
Date:   Mon, 16 Nov 2020 12:36:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/27] completion: fix kernel-doc markups
Message-ID: <20201116113605.GB3121378@hirez.programming.kicks-ass.net>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <3540741143ee102db25283454e962768a8d6b9dd.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3540741143ee102db25283454e962768a8d6b9dd.1605521731.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:18:10AM +0100, Mauro Carvalho Chehab wrote:
> Kernel-doc only supports having the comment just before
> the identifier.
> 
> The markup for init_completion is actually for
> __init_completion.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> ---
> 
> Thats said, IMHO, it would make sense to simply
> rename __init_completion() to init_completion() and drop
> this define:
> 
> 	 #define init_completion(x) __init_completion(x)

Yeah, that seems to be the result of much code shuffling. That cleanups
seems sanest.
