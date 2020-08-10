Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2224224068E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 15:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHJN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 09:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgHJN1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:27:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD6F20748;
        Mon, 10 Aug 2020 13:27:45 +0000 (UTC)
Date:   Mon, 10 Aug 2020 09:27:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Gregory Herrero <gregory.herrero@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] recordmcount: Fix build failure on non arm64
Message-ID: <20200810092743.21115164@oasis.local.home>
In-Reply-To: <20200810121855.GD9480@gaia>
References: <5ca1be21fa6ebf73203b45fd9aadd2bafb5e6b15.1597049145.git.christophe.leroy@csgroup.eu>
        <20200810091730.GA3099@ltoracle>
        <20200810121855.GD9480@gaia>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 13:18:55 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> > Oops, thanks for fixing this.
> > 
> > Acked-by: Gregory Herrero <gregory.herrero@oracle.com>  
> 
> Thanks. I'll queue it via the arm64 tree (as I did with the previous
> fix) but I'll wait a bit for Steve to ack it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
