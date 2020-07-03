Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBA21375E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGCJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 05:13:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:13:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593767599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7qT2Qloe0viLOSply2DEdZk8V558qJCt/ksLt+nNRlQ=;
        b=31Ki3lq/5cx2ZwGqJt/f0CC1cono3zE9U5KoOc31WGqOofL736M1DV51qhO9ecwf6OdEC/
        X37oLbgqKp72/YgSdB2zLLO3KwFaHWDgWvSRMQvRdIQCzr+BHumaNmQw1HQ33ktF/ERXnY
        u/fLiYpc+3+/g8uVMkpWsf6QrNq2axQfRpZrUJGkOGIVaaUNmWWnPAnpAXjX0Kf07tGF1N
        UQsTEZ7MqI83z7vJJ4Gm4tfnKR0XlCYx8XStkn/rVyVKQTFQCu2QuI9IaurFwkLJrI3bNh
        LiTutmjK6AFH/ZhA7ITedg8mzDDrPhUpYkDG+4j8r+qoydhDPr8ebeqrBHACmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593767599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7qT2Qloe0viLOSply2DEdZk8V558qJCt/ksLt+nNRlQ=;
        b=xnCHBv4R2r+2YVTpSXsBo9v+tua2HoX4oVs0A3FriW8mA1qgnHdieZu7W7C2+oPUU67L8i
        G3/2rhLgnGWcW9CA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
In-Reply-To: <20200703001219.GD27417@lenoir>
References: <20200702133219.GA27417@lenoir> <87zh8irltc.fsf@nanos.tec.linutronix.de> <20200703001219.GD27417@lenoir>
Date:   Fri, 03 Jul 2020 11:13:18 +0200
Message-ID: <87pn9drmfl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> On Thu, Jul 02, 2020 at 05:14:23PM +0200, Thomas Gleixner wrote:
>> 
>> The reason for this < 2 is historical and goes back to the oddities of
>> the original timer wheel before the big rewrite.
>
> Ok. And is it still needed today or can we now forward even with a 1 delta?

I haven't found anything which requires it. But be aware of dragons ....

