Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0F2C899B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgK3Qc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:32:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgK3Qc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:32:57 -0500
Date:   Mon, 30 Nov 2020 17:32:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606753935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaR3NAbZ9l+efCs0oIK/8D1qbTRqtOvlBevnYGdFB5g=;
        b=GkHjY+KBzzixyASW5TGajK4EonHPffk/9wLcyhbDWNTj7i7DE1/rrFALkHbqDS59tjepzU
        FJrEPV1cGTBPAWD5vqh5u9QJAjxO34FBWAcPiS5okbirXfHof5CByOjwcZvxUsdqjT3StD
        BpamjloE1qRUuY357sbalYDEundVzZkNL3PCLMCMl9lmFTcB7CbnuwraNMDel/AsafyZnm
        UXR2roRS9XtOXos1GSuL/2NNWZ4UewQlTmDU/Fn77duuqrQyC060cB7jOE1NYpd2Fz3o5z
        oLHvWksIJ7QDXK/YS5aNbyc++NqG2BV9w3LJhxDidVSROzjeqz/LTscY6aVavA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606753935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaR3NAbZ9l+efCs0oIK/8D1qbTRqtOvlBevnYGdFB5g=;
        b=cytT6MDcE6UQPQdirmzwPZ9eRgFaOE7IM4m/06a4MTQRLF2By3gNCOqwAMSOR3kJqaF6x0
        ZWp+rPuCQBd5K2DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130163214.3zdlppkkd7dnnpzp@linutronix.de>
References: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
 <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
 <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de>
 <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-30 17:27:17 [+0100], Mike Galbraith wrote:
> > This just passed. It however killed my git-gc task which wasn't done.
> > Let me try tomorrow with your config.
> 
> FYI, I tried 5.9-rt (after fixing 5.9.11), it exploded in the same way,
> so (as expected) it's not some devel tree oopsie.

v5.9 has the same missing local-lock init due to merged local-lock
upstream. I don't remember when this get_cpu_ptr() came it.

> 	-Mike

Sebastian
