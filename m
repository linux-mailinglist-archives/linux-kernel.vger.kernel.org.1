Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3B2B73DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKRBqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 20:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKRBqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 20:46:03 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E7C061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:46:02 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id y197so323854qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5g/1CHmh5Rhat4NRkmzCOLryGPN49Ig/a4fY6o6Awao=;
        b=ai8uogdgDM+/PCLB4ruUCUqZGa4EBt86Ca11OZNDI1+T8QVjDNy12v1Gdpy4QZDgG8
         FArEDx0LVQJ08Ot+yo/T+3NfqOYHQZV7lXdsi1GearOqIMWg3Xjcq8PtuRbKX/tAVZ/1
         mgpG/cljdLfBfI5C1R8q/I0+lTRRdxUJVQ5OGo/In8yp0lK1Zv6Z3/c5bAzXAd71wutj
         3N+0cIC7UQhxsPiucqYvPGPeRE0W+WMwDKBCWaJ9vR7dO3tXk9/LgXFQXrpwerwwDSqr
         Q6M9rAPGsScXQtTzoJPyaC/sPJ/i4iTo0TVTH5ayNn0MMiRuOBPbk3Y+Y4u8AUu81l7e
         fx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5g/1CHmh5Rhat4NRkmzCOLryGPN49Ig/a4fY6o6Awao=;
        b=UNfpC/lCjXWy5eF7ux3YYCZCS1Da29EHcjCFzs2wPYQ9rfzrfenoLC+liFdRA3+Hs0
         beNSZeXBlnI3CyNDuU3jww+U/FZCPLSHdBf3OgGIWHc4P+H+NVGNqj/RrAUBn/v/bG1a
         yp72rReIyBFyBLdS5ay7HJHXiuviWewqC5rvDJSkRALKQMTdCcsljY+cin6Yc5s2s2sD
         m4WUHeTKmFnL+dAfWIH+x4//SZCHctN6Ci55CSHRfSMtkgB7ZWb4KqdIq4M8OEG38mOB
         U4ZQ7lMGqOVL2Bs2V3ojSGwlUX3wNwan5PwmP6ibWKBtCOoHKWkm0Wd17c8FQ7oShh3M
         rwug==
X-Gm-Message-State: AOAM530flleaYFvp6hkYq/Khh0uBGXu+BHkXev0FiZgRtmVMaRuQPaIj
        //P4xLVk6Qrl8f/iq9mpYb8=
X-Google-Smtp-Source: ABdhPJzACiVM2CudO4VxQWWYew+7ZIFsXsc6T1YRenVmJSgUHBdRenudTTJ2O7g5i6Bwct+Zu1w6xg==
X-Received: by 2002:a05:620a:152f:: with SMTP id n15mr2551419qkk.245.1605663961476;
        Tue, 17 Nov 2020 17:46:01 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z30sm14973956qtc.15.2020.11.17.17.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 17:46:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2975927C0054;
        Tue, 17 Nov 2020 20:46:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 17 Nov 2020 20:46:00 -0500
X-ME-Sender: <xms:1Xy0X0V20d2JRSrnMPftnY5Y6xPGultvFxuQyT-ly4OZg6OyqH3hoQ>
    <xme:1Xy0X4l1A8iqyS0yJma-3Bk3NWWs70AUrMj4gKdmAkSRCIdvAc8ZaHFmtyYzmASNT
    urbZmSqLjU2uuIINQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1Xy0X4Z5vmRa1r95lQ5aoxdwKgdSxXEz00IJ7M3rUJtDguc0JlmFWg>
    <xmx:1Xy0XzWOs4aWIox7FndLvtgwHwjPyFJRToyGCAuuqVk6uy1BSI7EVQ>
    <xmx:1Xy0X-nuVveRb2YVpFq45IKUHSBILqQ2aWFBcEpBEEY-E0BKucGVQQ>
    <xmx:2Hy0X8tYD6sX3J1vwDT1-kP8BjhrrOR3WFCG4aFQkI4VLhcrDjIJ8yBhRas>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B2313064AAA;
        Tue, 17 Nov 2020 20:45:57 -0500 (EST)
Date:   Wed, 18 Nov 2020 09:45:40 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201118014540.GA1278700@boqun-archlinux>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R>
 <20201112092612.00a19239@gandalf.local.home>
 <20201112145251.GB17076@casper.infradead.org>
 <20201116085757.GB26078@X58A-UD3R>
 <20201116153729.GC29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116153729.GC29991@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Mon, Nov 16, 2020 at 03:37:29PM +0000, Matthew Wilcox wrote:
[...]
> 
> It's not just about lockdep for semaphores.  Mutexes will spin if the
> current owner is still running, so to convert an interrupt-released
> semaphore to a mutex, we need a way to mark the mutex as being released

Could you provide an example for the conversion from interrupt-released
semaphore to a mutex? I'd like to see if we can improve lockdep to help
on that case.

Regards,
Boqun

> by the new owner.
> 
> I really don't think you want to report subsequent lockdep splats.
