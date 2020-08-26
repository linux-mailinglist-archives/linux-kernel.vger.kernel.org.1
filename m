Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CE25379D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHZSxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgHZSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:53:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8DA2078A;
        Wed, 26 Aug 2020 18:53:29 +0000 (UTC)
Date:   Wed, 26 Aug 2020 14:53:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
Message-ID: <20200826145327.7530b2e5@oasis.local.home>
In-Reply-To: <mhng-5de4c6ca-7e77-4b55-9097-59296872e6de@palmerdabbelt-glaptop1>
References: <20200813113743.001b6c31@oasis.local.home>
        <mhng-5de4c6ca-7e77-4b55-9097-59296872e6de@palmerdabbelt-glaptop1>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 17:29:32 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I pointed out in the patch notes that it seems reasonable to have the generic
> code handle this case, would you be opposed to doing it that way?

For now, lets hold off and see if other archs start to do it the same
way. Then we should look into making it more generic. It's an easy
enough fix per arch, so there's no urgency to this.

-- Steve
