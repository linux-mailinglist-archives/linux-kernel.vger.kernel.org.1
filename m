Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CED22A0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgGVUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 16:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVUvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:51:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0232086A;
        Wed, 22 Jul 2020 20:51:41 +0000 (UTC)
Date:   Wed, 22 Jul 2020 16:51:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-ID: <20200722165140.45b58fed@oasis.local.home>
In-Reply-To: <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
        <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 06:30:53 +0200
Joerg Vehlow <lkml@jv-coder.de> wrote:

> Hi Andrew,
> 
> it's been two month now and no reaction from you. Maybe you did not see 
> this mail from Steven.
> Please look at this issue.
> 

Perhaps you need to send the report again without the RT (just [BUG])
to get Andrew's attention ;-)

-- Steve
