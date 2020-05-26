Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B141DA8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 05:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgETDeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 23:34:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:41327 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727029AbgETDeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:34:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589945657; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kT7pJZVYUNeErjNCfzDEueg8X+vHXLZgH98ZFiEznHw=;
 b=QjMjZhbbZLFp67fyDWu7F9lu4yHDq9tl1fWlPg9AzWbOSgZ4MXc4EEgRnuqEiqOdnI5C0Wm4
 SUR28hWtwCKKNQfN++ktl9nV24MrPyE9aYUdq/TC+vUL/7Yz2yr5LdeSCBO0c3g7AYcRXr+w
 3mSBxR/BFHgmaei1U9HXDbxjxIs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ec4a539c070baad3c48b125 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 03:34:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA541C433CA; Wed, 20 May 2020 03:34:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC015C433C8;
        Wed, 20 May 2020 03:34:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 May 2020 09:04:15 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v10] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
In-Reply-To: <1589914405-6674-1-git-send-email-pillair@codeaurora.org>
References: <1589914405-6674-1-git-send-email-pillair@codeaurora.org>
Message-ID: <ce4c480a92a9162dd687a6ffcfc6a8c3@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rakesh,

On 2020-05-20 00:23, Rakesh Pillai wrote:
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v9:
> - Place the wlan_fw_mem under reserved-memory node
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  7 +++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 27 
> +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 4e9149d..38b102e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -389,6 +389,13 @@
>  	};
>  };
> 
> +&wifi {
> +	status = "okay";
> +	wifi-firmware {
> +		iommus = <&apps_smmu 0xc2 0x1>;
> +	};
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
> 
>  &qspi_clk {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f1280e0..19bd7d0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -106,6 +106,11 @@
>  			no-map;
>  		};
> 
> +		wlan_fw_mem: memory@94100000 {
> +			reg = <0 0x94100000 0 0x200000>;
> +			no-map;
> +		};
> +

You can skip ^^, its already
present as wlan_mem in the
board dts.

>  		rmtfs_mem: memory@84400000 {
>  			compatible = "qcom,rmtfs-mem";
>  			reg = <0x0 0x84400000 0x0 0x200000>;
> @@ -944,6 +949,28 @@
>  			};
>  		};
> 
> +		wifi: wifi@18800000 {
> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
> +			iommus = <&apps_smmu 0xc0 0x1>;
> +			interrupts =
> +				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0 */ >,
> +				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1 */ >,
> +				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2 */ >,
> +				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3 */ >,
> +				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4 */ >,
> +				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5 */ >,
> +				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6 */ >,
> +				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7 */ >,
> +				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8 */ >,
> +				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9 */ >,
> +				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
> +				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;
> +			memory-region = <&wlan_fw_mem>;

Its named as wlan_mem in sc7180-idp.dts

> +			status = "disabled";
> +		};
> +
>  		config_noc: interconnect@1500000 {
>  			compatible = "qcom,sc7180-config-noc";
>  			reg = <0 0x01500000 0 0x28000>;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
