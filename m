Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666D22341C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 11:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgGaJCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 05:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgGaJCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:02:02 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2F420829;
        Fri, 31 Jul 2020 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596186121;
        bh=VzvDxOpkpDZeBLAYV54kZ8yZopl5rEXjUzBrDCd3zSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL1TFZmpDLGhfJknLM2RJu5Xk+SHb73kDz+3rl2Oc5dLSCGQe01OPVfQlVVqZOjEI
         W+S1QTHvxDjL5yBxzYLQXeh3v/e7bI+SSweD46NVPhpOVkYfMu09fgLVAcAH8T4afh
         7dzfgm2kUe2j2mvTdnuRh6kJZso8i7NTH1UI5BzY=
Date:   Fri, 31 Jul 2020 11:01:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] modules: inherit TAINT_PROPRIETARY_MODULE
Message-ID: <20200731090154.GB20130@linux-8ccs>
References: <20200730061027.29472-1-hch@lst.de>
 <20200730061027.29472-9-hch@lst.de>
 <20200730141232.GA31539@linux-8ccs>
 <20200730162957.GA22469@lst.de>
 <20200731085129.GA20130@linux-8ccs>
 <20200731090008.GA12930@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200731090008.GA12930@lst.de>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Christoph Hellwig [31/07/20 11:00 +0200]:
>On Fri, Jul 31, 2020 at 10:51:30AM +0200, Jessica Yu wrote:
>>> +	if (mod->using_gplonly_symbols) {
>>> +		pr_info("%s: module using GPL-only symbols uses symbols from proprietary module %s.\n",
>>> +			mod->name, owner->name);
>>
>> pr_err() maybe?
>>
>>> +		return false;
>>> +	}
>>> +
>>> +	if (!test_bit(TAINT_PROPRIETARY_MODULE, &mod->taints)) {
>>> +		pr_info("%s: module uses symbols from proprietary module %s, inheriting taint.\n",
>>> +			mod->name, owner->name);
>>
>> and pr_warn()? But otherwise this looks much better.
>
>Ok with me.  Can you just fix it up, or do you want a full resend?

I can fix it up, no need to resend. Thanks!
