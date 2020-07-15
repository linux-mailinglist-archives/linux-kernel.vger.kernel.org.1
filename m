Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84A2217D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 00:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGOWis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 18:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgGOWir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:38:47 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0528820658;
        Wed, 15 Jul 2020 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594852727;
        bh=G2gD9bUnjwJBZJyX27Mq12AcTz2bMWaZiUgRCKKBLt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pjxL2sNcYqpTR1P1s21ZgPk/jqfBzJ15+1Xmo4G30kbij2t8+GiHbbSxUQDS2h4Tp
         HufsuBDEFIq3PVZ08CztEE8++ZXpom42m6rsjTEoAGnNitai6wN+DESGlKVXudu140
         U3iQGVrWqYrjW7IfqSULqoic05Wbxrfioyjmv2M0=
Date:   Thu, 16 Jul 2020 07:38:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alistair Delva <adelva@google.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] bootconfig: Add value override operator
Message-Id: <20200716073843.e7b1921aae962da9e5714fe0@kernel.org>
In-Reply-To: <20200715164504.3400efc5@oasis.local.home>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
        <20200715164504.3400efc5@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:45:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Jul 2020 01:00:21 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > With this change, if the bootloader wants to change some value
> > in the default bootconfig, it doesn't need to parse the existing
> > bootconfig, but it can just append the new configs at the tail
> > of the bootconfig and update the footer (size, checksum and magic
> > word).
> 
> I wonder if we should support multiple bootconfigs instead of updating
> the size/checksum/magic?
> 
> So the end of the initrd would have:
> 
>  [data][size/checksum/magic][more-data][size/checksum/magic]
> 
> 
> And the kernel could do the following:
> 
>  1. read the end of the initrd for bootconfig
>  2. If found parse the bootconfig data.
>  3. look at the content before the bootconfig
>  4. if another bootconfig exists, goto 2.
> 

Yeah, that is possible. But since the total size of the bootconfig
is limited to 32KB (this means data + 1st footer + more-data),
I would like to give a chance of sanity check to the bootloader.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
