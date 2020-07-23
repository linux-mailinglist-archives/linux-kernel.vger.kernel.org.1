Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3722B71A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGWUBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:01:48 -0400
Received: from ms.lwn.net ([45.79.88.28]:42266 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgGWUBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:01:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA11D2BA;
        Thu, 23 Jul 2020 20:01:47 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:01:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     <linux-doc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] docs: kprobes: Update URLs and move under trace/
Message-ID: <20200723140146.714839f8@lwn.net>
In-Reply-To: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 17:18:19 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This series updates some of the URLs in the kprobes document and moves 
> the same under trace/ directory.
> 
> - Naveen
> 
> 
> Naveen N. Rao (3):
>   docs: staging/kprobes.rst: Update some of the references
>   docs: staging/kprobes.rst: Move references to a separate appendix
>   docs: Move kprobes.rst from staging/ to trace/
> 
>  Documentation/staging/index.rst              |  1 -
>  Documentation/trace/index.rst                |  1 +
>  Documentation/{staging => trace}/kprobes.rst | 16 +++++++++-------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>  rename Documentation/{staging => trace}/kprobes.rst (99%)

I've applied the set, thanks.

jon
