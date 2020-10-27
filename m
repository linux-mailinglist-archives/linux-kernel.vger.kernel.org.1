Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92B29A9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898297AbgJ0Kam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:30:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898094AbgJ0K2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:28:54 -0400
Date:   Tue, 27 Oct 2020 11:28:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603794532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQ7zMCv9WzoVlZNW1UUVkVwr9kP9FCotl44bX4Fv43o=;
        b=TCt+Vxjp1CP4YSakfOfvQNtZYZkWm4SVMqLUFFADYjdOxreUiMIFn/lvosfkn2m39bsnqR
        sU/GjKDC/+Gasbs/+BWAHCPSeY/UNMseV8URz/k6UoQ/u/30GBZGIAFXYL7YNXxkBa+k8u
        d+cbly04RM2D/HQFiYkn85hKfdEaNx5EePLEDaF9OUSAKeYjSzYPfNvahCCcDpaq55WTmI
        yRAyGDQnUxVlmEbIgHGlr60IsqlpNxYV7/AlhIMZoc/X9CXZ62DtoYQfRuHdt+yRGxon4Y
        VNEUL+hPmyZflfvSZkn5N4bSSVMBXMkOxGF01MN7jqhevodR4ERY/+ewZ6KEZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603794532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQ7zMCv9WzoVlZNW1UUVkVwr9kP9FCotl44bX4Fv43o=;
        b=CVyx/4nxryfOPhCo3hrrE3MO+VXGIy8ucvbHmsEKj9qDhv48nfEuJeRDEoY7M10El6CszO
        mt6WtszF9+Us/sBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027102851.gizepjlu4opensqb@linutronix.de>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
 <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 11:25:47 [+0100], Daniel Wagner wrote:
> Well, one thing I need to figure out is how to get pi_stress working
> correctly on my machines (that is for all -rt trees, so it's nothing
> new). It consistently triggers RCU stall warnings with hackbench as
> workload. Clark told me the test only works if there are enough CPUs to
> run on. Need to look into it.

Is it running as a RT task? Do you have RCU-boosting enabled?
Otherwise it looks that if you throw enough non-RT load on the system,
RCU can not catch up which does not sound good.

Sebastian
