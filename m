Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A882D3D73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLIIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:32:35 -0500
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:48406 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgLIIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:32:24 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 07A3E1801999C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 08:31:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0AA3F837F24C;
        Wed,  9 Dec 2020 08:31:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6737:7901:7903:8603:8660:10004:10400:10471:10848:11026:11232:11473:11658:11914:12043:12048:12109:12296:12297:12438:12679:12740:12760:12895:13148:13161:13229:13230:13255:13439:14181:14659:14721:21080:21433:21451:21627:21939:21990:30003:30012:30029:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: plot14_2110887273ee
X-Filterd-Recvd-Size: 4116
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Dec 2020 08:30:59 +0000 (UTC)
Message-ID: <f54fcb1e9f90b529826d8d6abb2ae99b15108d16.camel@perches.com>
Subject: Re: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by
 creating sub-functions for each ioctl command
From:   Joe Perches <joe@perches.com>
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Seamus Kelly <seamus.kelly@intel.com>
In-Reply-To: <20201201223511.65542-23-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-23-mgross@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Wed, 09 Dec 2020 00:30:46 -0800
MIME-Version: 1.0
User-Agent: Evolution 3.38.1-1 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> Refactor the too large IOCTL function to call helper functions.
[]
> diff --git a/drivers/misc/xlink-core/xlink-ioctl.c b/drivers/misc/xlink-core/xlink-ioctl.c
[]
> +int ioctl_write_data(unsigned long arg)
> +{
> +	struct xlink_handle	devh	= {0};
> +	struct xlinkwritedata		wr	= {0};
> +	int rc = 0;
> +
> +	if (copy_from_user(&wr, (void __user *)arg,
> +			   sizeof(struct xlinkwritedata)))
> +		return -EFAULT;
> +	if (copy_from_user(&devh, (void __user *)wr.handle,
> +			   sizeof(struct xlink_handle)))
> +		return -EFAULT;
> +	if (wr.size <= XLINK_MAX_DATA_SIZE) {
> +		rc = xlink_write_data_user(&devh, wr.chan, wr.pmessage,
> +					   wr.size);
> +		if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
> +				 sizeof(rc)))
> +			return -EFAULT;
> +	} else {
> +		return -EFAULT;
> +	}

Please reverse the test to reduce indentation

	if (wr.size > XLINK_MAX_DATA_SIZE)
		return -EFAULT;
	rc = xlink_write_data_user(&devh, wr.chan, wr.pmessage, wr.size);
	if (copy_to_user((void __user *)wr.return_code, (void *)&rc, sizeof(rc)))
		return -EFAULT;
	return rc;

The last 3 lines here are repeated multiple times in many functions.
It might be sensible to add something like:

int copy_result_to_user(u32 *where, int rc)
{
	if (copy_to_user((void __user *)where, &rc, sizeof(rc)))
		return -EFAULT;
	return rc;
}

so this could be written

	rc = xlink_write_data_user(&devh, wr.chan, wr.pmessage, wr.size);

	return copy_result_to_user(wr.return_code, rc);

IMO: return_code isn't a great name for a pointer as it rather
indicates a value not an address and there's an awful lot of
casting to __user in all this code that perhaps should be marked
in the struct definitions rather than inside the function uses.

> +}
> +
> +int ioctl_write_control_data(unsigned long arg)
> +{
> +	struct xlink_handle	devh	= {0};

All of these initializations with {0} should use {} instead as
the first element of whatever struct is not guaranteed to be
assignable as an int and gcc/clang guarantee 0 initialization

> +	struct xlinkwritedata		wr	= {0};
> +	u8 volbuf[XLINK_MAX_BUF_SIZE];
> +	int rc = 0;
> +
> +	if (copy_from_user(&wr, (void __user *)arg,
> +			   sizeof(struct xlinkwritedata)))
> +		return -EFAULT;
> +	if (copy_from_user(&devh, (void __user *)wr.handle,
> +			   sizeof(struct xlink_handle)))
> +		return -EFAULT;
> +	if (wr.size <= XLINK_MAX_CONTROL_DATA_SIZE) {
> +		if (copy_from_user(volbuf, (void __user *)wr.pmessage,
> +				   wr.size))
> +			return -EFAULT;
> +		rc = xlink_write_control_data(&devh, wr.chan, volbuf,
> +					      wr.size);
> +		if (copy_to_user((void __user *)wr.return_code,
> +				 (void *)&rc, sizeof(rc)))
> +			return -EFAULT;
> +	} else {
> +		return -EFAULT;

Same test reversal and deindentation please.

> +	}
> +	return rc;
> +}
> +


