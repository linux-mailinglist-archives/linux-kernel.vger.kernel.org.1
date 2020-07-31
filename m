Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C873E2341BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgGaJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 05:00:12 -0400
Received: from verein.lst.de ([213.95.11.211]:58594 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731998AbgGaJAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:00:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5382768BFE; Fri, 31 Jul 2020 11:00:09 +0200 (CEST)
Date:   Fri, 31 Jul 2020 11:00:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] modules: inherit TAINT_PROPRIETARY_MODULE
Message-ID: <20200731090008.GA12930@lst.de>
References: <20200730061027.29472-1-hch@lst.de> <20200730061027.29472-9-hch@lst.de> <20200730141232.GA31539@linux-8ccs> <20200730162957.GA22469@lst.de> <20200731085129.GA20130@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731085129.GA20130@linux-8ccs>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:51:30AM +0200, Jessica Yu wrote:
>> +	if (mod->using_gplonly_symbols) {
>> +		pr_info("%s: module using GPL-only symbols uses symbols from proprietary module %s.\n",
>> +			mod->name, owner->name);
>
> pr_err() maybe?
>
>> +		return false;
>> +	}
>> +
>> +	if (!test_bit(TAINT_PROPRIETARY_MODULE, &mod->taints)) {
>> +		pr_info("%s: module uses symbols from proprietary module %s, inheriting taint.\n",
>> +			mod->name, owner->name);
>
> and pr_warn()? But otherwise this looks much better.

Ok with me.  Can you just fix it up, or do you want a full resend?
