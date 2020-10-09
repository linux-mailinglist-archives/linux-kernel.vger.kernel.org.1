Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B32289B55
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbgJIV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:59:15 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38688 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733201AbgJIV7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:59:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 07AFB29EB2;
        Fri,  9 Oct 2020 17:59:10 -0400 (EDT)
Date:   Sat, 10 Oct 2020 08:59:03 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Laurent Vivier <laurent@vivier.eu>
cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>
Subject: Re: [PATCH] m68k: remove unused mach_max_dma_address
In-Reply-To: <20201009095621.833192-1-laurent@vivier.eu>
Message-ID: <alpine.LNX.2.23.453.2010100857270.12@nippy.intranet>
References: <20201009095621.833192-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020, Laurent Vivier wrote:

> This information is unused since the discontinuous memory support
> has been introduced in 2007.
> 
> Fixes: 12d810c1b8c2 ("m68k: discontinuous memory support")

Does this qualify as a bug fix?
