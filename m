Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA120D3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgF2TCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:02:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52563 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgF2TCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593457365; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7RTKsK1vkgMcrQEAHJsfsvSNG30HIOc0GMqPzPCA89A=;
 b=jqXAyz0NQ0OH5YAaJmZhUgdjw5hEbwLF98+VJcK/1EV901O3f/1cwdNgPYQsr2kDVDBFYUKk
 FeoxDOQt//2YldW3yt1DZUju5y7CZSdl9GMmBxzvwOpwN21lCJtYQZwWn/um4Gl0qi+UTbXA
 hm3pR6FfRQsZbXP60izqXEMAtxs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ef9f192c4bb4f886d603937 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 13:50:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A36BDC43395; Mon, 29 Jun 2020 13:50:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: harigovi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1502AC433C8;
        Mon, 29 Jun 2020 13:50:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Jun 2020 19:20:09 +0530
From:   harigovi@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
Subject: Re: [v3] arm64: dts: sc7180: add nodes for idp display
In-Reply-To: <159304723830.62212.5069780400830519255@swboyd.mtv.corp.google.com>
References: <20200217085842.28333-1-harigovi@codeaurora.org>
 <159304723830.62212.5069780400830519255@swboyd.mtv.corp.google.com>
Message-ID: <5c2265e82af8f755d649c0c36a462f19@codeaurora.org>
X-Sender: harigovi@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 06:37, Stephen Boyd wrote:
> Quoting Harigovindan P (2020-02-17 00:58:42)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts 
>> b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> index 388f50ad4fde..349db8fe78a5 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> @@ -232,6 +233,57 @@ vreg_bob: bob {
>>         };
>>  };
>> 
>> +&dsi0 {
>> +       status = "okay";
>> +
>> +       vdda-supply = <&vreg_l3c_1p2>;
>> +
>> +       panel@0 {
>> +               compatible = "visionox,rm69299-1080p-display";
>> +               reg = <0>;
>> +
>> +               vdda-supply = <&vreg_l8c_1p8>;
>> +               vdd3p3-supply = <&vreg_l18a_2p8>;
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&disp_pins>;
>> +
>> +               reset-gpios = <&pm6150l_gpio 3 GPIO_ACTIVE_HIGH>;
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       port@0 {
>> +                               reg = <0>;
>> +                               panel0_in: endpoint {
>> +                                       remote-endpoint = <&dsi0_out>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       ports {
>> +               port@1 {
>> +                       endpoint {
>> +                               remote-endpoint = <&panel0_in>;
>> +                               data-lanes = <0 1 2 3>;
> 
> Is this property needed? If it's the default assumption it would be 
> nice
> to omit it so that we don't have to think about it.
> This property is needed during panel probe. If this is not mentioned 
> here,
mipi_dsi_attach() will fail during panel probe. In dsi_host.c, 
dsi_host_attach()
fails since dsi lanes are greater than msm_host lanes. msm_host lanes 
are updated
as part of dsi_host_parse_dt. If we dont provide data-lanes in dt, it'll 
have default
value and fail in dsi_host_attach().
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&dsi_phy {
>> +       status = "okay";
>> +};
>> +
>> +&mdp {
>> +       status = "okay";
>> +};
>> +
>> +&mdss {
>> +       status = "okay";
>> +};
>> +
>>  &qspi {
>>         status = "okay";
>>         pinctrl-names = "default";
>> @@ -289,6 +341,17 @@ &usb_1_qmpphy {
>> 
>>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>> 
>> +&pm6150l_gpio {
>> +       disp_pins: disp-pins {
> 
> Curious how this works. It looks like PMIC GPIOS are expecting the node
> to look like:
> 
> 	disp_pins: disp-pins {
> 		pinconf {
> 			pins = "gpio3";
> 			function = PMIC_GPIO_FUNC_FUNC1;
> 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_MED>;
> 			power-source = <PM6150_GPIO_VPH>;
> 			bias-disable;
> 			output-low;
> 		};
> 
> but this doesn't use the macros or the subnode for pinconf. Why? Also,
> the PM6150_GPIO_VPH macro doesn't exist.
We are discussing with PMIC team to have that macro in the header file.
Will add other macros as part of next version.
> 
>> +               pins = "gpio3";
>> +               function = "func1";
>> +               qcom,drive-strength = <2>;
>> +               power-source = <0>;
>> +               bias-disable;
>> +               output-low;
>> +       };
>> +};
>> +
