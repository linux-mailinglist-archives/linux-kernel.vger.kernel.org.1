Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD194214F75
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgGEUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 16:41:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:51760 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgGEUlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:41:14 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4E92E846;
        Sun,  5 Jul 2020 20:41:14 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:41:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 0/3] Documentation: trace: eliminate doubled words
Message-ID: <20200705144113.3e070976@lwn.net>
In-Reply-To: <20200703212453.30553-1-rdunlap@infradead.org>
References: <20200703212453.30553-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 14:24:50 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix doubled (duplicated) words in trace documentation.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> 
>  Documentation/trace/ftrace.rst           |    4 ++--
>  Documentation/trace/histogram-design.rst |    4 ++--
>  Documentation/trace/stm.rst              |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
Applied, thanks.

jon
