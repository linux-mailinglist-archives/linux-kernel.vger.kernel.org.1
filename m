Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF63C1D21C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 00:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgEMWNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 18:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730794AbgEMWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:13:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054E8C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:13:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so3395095pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6RXpgluKwXPp3KRCdiHCqL2rdUeYjnysCP7SSKxBOM=;
        b=LGDhXSd0LFpWl0o4hxng7L0J/q4lMorH0G9DAzNLEG6GsWcHLUtoAH9bXfmTzMvKRa
         MisrArcyuTh1Bsi5exkoTVN7yPz3JxQZ7ZmU2nWMe1VMvRBilgdpvx+CZ0zvuHMO0Ff5
         NFroCGOcnA/3y1zhVVW/FjOG2/QonmXAuEaIRFDjjofin1chGunmrkyLBuz1/KgOVJmP
         G0JVlbFeyvOhfPfxuEHvNmMd0b7BfVwAlbHyBl2Rqfh8LlvooW/O/KR4lZVNFGOhamDm
         MSrZef83Fqmuwe5ckDlVz19PjhbP1SGvTVLwScfx/1jq9n4OQ4m0pp94Yi+2AxVEI2sa
         U/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6RXpgluKwXPp3KRCdiHCqL2rdUeYjnysCP7SSKxBOM=;
        b=cLY41be99kAvn2kdyVc/9lEElz7v1rqNKpHTdKHczXdyPiZ26WXMEsVNjnPKT/vDJo
         O/LQAkk0bm5aWa7hd/bCaGquWXNcb7AcmTopxJv7cDClC1awF6K0je/ve5yCrdquhsIC
         ecOMFIrWeBPcpie//ZaXteRvQZSzxaP/iQi6JeMKin+Vgr3ZNFInYgo/bFKHBac6adX9
         UmNFRwOxv+wOJ9DQoCd0RCgTv6QJ300C8P+zPobSJUgsyf8meUcAkgINs3LaBJdL31If
         YEVZCIMCCCHyxOBIiGjzELEurkG60tIW25yitj1+J6Qb7LWIfrmQfXoMqjeU4y+ZPcm5
         N11Q==
X-Gm-Message-State: AOAM532fiJzevudUQPPsgImTvQWYMJo3wawCbj05kQoNpoMnive4ZGSI
        gi2ss5yQYD02GEwdGulklExkTg==
X-Google-Smtp-Source: ABdhPJyplZyfECUA4JUBp4ymP477fQ0nX0LINWjlkQLJAuqkagunu2xqRi+StBi4BXbgxBkDbzGzgg==
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr1277189plm.198.1589408025407;
        Wed, 13 May 2020 15:13:45 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y24sm456127pfn.211.2020.05.13.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 15:13:44 -0700 (PDT)
Date:   Wed, 13 May 2020 16:13:42 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH V5 5/5] rpmsg: glink: unregister rpmsg device during
 endpoint destroy
Message-ID: <20200513221342.GC8328@xps15>
References: <1589346606-15046-1-git-send-email-aneela@codeaurora.org>
 <1589346606-15046-6-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589346606-15046-6-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:40:06AM +0530, Arun Kumar Neelakantam wrote:
> Rpmsg device unregister is not happening if channel close is triggered
> from local side and causing re-registration of device failures.
> 
> Unregister rpmsg device for local close in endpoint destroy path.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 0e8a28c0..fc8ef66 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1207,6 +1207,7 @@ static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
>  {
>  	struct glink_channel *channel = to_glink_channel(ept);
>  	struct qcom_glink *glink = channel->glink;
> +	struct rpmsg_channel_info chinfo;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&channel->recv_lock, flags);
> @@ -1214,6 +1215,13 @@ static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
>  	spin_unlock_irqrestore(&channel->recv_lock, flags);
>  
>  	/* Decouple the potential rpdev from the channel */
> +	if (channel->rpdev) {

If we proceed this way no other channel can have an rpdev.  I would hope that
unregistration of rpdev would be more symetrical to what is done in patch 03.

Thanks,
Mathieu

> +		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
> +		chinfo.src = RPMSG_ADDR_ANY;
> +		chinfo.dst = RPMSG_ADDR_ANY;
> +
> +		rpmsg_unregister_device(glink->dev, &chinfo);
> +	}
>  	channel->rpdev = NULL;
>  
>  	qcom_glink_send_close_req(glink, channel);
> @@ -1477,6 +1485,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
>  
>  		rpmsg_unregister_device(glink->dev, &chinfo);
>  	}
> +	channel->rpdev = NULL;
>  
>  	qcom_glink_send_close_ack(glink, channel->rcid);
>  
> -- 
> 2.7.4
