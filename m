Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD8304615
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394276AbhAZSOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392965AbhAZRlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:41:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889A02228A;
        Tue, 26 Jan 2021 17:40:33 +0000 (UTC)
Date:   Tue, 26 Jan 2021 12:40:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, John Ogness <john.ogness@linutronix.de>,
        linux-mm@kvack.org, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <20210126124032.0915f408@gandalf.local.home>
In-Reply-To: <20210126123912.23a5c3a1@gandalf.local.home>
References: <20210116220950.47078-1-timur@kernel.org>
        <20210118182635.GD2260413@casper.infradead.org>
        <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
        <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
        <20210119014725.GH2260413@casper.infradead.org>
        <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
        <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
        <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
        <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
        <a9b38fe7-8a22-71b7-1e84-0ebf1e864306@kernel.org>
        <20210126123912.23a5c3a1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 12:39:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Jan 2021 11:30:02 -0600
> Timur Tabi <timur@kernel.org> wrote:
> 
> > On 1/26/21 11:14 AM, Vlastimil Babka wrote:  
> > > If it was a boot option, I would personally be for leaving hashing enabled by
> > > default, with opt-in boot option to disable it.    
> > 
> > A boot option would solve all my problems.  I wouldn't need to recompile 
> > the kernel, and it would apply to all variations of printk.  
> 
> Should it be called "make-printk-insecure"
> 
> ?

And even if we make this a boot time option, perhaps we should still
include that nasty dmesg notice, which will let people know that the kernel
has unhashed values.

-- Steve

