Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0535929A8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896726AbgJ0KA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:00:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436603AbgJ0KAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:00:52 -0400
Date:   Tue, 27 Oct 2020 11:00:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603792850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11QNpip+ut9rruGgwDFdU3oeVpFfnDpEPun0YIGKoEI=;
        b=yUI4KWxQyS0ilMVqKge574ymbsT/PBkbTZzD1JeuNjdIDbW9aHsq1/EI/A+Db8yr31qvVK
        ztANWa56s2eHQG0IZl0zKCkBXW+07JM1j1evvBN2Ku6GmQ9XbYi5wR8WppmX3FjgiYVS+A
        K3K4sNg70VRdVB+J7LQcBf+biVQWMaS4emAGB9ugi3SQcqNzK0ISMdZYuaTlyXADD4/LRA
        b0z4adwD7vGGYgilnFbyTEWJwjjM1116ZkQ0p3h314zYB3RGh9aXQBPu9LMFFTvfGgi8bX
        wwA53i/ptOwTZ4NhZLf4IVtPOVGHivhy9K/znJJSMbEfZufLR3wfRvFTdnGSzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603792850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11QNpip+ut9rruGgwDFdU3oeVpFfnDpEPun0YIGKoEI=;
        b=lEqcAcapTPdT0Kfgfm5WbLwpHpdKu+s4tdEI3mIU1bW6ypzllhTXUmfx+u6udxbYM4ha6G
        3H6/GXsA301NjPAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 10:36:16 [+0100], Daniel Wagner wrote:
> On Sat, Oct 24, 2020 at 11:18:38AM +0200, Sebastian Andrzej Siewior wrote:
> > I'm pleased to announce the v5.9.1-rt19 patch set. 
> 
> FWIW, all tests pass in my lab (by avoiding doing the same stupid
> mistake as last time...)

glad to hear.

Sebastian
