Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9231B93F7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgDZUh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 16:37:28 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:51304 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:37:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5FA14182CED34;
        Sun, 26 Apr 2020 20:37:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2919:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:4250:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:21990:22047:30012:30054:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bite55_40f3731081a4e
X-Filterd-Recvd-Size: 2161
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Apr 2020 20:37:26 +0000 (UTC)
Message-ID: <0480c38b2e164ab0c25aae2db628c221ea0da111.camel@perches.com>
Subject: Re: [PATCH 5/5] coresight: Avoid casting void pointers
From:   Joe Perches <joe@perches.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Date:   Sun, 26 Apr 2020 13:37:25 -0700
In-Reply-To: <20200426185805.14923-6-swboyd@chromium.org>
References: <20200426185805.14923-1-swboyd@chromium.org>
         <20200426185805.14923-6-swboyd@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-26 at 11:58 -0700, Stephen Boyd wrote:
> We don't need to cast void pointers, such as the amba_id data. Assign to
> a local variable to make the code prettier and also return NULL instead
> of 0 to make sparse happy.
[]
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
[]
> @@ -206,9 +206,12 @@ cti_remove_assoc_from_csdev(struct coresight_device *csdev) {}
>  /* extract the data value from a UCI structure given amba_id pointer. */
>  static inline void *coresight_get_uci_data(const struct amba_id *id)
>  {
> -	if (id->data)
> -		return ((struct amba_cs_uci_id *)(id->data))->data;
> -	return 0;
> +	struct amba_cs_uci_id *uci_id = id->data;
> +
> +	if (uci_id)
> +		return id->data;

Missing one more level of indirection here yes?

		return uci_id->data;

> +
> +	return NULL;
>  }

And this code would generally be written to return the expected
value at the bottom of the function and any unusual return
early like:

static inline void *coresight_get_uci_data(const struct amba_id *id)
{
	struct amba_cs_uci_id *uci_id = id->data;

	if (!uci_id)
		return NULL;

	return uci_id->data;
}


