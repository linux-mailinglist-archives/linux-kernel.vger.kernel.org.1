Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2458251CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHYPyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 11:54:53 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:40976 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgHYPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:54:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 59D7D18224D7E;
        Tue, 25 Aug 2020 15:54:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2194:2197:2199:2200:2393:2525:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4362:4605:5007:6119:7809:7903:9025:9149:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12740:12760:12895:13439:14181:14659:14721:21067:21080:21212:21221:21433:21451:21627:21788:30012:30034:30054:30062:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: board60_4f092392705d
X-Filterd-Recvd-Size: 2978
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 15:54:49 +0000 (UTC)
Message-ID: <9ee753e9d0b4d8fbab431b7f4761c59586f1a3f2.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Warn if trace_printk and friends are
 called
From:   Joe Perches <joe@perches.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 08:54:48 -0700
In-Reply-To: <20200825193600.v2.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
References: <20200825193600.v2.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 19:36 +0800, Nicolas Boichat wrote:
> trace_printk is meant as a debugging tool, and should not be
> compiled into production code without specific debug Kconfig
> options enabled, or source code changes, as indicated by the
> warning that shows up on boot if any trace_printk is called:
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **                                                      **
>  ** trace_printk() being used. Allocating extra memory.  **
>  **                                                      **
>  ** This means that this is a DEBUG kernel and it is     **
>  ** unsafe for production use.                           **
> 
> Let's warn developers when they try to submit such a change.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

thanks.

> ---
> See also extensive discussion under this thread:
> https://lkml.org/lkml/2020/8/20/244
> 
> This seems to be the simplest way to try to reduce the number
> of trace_printk that make it into the kernel.
> 
> Changes in v2:
>  - Use $1 directly, fix wording, remove final period.
> 
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4aa1d9d5e62c5b0..1102aa0ec2f7a05 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4272,6 +4272,12 @@ sub process {
>  			     "Prefer dev_$level(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
>  		}
>  
> +# trace_printk should not be used in production code.
> +		if ($line =~ /\b(trace_printk|trace_puts|ftrace_vprintk)\s*\(/) {
> +			WARN("TRACE_PRINTK",
> +			     "Do not use $1() in production code (this can be ignored if built only with a debug config option)\n" . $herecurr);
> +		}
> +
>  # ENOSYS means "bad syscall nr" and nothing else.  This will have a small
>  # number of false positives, but assembly files are not checked, so at
>  # least the arch entry code will not trigger this warning.

