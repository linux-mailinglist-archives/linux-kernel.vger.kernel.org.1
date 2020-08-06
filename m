Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBA23E283
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHFTrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 15:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFTrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:47:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355F52086A;
        Thu,  6 Aug 2020 19:47:23 +0000 (UTC)
Date:   Thu, 6 Aug 2020 15:47:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Paul <sean@poorly.run>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Add trace_array_init_printk() to initialize
 instance trace_printk() buffers
Message-ID: <20200806154721.4b8712bc@oasis.local.home>
In-Reply-To: <CAMavQK+j8Gxj5n8XnzjprM5b4gL0Kopd5Nu0MNnJPt5_5KifWA@mail.gmail.com>
References: <20200806144618.4384a0f9@oasis.local.home>
        <CAMavQK+j8Gxj5n8XnzjprM5b4gL0Kopd5Nu0MNnJPt5_5KifWA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 15:22:23 -0400
Sean Paul <sean@poorly.run> wrote:

> > Changes since v1:
> >   Added EXPORT_SYMBOL_GPL() to trace_array_init_printk() as it is
> >   required for another function that is exported.  
> 
> Could we also add this to trace.h?

That might be helpful, wouldn't it.

kernel test robot just suggested the same thing ;-)

-- Steve
