Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E19292F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgJSUTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:19:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:56065 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgJSUTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:19:47 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09JKEOMG020613;
        Mon, 19 Oct 2020 15:14:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09JKEN76020608;
        Mon, 19 Oct 2020 15:14:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Oct 2020 15:14:23 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc: Fix incorrect stw{, ux, u, x} instructions in __set_pte_at
Message-ID: <20201019201423.GT2672@gate.crashing.org>
References: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu> <1b26e1b8544ea46ad0da102d1367694cd23c222c.1603109522.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b26e1b8544ea46ad0da102d1367694cd23c222c.1603109522.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:12:47PM +0000, Christophe Leroy wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> The placeholder for instruction selection should use the second
> argument's operand, which is %1, not %0. This could generate incorrect
> assembly code if the instruction selection for argument %0 ever differs
> from argument %1.

"Instruction selection" isn't correct here...  "if the memory addressing
of operand 0 is a different form from that of operand 1", perhaps?

The patch looks fine of course :-)

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
