Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810502CB199
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLBAed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:34:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgLBAeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:34:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606869230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNa6t/Yiw46XqIHgKb7LVCy8KwWwqm8J+K6xxYqGVBA=;
        b=wngDqBwNrZonI/7QAw2EV/YHR/x3LwqJ2mEdxbjRe7aNCcK+zDaeBnUlbgoPhNWgjfa/bU
        4fJX9dIZJdRWSrTA2+OruLT7es8WkBK26OUQzEoIijP9rjuYEVh2JCmcKMDpWG9PtiFJAO
        tt3/v/DxbC4rvJ5udXWCcOeAGx2ofVzwhSYdjOoQ/lLbATByr63x6449mKj69BISO8YyqJ
        SNJJfratUfu3cZiBtrzQhO7nhmVjoCG8U9uXGd3DwhmT4EzJYXyDQnmoF5gSg6VYndlKPI
        9d0O+bit21+TWkdUhZIogB6I7uMmqUSIuTvmwj4R1NtOKT6wLHtRFoCX1EWAng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606869230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNa6t/Yiw46XqIHgKb7LVCy8KwWwqm8J+K6xxYqGVBA=;
        b=lry3IhSBhvWpoN+TrQKy/QSye6AdjlDGmwFvR5X2taV8LHL+lQQMHQYsyuVrCANj8oOke6
        1xMgpggWyH3NtUCw==
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] split up lockdep and syscall related functionality in generic entry code
In-Reply-To: <20201201142755.31931-1-svens@linux.ibm.com>
References: <20201201142755.31931-1-svens@linux.ibm.com>
Date:   Wed, 02 Dec 2020 01:33:49 +0100
Message-ID: <871rg9f3ma.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 15:27, Sven Schnelle wrote:
> this is v2 of the patch. I've split it up the to multiple ones,
> and added documentation. The first patch was basically a hack to demonstrate
> what i need, sorry for not sending a more cleaned up version.

It would have been nice to send it against the branch which carries the
entry changes (tip: core/entry), but I fixed it up already, so no need
to resend.

Thanks,

        tglx
