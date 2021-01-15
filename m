Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E72F713C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbhAODyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:54:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbhAODyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:54:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89A08AB7F;
        Fri, 15 Jan 2021 03:53:35 +0000 (UTC)
Date:   Thu, 14 Jan 2021 19:53:27 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     rob.rice@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] mailbox: bcm: Replace tasklet with threaded irq
Message-ID: <20210115035327.xckiigalv3qps7ke@offworld>
References: <20210115002134.117637-1-dave@stgolabs.net>
 <CABb+yY381GYcfAkLuzSTvNz2yHGs4Ap7Kgwiy9r0pXGGQt+ozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABb+yY381GYcfAkLuzSTvNz2yHGs4Ap7Kgwiy9r0pXGGQt+ozg@mail.gmail.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, Jassi Brar wrote:

>On Thu, Jan 14, 2021 at 6:21 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> Tasklets have long been deprecated as being too heavy on the system
>> by running in irq context - and this is not a performance critical
>> path. If a higher priority process wants to run, it must wait for
>> the tasklet to finish before doing so.
>>
>> Use a more suitable alternative such as threaded irqs and do the
>> async work in process context.
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>Please cc the author and other contributors to this file, esp when
>this is vendor specific code.

So looking at who to Cc I noticed:

commit 8aef00f090bcbe5237c5a6628e7c000890267efe
Author: Rob Rice <rob.rice@broadcom.com>
Date:   Mon Nov 14 13:26:01 2016 -0500

     mailbox: bcm-pdc: Convert from threaded IRQ to tasklet

     Previously used threaded IRQs in the PDC driver to defer
     processing the rx DMA ring after getting an rx done interrupt.
     Instead, use a tasklet at normal priority for deferred processing.

... which is exactly the opposite of what modern Linux should be
doing. Rob, could this not be done in process context?

Thanks,
Davidlohr
