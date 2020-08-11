Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4648241531
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 05:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHKDT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 23:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgHKDT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:19:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF28C2065D;
        Tue, 11 Aug 2020 03:19:55 +0000 (UTC)
Date:   Mon, 10 Aug 2020 23:19:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200810231954.3388855c@oasis.local.home>
In-Reply-To: <20200811030418.GA1893@codeaurora.org>
References: <20200728013359.2326-1-tingwei@codeaurora.org>
        <20200811030418.GA1893@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 11:04:18 +0800
Tingwei Zhang <tingweiz@codeaurora.org> wrote:

> Thanks for your comments, Steven.  I've addressed all your comments in v3.
> Do you have more comments on v3? Is there anything I need to do to merge
> this series to Linux Kernel?

I gave my Reviewed-by tag on each of the patches that touch my tree. It
should go in via whoever maintains the drivers/hwtracing tree. Is that
Greg KH?

-- Steve
