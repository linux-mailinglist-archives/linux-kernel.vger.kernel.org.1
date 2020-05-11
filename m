Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2613C1CE18E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgEKRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgEKRVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:21:49 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4DE206D7;
        Mon, 11 May 2020 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589217708;
        bh=tLxkrmhQXyX7b1bTcRDkdDpgPTyxNen6bs9bJnit8HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0aOsDPuEgkaqp+CwaPIoKUpAQ1Yhgy/YPVryPk98JvkcESzcmL+qtHj2rH9aBLfSd
         7k4UNacnQ3F+z4Fv9cotIr3i/rQhNYIDOWoow0Eqdo18nH6oGa2OmrH6zJjjqjnnf5
         pMvp722fZ/aQqdCtti5Y2anKKSYsBHnDBV+eQSyI=
Date:   Mon, 11 May 2020 12:26:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Replace zero-length array with
 flexible-array
Message-ID: <20200511172620.GA14618@embeddedor>
References: <20200507190615.GA15677@embeddedor>
 <20200511154812.GD5377@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511154812.GD5377@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:48:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 07, 2020 at 02:06:15PM -0500, Gustavo A. R. Silva escreveu:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> 
> Can you split this into a kernel part and tools/ one? Also this is not
> really just for "perf script", so please adjust the subject line too :-)
> 

Sure thing. :)

Is that OK if I use "perf: " for the tools part and "perf/x86: " for the
kernel part?

Thanks
--
Gustavo
