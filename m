Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E72533EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHZPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 11:44:43 -0400
Received: from smtprelay0028.hostedemail.com ([216.40.44.28]:36062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgHZPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:44:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 57C931DF9;
        Wed, 26 Aug 2020 15:44:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4031:4250:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12555:12740:12760:12895:13069:13149:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21740:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: knot54_5a184f527065
X-Filterd-Recvd-Size: 2176
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 15:44:32 +0000 (UTC)
Message-ID: <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 08:44:30 -0700
In-Reply-To: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> We have got already new users of this API which interpret it differently
> and miss the opportunity to optimize their code.
> 
> In order to avoid similar cases in the future, annotate dev_err_probe()
> with __must_check.
> 
> Fixes: a787e5400a1c ("driver core: add device probe log helper")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ca18da4768e3..f9d2e5703bbf 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -978,7 +978,7 @@ void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>  
>  extern __printf(3, 4)
> -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);

Generally, the __must_check should go before the return type
and the extern isn't necessary and is also generally not used
in device.h, so I'd prefer:

__printf(3, 4)
__must_check int dev_err_probe(...);


