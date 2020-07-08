Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23009219039
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGHTKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 15:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGHTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:10:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE5C061A0B;
        Wed,  8 Jul 2020 12:10:50 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35D652D7;
        Wed,  8 Jul 2020 19:10:49 +0000 (UTC)
Date:   Wed, 8 Jul 2020 13:10:48 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: update for gcc 4.9 requirement
Message-ID: <20200708131048.30a494d1@lwn.net>
In-Reply-To: <CAHk-=wg1W=g_oUUfN6aqbWhsicuFLikHZ4B8UkT1RfEa351J_A@mail.gmail.com>
References: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
        <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com>
        <1ac6b3ba-ad54-a227-94d3-06cdf4fa4c91@infradead.org>
        <CAHk-=wg1W=g_oUUfN6aqbWhsicuFLikHZ4B8UkT1RfEa351J_A@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 12:05:16 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jul 8, 2020 at 12:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Should I resend it?  
> 
> Nah. I'm just wondering if I should apply it directly or let it go through Jon.

Either is fine with me; I can add the Fixes: tag.  If you want it in
5.8-rc, it's maybe best if you just take it directly; I don't have another
5.8 pull in the works at the moment.

jon
