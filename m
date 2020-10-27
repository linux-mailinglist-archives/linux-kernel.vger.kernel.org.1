Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EAD29A670
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894566AbgJ0IWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:22:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389898AbgJ0IWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:22:49 -0400
Date:   Tue, 27 Oct 2020 09:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603786968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DnBGT2o3RmzLH6Jk+SiaKYgGhj2tONBcJBQJ4Z5h+M=;
        b=dile8uqtDV/sHjutdaTGsqHeNASd8kFpfs9SVjvfV/QOQo79JwTr0uWtEenEG48R/w14x+
        dSh+XfPi7wd6NhpCa57zvFgIn6h+QruFIO54JHi8Jdoi5xeWzC8Qkt7qBZa48GjAnZ36ds
        yInDwBB4zIa5ejUYjoB4Adgse7jb6QwfHTOz+Oe8CKPgg8Yn1bwN7xgElKl8tuXhVwOzjo
        5ny3eTAReoix0CcLLe+zlYAIgFdIpMSek4qrFJhKhinTiUZKUUoere3VODXoM+TXNdrrBs
        E/ITmvOWku3rbC+Z0ZE90CPIhFC2/JCdoCiLnnsX5+LcOphMkiAmRitjjaoWaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603786968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DnBGT2o3RmzLH6Jk+SiaKYgGhj2tONBcJBQJ4Z5h+M=;
        b=zMYphMDQPkj/3j4yQzIUfAZYfsJVOQ2LovKm+AryXAfyVmJd4JG2Ft6DPieP7hORBFCEl2
        AyjDG5B6QfH21WAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt18
Message-ID: <20201027082247.rs2h7l3wdzxc5f7i@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <20201021131449.qlwjiq2l6embaii3@linutronix.de>
 <54d33ca5-107e-e269-8c47-a1ae0dc60b0e@ccrma.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54d33ca5-107e-e269-8c47-a1ae0dc60b0e@ccrma.stanford.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 23:53:20 [-0700], Fernando Lopez-Lezcano wrote:
> Maybe I'm doing something wrong but I get a compilation error (see below)
> when trying to do a debug build (building rpm packages for Fedora). 5.9.1 +
> rt19...
> 
> Builds fine otherwise...

If you could remove CONFIG_TEST_LOCKUP then it should work. I will think
of something.

> Thanks,
> -- Fernando

Sebastian
