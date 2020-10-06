Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D84284E36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgJFOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:44:03 -0400
Received: from mail.monom.org ([188.138.9.77]:50458 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgJFOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:44:03 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 10:44:02 EDT
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8B68B5004AF;
        Tue,  6 Oct 2020 16:37:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from [192.168.154.220] (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 47C4F500103;
        Tue,  6 Oct 2020 16:37:22 +0200 (CEST)
Subject: Re: [ANNOUNCE] v5.9-rc8-rt12
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <6c5bce4f-1c7f-a9e4-6707-2cda54141d8e@monom.org>
Date:   Tue, 6 Oct 2020 16:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 06.10.20 10:58, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.9-rc8-rt12 patch set.

Just as heads up. I just tried to build for arm64 but PREEMPT_RT
is not available anymore. Looks like ARCH_SUPPORTS_RT is only
available for !KVM.

Thanks,
Daniel
