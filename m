Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52A279234
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgIYUfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbgIYUfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:35:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109C623119;
        Fri, 25 Sep 2020 19:27:11 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:27:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] tracing: support dynamic string field types for
 synthetic events
Message-ID: <20200925152709.6f73b4a2@oasis.local.home>
In-Reply-To: <20200925190806.1870935-1-axelrasmussen@google.com>
References: <20200925190806.1870935-1-axelrasmussen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 12:08:05 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> Hi Steven and Tom,
> 
> In this thread: https://lkml.org/lkml/2020/9/17/1015 we discussed how to plumb
> dynamic strings into synthetic events. Tom, you proposed adding a new dynamic
> string type to synthetic event definition like "char foo[]".

Thanks Axel,

As this is Tom's code, I'll let him give his review.

-- Steve
