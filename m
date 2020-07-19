Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDC2251C7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgGSMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 08:09:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:09:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595160576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nM61iace3a+hbFDTO66L/rvDLZO7SXvYkcigUdje3w0=;
        b=iByTsN8HnnXqLuJzrcN0EgZnuYfEXsdRDodMJvT3VGOTiStKFBCQ0cbyY8q2zQcePzEEV/
        H2aYnP9uD2Vz+ei97gvVwCdkNUtwQIx9jFR9spTB4sZ592s1NUnyb0nYdZqsqNoWiCZoRj
        NJfjVpoZEMy3CfVtY8E/Cw0TTTEI8CheHE6U3doaT/PgduQdJcTzv556B3Fs5NzI2CRGBX
        R8WEKZ7VBsQ6nUw2jPNhEt32C5I+N6psUtpOBQUdoR+N43RVjC4Ix5Qxa/kRpBnv+nXY0c
        E7nIsjBoE8vJz9nkl8uAEMpf8EGFp5wwvmmDO5TglICk7fpGurwDY4HX2/Vp/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595160576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nM61iace3a+hbFDTO66L/rvDLZO7SXvYkcigUdje3w0=;
        b=mLj6Lr+Ni4yPj4bjsqeQw2ZhO6Gdgz/YRqRPLjI/6IsRLi0FcrVO/xNmpVYhcuXYxvNitL
        cFt+ugPPzG/AvbDw==
To:     Muchun Song <songmuchun@bytedance.com>, peterz@infradead.org,
        mingo@kernel.org, bigeasy@linutronix.de, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] smp: Fix a potential usage of stale nr_cpus
In-Reply-To: <20200718061144.56095-1-songmuchun@bytedance.com>
References: <20200718061144.56095-1-songmuchun@bytedance.com>
Date:   Sun, 19 Jul 2020 14:09:35 +0200
Message-ID: <87k0yzoge8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song <songmuchun@bytedance.com> writes:

> When the cmdline of "nr_cpus" is not valid, the @nr_cpu_ids is assigned
> a stale value. The nr_cpus is only valid when get_option() return 1. So
> check the return value to prevent this.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> changelog in v2:
>  1) Rework the commit log.
>  2) Rework the return value check.

I asked:

>> So why fixing it just half and why returning '0' aka success if the
>> parameter is bogus?

And this still returns 0 if the parameter is bogus or malformatted....

Thanks,

        tglx
