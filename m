Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8019F89B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDFPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 11:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgDFPMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:12:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB27C23BCD;
        Mon,  6 Apr 2020 15:12:40 +0000 (UTC)
Date:   Mon, 6 Apr 2020 11:12:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ahio.lee0@gmail.com
Cc:     trivial@kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove blank line before right brace '}'
Message-ID: <20200406111239.49e8a181@gandalf.local.home>
In-Reply-To: <20200405142729.16028-1-ahio.lee0@gmail.com>
References: <20200405142729.16028-1-ahio.lee0@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Apr 2020 22:27:29 +0800
ahio.lee0@gmail.com wrote:

> From: Ahio Lee <ahio.lee0@gmail.com>
> 
> No need to insert a weird blank line before right brace '}'.
> 
> Signed-off-by: Ahio Lee <ahio.lee0@gmail.com>

I'm sorry but I'm not concerned about "weird blank line"s. This just adds
unnecessary churn, and doesn't make the code any more readable.

-- Steve
