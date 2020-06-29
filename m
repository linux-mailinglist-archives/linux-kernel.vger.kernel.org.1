Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB21E20D115
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgF2SiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:38:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728001AbgF2SiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593455896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R99ss63BUFWwoVTJOpLbdpSFm6kFyzl0vl5jaR1UOQE=;
        b=DMRKm+PEWXYJ1h6K3HIVDNTLDQpexLqfYit6j/PTzrpGjmShfYaT0QS3iACoEjIbxgBlIu
        Jr/I9aMi7ywCdU0h15VmgEfUWn4ykaGE/NdOjDEqIam6mHn5G7jCHHk17kMFD59Pmh+Xob
        6gw0o9FXKAf9MCqsAwBxVO2TA66b+3Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-isuCXy7xNrSsAUXUxvLUxA-1; Mon, 29 Jun 2020 07:35:55 -0400
X-MC-Unique: isuCXy7xNrSsAUXUxvLUxA-1
Received: by mail-ed1-f71.google.com with SMTP id x20so14009769edr.20
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R99ss63BUFWwoVTJOpLbdpSFm6kFyzl0vl5jaR1UOQE=;
        b=EGgACwCK3YXHowFZl4VwI386RvySFt5iyE2Hkii9HKZ37eYrZ2QknP1Aw8QUKezfip
         uYGIAm0+1UwZxXoJ+uDsvgzP30sNiUftZGLOzOFmK9EO8xmJInnh06uz1IFqoNRhyjrC
         a12hTHUXqdTNTV1+QcYz3ym+LA1zzSN43Ny7LYZHGKGqkPK/M4NQx+mgwPDlScwwFQlW
         TAM4m2hssJU7HkclB5Dya+79x7+TRlkeFq6ugbeHQYtbZI+pKHY/Aqu+eTO/pcfngBxE
         fbd5TRW9gcVoxbl3JT3OaNVZfQ0xqcs0Hb4RcYC8Zg40UaE+VfHSrRg/f1onGprpUl4y
         NbYg==
X-Gm-Message-State: AOAM531cphA0oPN1PsYOsOXek0PWkqaBb4ajGnwZW9mxL/YYpi9+c8sr
        GQ8uG2NP7FW/MC+7kXOHEG0DVOv2nHifie0lk/vT6oVlegw4X1ABQRgWnGuotPczbrPS1OwAFoD
        LzWpVgo+y4dDYQmMSIyMccPlD
X-Received: by 2002:a50:e883:: with SMTP id f3mr17440209edn.220.1593430553904;
        Mon, 29 Jun 2020 04:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwJIGYRCpIxnD23fTjHfHV6n5mRstLkCBYdh8pYGwyaMC4yak38mPYlTddmtbQZ9eVQCpEeg==
X-Received: by 2002:a50:e883:: with SMTP id f3mr17440192edn.220.1593430553710;
        Mon, 29 Jun 2020 04:35:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q21sm24104189ejd.30.2020.06.29.04.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 04:35:53 -0700 (PDT)
Subject: Re: [PATCH v2] brcmfmac: Transform compatible string for FW loading
To:     matthias.bgg@kernel.org, arend.vanspriel@broadcom.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com, mbrugger@suse.com,
        netdev@vger.kernel.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, hante.meuleman@broadcom.com,
        linux-kernel@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com
References: <20200629110141.22419-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c96ec748-ded7-7e3e-e00c-222d80bde152@redhat.com>
Date:   Mon, 29 Jun 2020 13:35:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629110141.22419-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/20 1:01 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The driver relies on the compatible string from DT to determine which
> FW configuration file it should load. The DTS spec allows for '/' as
> part of the compatible string. We change this to '-' so that we will
> still be able to load the config file, even when the compatible has a
> '/'. This fixes explicitly the firmware loading for
> "solidrun,cubox-i/q".
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
> Changes in v2:
> - use strscpy instead of strncpy (Hans de Goede)
> - use strlen(tmp) + 1 for allocation (Hans de Goede, kernel test robot)
> 
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c  | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index b886b56a5e5a..5f0ebaf4d64e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -17,7 +17,6 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   {
>   	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>   	struct device_node *root, *np = dev->of_node;
> -	struct property *prop;
>   	int irq;
>   	u32 irqf;
>   	u32 val;
> @@ -25,8 +24,21 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   	/* Set board-type to the first string of the machine compatible prop */
>   	root = of_find_node_by_path("/");
>   	if (root) {
> -		prop = of_find_property(root, "compatible", NULL);
> -		settings->board_type = of_prop_next_string(prop, NULL);
> +		int i;
> +		char *board_type;
> +		const char *tmp;
> +
> +		of_property_read_string_index(root, "compatible", 0, &tmp);
> +
> +		/* get rid of '/' in the compatible string to be able to find the FW */
> +		board_type = devm_kzalloc(dev, strlen(tmp) + 1, GFP_KERNEL);
> +		strscpy(board_type, tmp, sizeof(board_type));

sizeof(board_type) == sizeof(char *) == 4 or 8 bytes, which is not what you
want. Maybe store strlen() + 1 in an int len to avoid having to call it 2 times?

> +		for (i = 0; i < strlen(board_type); i++) {

And here you probably want to use:

		for (i = 0; board_type[i]; i++) {

Rather then calling strlen many times again (in theory each step
through the loop).

Regards,

Hans



> +			if (board_type[i] == '/')
> +				board_type[i] = '-';
> +		}
> +		settings->board_type = board_type;
> +
>   		of_node_put(root);
>   	}
>   
> 

