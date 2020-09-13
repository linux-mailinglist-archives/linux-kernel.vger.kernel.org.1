Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BCF26811D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgIMUMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 16:12:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:11782 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgIMUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 16:12:04 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="467425457"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 22:12:02 +0200
Date:   Sun, 13 Sep 2020 22:12:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: Re: [Cocci] [RFC PATCH] scripts: coccicheck: Improve error feedback
 when coccicheck fails
In-Reply-To: <20200913120548.bwl3elfl7ss66eyh@adolin>
Message-ID: <alpine.DEB.2.22.394.2009132211430.2368@hadrien>
References: <20200913120548.bwl3elfl7ss66eyh@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Sep 2020, Sumera Priyadarsini wrote:

> Currently, coccicheck fails with only the message "coccicheck failed"
> and the error code for the failure. To obtain the error logs,
> one needs to specify a debug file using the DEBUG_FILE option.
>
> Modify coccicheck to display error logs when it crashes unless
> DEBUG_FILE is set, in which case, the error logs are stored in
> the specified debug file.

Applied, thanks.

julia

>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  scripts/coccicheck | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328210ac..dbeafa21f359 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -126,8 +126,14 @@ run_cmd_parmap() {
>  	if [ $VERBOSE -ne 0 ] ; then
>  		echo "Running ($NPROC in parallel): $@"
>  	fi
> -	echo $@ >>$DEBUG_FILE
> -	$@ 2>>$DEBUG_FILE
> +	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
> +                echo $@>>$DEBUG_FILE
> +                $@ 2>>$DEBUG_FILE
> +        else
> +                echo $@
> +                $@ 2>&1
> +	fi
> +
>  	err=$?
>  	if [[ $err -ne 0 ]]; then
>  		echo "coccicheck failed"
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
