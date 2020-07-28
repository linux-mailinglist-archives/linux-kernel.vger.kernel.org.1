Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912DA230937
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgG1Lzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 07:55:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59587 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgG1Lzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:55:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595937334; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=aMLCLRF6gA546+4gAdULk8Xwn0G11bwCEDN5G+ke5tQ=;
 b=byfXRRBAz9cIMYxFcPLD1eEiOiDvyXxDkAklXYEAeHQUXBCtIQgA7SrY9qmrwbZLgoNwpfl9
 KElMX68/VDLq/H15+B60DHImzeNpdBryJ97Oyg69xZnhj59u4hEEGv+yOT8naUIB5h0F2AGr
 PR0QZ9fwy+Xbmxzd2R3Ha4qVVe8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f201222bd0c3f02966d3ca1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 11:55:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27302C433C9; Tue, 28 Jul 2020 11:55:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E81AC433C6;
        Tue, 28 Jul 2020 11:55:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 17:25:13 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: sm8150: add interconnect nodes
In-Reply-To: <20200728023811.5607-7-jonathan@marek.ca>
References: <20200728023811.5607-1-jonathan@marek.ca>
 <20200728023811.5607-7-jonathan@marek.ca>
Message-ID: <8eaf4f2df727390963ffe13c29712c2c@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-28 08:08, Jonathan Marek wrote:
> Add the interconnect dts nodes for sm8150.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 82 ++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 33ff99132f4f..e4689c27224b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,gcc-sm8150.h>
>  #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
> +#include <dt-bindings/interconnect/qcom,sm8150.h>
>  #include <dt-bindings/thermal/thermal.h>
> 
>  / {
> @@ -440,6 +441,55 @@ uart2: serial@a90000 {
>  			};
>  		};
> 
> +		config_noc: interconnect@1500000 {
> +			compatible = "qcom,sm8150-config-noc";
> +			reg = <0 0x01500000 0 0x7400>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		system_noc: interconnect@1620000 {
> +			compatible = "qcom,sm8150-system-noc";
> +			reg = <0 0x01620000 0 0x19400>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		mc_virt: interconnect@163a000 {
> +			compatible = "qcom,sm8150-mc-virt";
> +			reg = <0 0x0163a000 0 0x1000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre1_noc: interconnect@16e0000 {
> +			compatible = "qcom,sm8150-aggre1-noc";
> +			reg = <0 0x016e0000 0 0xd080>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			compatible = "qcom,sm8150-aggre2-noc";
> +			reg = <0 0x01700000 0 0x20000>;

Though aggre2_noc might need a
larger space in the future lets
lands ^^ for now.

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		compute_noc: interconnect@1720000 {
> +			compatible = "qcom,sm8150-compute-noc";
> +			reg = <0 0x01720000 0 0x7000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		mmss_noc: interconnect@1740000 {
> +			compatible = "qcom,sm8150-mmss-noc";
> +			reg = <0 0x01740000 0 0x1c100>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		ufs_mem_hc: ufshc@1d84000 {
>  			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
>  				     "jedec,ufs-2.0";
> @@ -510,6 +560,13 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>  			};
>  		};
> 
> +		ipa_virt: interconnect@1e00000 {
> +			compatible = "qcom,sm8150-ipa-virt";
> +			reg = <0 0x01e00000 0 0x1000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -860,6 +917,20 @@ usb_2_ssphy: lane@88eb200 {
>  			};
>  		};
> 
> +		dc_noc: interconnect@9160000 {
> +			compatible = "qcom,sm8150-dc-noc";
> +			reg = <0 0x09160000 0 0x3200>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		gem_noc: interconnect@9680000 {
> +			compatible = "qcom,sm8150-gem-noc";
> +			reg = <0 0x09680000 0 0x3e200>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		usb_1: usb@a6f8800 {
>  			compatible = "qcom,sm8150-dwc3", "qcom,dwc3";
>  			reg = <0 0x0a6f8800 0 0x400>;
> @@ -950,6 +1021,13 @@ usb_2_dwc3: dwc3@a800000 {
>  			};
>  		};
> 
> +		camnoc_virt: interconnect@ac00000 {
> +			compatible = "qcom,sm8150-camnoc-virt";
> +			reg = <0 0x0ac00000 0 0x1000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		aoss_qmp: power-controller@c300000 {
>  			compatible = "qcom,sm8150-aoss-qmp";
>  			reg = <0x0 0x0c300000 0x0 0x100000>;
> @@ -1280,6 +1358,10 @@ rpmhpd_opp_turbo_l1: opp11 {
>  					};
>  				};
>  			};
> +
> +			apps_bcm_voter: bcm_voter {
> +				compatible = "qcom,bcm-voter";
> +			};
>  		};
> 
>  		cpufreq_hw: cpufreq@18323000 {

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
