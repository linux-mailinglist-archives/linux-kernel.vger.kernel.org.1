Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36028F1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgJOMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:00:10 -0400
Received: from foss.arm.com ([217.140.110.172]:35350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbgJOL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:56:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B2AA31B;
        Thu, 15 Oct 2020 04:56:12 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BD653F66B;
        Thu, 15 Oct 2020 04:56:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
 <20201014150034.GA502296@ubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c0aacfa8-225d-a529-be9b-d68993104c76@arm.com>
Date:   Thu, 15 Oct 2020 13:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014150034.GA502296@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 17:00, Yun Hsiang wrote:
> On Tue, Oct 13, 2020 at 10:25:48PM +0200, Dietmar Eggemann wrote:
>> Hi Yun,
>>
>> On 12/10/2020 18:31, Yun Hsiang wrote:

[...]

> The tg uclamp value may also change. If top-app's cpu.uclamp.min change
> to 50 (~500), then task A's effective uclamp min value is 300 not ~500.
> We can set task A's uclamp to 1024, it will be restricted by the tg.
> But when task A move to root group, it's effective uclamp min value
> will be 1024 not 0. If a task is in root group and it doesn't want to
> control it's uclamp, the effective uclamp min value of that task should be 0.
> So I think reset functionality is needed.

OK, looks like the intended solution { a) or b) in
https://lkml.kernel.org/r/87zh4ohnf9.derkling@matbug.net} is not really
feasible.

So we do need the uclamp reset to enable throughout the entire lifetime
of task p 'p is !user_defined -> p is controlled by taskgroup hierarchy)'.
