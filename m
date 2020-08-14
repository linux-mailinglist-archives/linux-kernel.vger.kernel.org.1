Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397852442FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 04:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHNCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 22:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgHNCYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:24:14 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18E02078B;
        Fri, 14 Aug 2020 02:24:12 +0000 (UTC)
Date:   Thu, 13 Aug 2020 22:24:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiafei Pan <jiafei.pan@nxp.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [EXT] Re: [PATCH] softirq: add irq off checking for
 __raise_softirq_irqoff
Message-ID: <20200813222411.1728bc5a@oasis.local.home>
In-Reply-To: <AM0PR04MB4772BDE0787FD18E8E6A48C28A400@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
        <AM0PR04MB4772B1B6D3391BAEAD4411808A430@AM0PR04MB4772.eurprd04.prod.outlook.com>
        <20200813105644.1eb6f2cd@oasis.local.home>
        <AM0PR04MB4772BDE0787FD18E8E6A48C28A400@AM0PR04MB4772.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 02:21:25 +0000
Jiafei Pan <jiafei.pan@nxp.com> wrote:

> > This is probably more for Thomas Gleixner.  
> Thanks Steven.
> @Thomas Gleixner, would you please review the patch? thanks.
> Jiafei.

I believe he already did.

-- Steve
