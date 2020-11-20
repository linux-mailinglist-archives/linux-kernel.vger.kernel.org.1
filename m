Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117152BAC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgKTOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:53:27 -0500
Received: from foss.arm.com ([217.140.110.172]:50398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgKTOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:53:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66E221396;
        Fri, 20 Nov 2020 06:53:26 -0800 (PST)
Received: from [192.168.2.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A4073F70D;
        Fri, 20 Nov 2020 06:53:24 -0800 (PST)
Subject: Re: [PATCH 1/2] x86/intel_rdt: Check monitor group vs control group
 membership earlier
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20201118180030.22764-1-valentin.schneider@arm.com>
 <20201118180030.22764-2-valentin.schneider@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <613d0854-597e-6ed7-05ca-70310c7b887d@arm.com>
Date:   Fri, 20 Nov 2020 14:53:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118180030.22764-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 18/11/2020 18:00, Valentin Schneider wrote:
> A task can only be moved between monitor groups if both groups belong to
> the same control group. This is checked fairly late however: by that time
> we already have appended a task_work() callback.

(is that a problem? It's needed to do the kfree())


> Check the validity of the move before getting anywhere near task_work
> callbacks.

This saves the kzalloc()/task_work_add() if it wasn't going to be necessary.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
