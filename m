Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6749D255A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgH1MnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 08:43:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31868 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgH1Mmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:42:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598618570; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=c6xULzU1XsJ6TGZBb+0t/bcTsFldcoqHdKPiZhgYt0A=;
 b=fhFymwhYkkbbPcEfXLSs2GAN4RWH6P0ogmIn1WroVyjuxAPLVT2wrIjvBEeJ8EdO4cVS5Qg3
 gWpXOou3XkTeLUpFUbg51yVL7VPQy/Wo5PWNPpAOAgNvRRj/PSIbJN41idrjqo377PByQbXI
 DxWpPgrCqUnc3I3DYfbZhHNJl/E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f48fbbc9db79768eb10e006 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 12:42:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6775DC433A1; Fri, 28 Aug 2020 12:42:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75AA5C433C6;
        Fri, 28 Aug 2020 12:42:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Aug 2020 18:12:34 +0530
From:   vbadigan@codeaurora.org
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chris Ball <chris@printf.net>,
        Georgi Djakov <gdjakov@mm-sol.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-msm: Add retries when all tuning phases are
 found valid
In-Reply-To: <20200827075809.1.If179abf5ecb67c963494db79c3bc4247d987419b@changeid>
References: <20200827075809.1.If179abf5ecb67c963494db79c3bc4247d987419b@changeid>
Message-ID: <f986b516b37dbb788330334468af07cf@codeaurora.org>
X-Sender: vbadigan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 20:28, Douglas Anderson wrote:
> As the comments in this patch say, if we tune and find all phases are
> valid it's _almost_ as bad as no phases being found valid.  Probably
> all phases are not really reliable but we didn't detect where the
> unreliable place is.  That means we'll essentially be guessing and
> hoping we get a good phase.
> 
> This is not just a problem in theory.  It was causing real problems on
> a real board.  On that board, most often phase 10 is found as the only
> invalid phase, though sometimes 10 and 11 are invalid and sometimes
> just 11.  Some percentage of the time, however, all phases are found
> to be valid.  When this happens, the current logic will decide to use
> phase 11.  Since phase 11 is sometimes found to be invalid, this is a
> bad choice.  Sure enough, when phase 11 is picked we often get mmc
> errors later in boot.
> 
> I have seen cases where all phases were found to be valid 3 times in a
> row, so increase the retry count to 10 just to be extra sure.
> 
> Fixes: 415b5a75da43 ("mmc: sdhci-msm: Add platform_execute_tuning
> implementation")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 

Thanks for adding this logic.

Reviewed-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>


>  drivers/mmc/host/sdhci-msm.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c 
> b/drivers/mmc/host/sdhci-msm.c
> index b7e47107a31a..1b78106681e0 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1165,7 +1165,7 @@ static void sdhci_msm_set_cdr(struct sdhci_host
> *host, bool enable)
>  static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	int tuning_seq_cnt = 3;
> +	int tuning_seq_cnt = 10;
>  	u8 phase, tuned_phases[16], tuned_phase_cnt = 0;
>  	int rc;
>  	struct mmc_ios ios = host->mmc->ios;
> @@ -1221,6 +1221,22 @@ static int sdhci_msm_execute_tuning(struct
> mmc_host *mmc, u32 opcode)
>  	} while (++phase < ARRAY_SIZE(tuned_phases));
> 
>  	if (tuned_phase_cnt) {
> +		if (tuned_phase_cnt == ARRAY_SIZE(tuned_phases)) {
> +			/*
> +			 * All phases valid is _almost_ as bad as no phases
> +			 * valid.  Probably all phases are not really reliable
> +			 * but we didn't detect where the unreliable place is.
> +			 * That means we'll essentially be guessing and hoping
> +			 * we get a good phase.  Better to try a few times.
> +			 */
> +			dev_dbg(mmc_dev(mmc), "%s: All phases valid; try again\n",
> +				mmc_hostname(mmc));
> +			if (--tuning_seq_cnt) {
> +				tuned_phase_cnt = 0;
> +				goto retry;
> +			}
> +		}
> +
>  		rc = msm_find_most_appropriate_phase(host, tuned_phases,
>  						     tuned_phase_cnt);
>  		if (rc < 0)
