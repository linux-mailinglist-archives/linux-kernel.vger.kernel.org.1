Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBD22D8F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGYRgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 13:36:09 -0400
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:24279 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgGYRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:36:08 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20200725173607.FDNZ4114.sa-prd-fep-046.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sat, 25 Jul 2020 18:36:07 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [86.152.161.91]
X-OWM-Source-IP: 86.152.161.91 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrheehgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpedfoeflohhhnhcuqfhlughmrghnqedfuceojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqeenucggtffrrghtthgvrhhnpeffveekffekffefhfevvdevieelvdduuedvteeviefgteetfeffffekieduieekveenucfkphepkeeirdduhedvrdduiedurdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihpdhinhgvthepkeeirdduhedvrdduiedurdeluddpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeouggvvhgvlhesughrihhvvghruggvvhdrohhsuhhoshhlrdhorhhgqedprhgtphhtthhopeeoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqedprhgtphhtthhopeeoghhushhtrghvohesvghmsggvugguvgguohhrrdgtohhmqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry (86.152.161.91) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5ED9B8A708925B5B; Sat, 25 Jul 2020 18:36:06 +0100
Date:   Sat, 25 Jul 2020 18:36:05 +0100
From:   "<John Oldman>" <john.oldman@polehill.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH V3] staging: rtl8723bs: core: Using comparison to true is
 error prone
Message-ID: <20200725173605.GA16980@henry>
References: <20200725143712.16667-1-john.oldman@polehill.co.uk>
 <20200725172124.GB405510@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725172124.GB405510@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 07:21:24PM +0200, Greg KH wrote:
> On Sat, Jul 25, 2020 at 03:37:12PM +0100, John Oldman wrote:
> > clear below issues reported by checkpatch.pl:
> > 
> > CHECK: Using comparison to true is error prone
> 
> Again, you did more than just this in the patch :(

do you mean by reducing line lengths??




