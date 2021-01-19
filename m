Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F932FC379
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbhASWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbhASRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:45:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:44:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so13379772pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=kWBNJcIF/mmQYxN/XJRtvBsFP1lmMDlmMSbcjiUEDWs=;
        b=BZc8jbvvchOU/xeb5GjRwwxVPhi62OEvPJweNbqEphEC5LOYriBuWHWvtJGU4jWeSe
         8UTimL7RjnM6sA8QT51YZflgH5MLBfFH5AJpPMAGmSuog+qJALUcJqIjuE/cnqZNRoY4
         6xZuBBplsi2gmIrdvfKkHjZHd5n0Kc0rMtL1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=kWBNJcIF/mmQYxN/XJRtvBsFP1lmMDlmMSbcjiUEDWs=;
        b=gv2xrw1RvNLKNiTvgKb0oz098u6J5G8BoEzTEXj1Agvi07hx8QculLYaQOj9P6pTHv
         i+3xd0R6Y6pSZGUtpY2KF5cWkVc51yDHxFPs8dAmZmS7j/1HkxjQgQ08pjfEE99+Til8
         nN6VooMp5JbncgIN1ToOwLS89LwXzvKXulmIngbc8Ss3AF7lgRa1kOoS2n/4QAHv7GST
         oL5z/4Y8EMMPL5o70KvWmsYcqDTRZwsYP7PqghqwKPhmibBy2PJ35YrirTSwofciCzeH
         lnW9ea/JiT7Xd6iVy5w8Y5XEVTTbnB2pLt6wITYTnYNdBxIkquTwNJXaKbg+rrLpX0g1
         CuPg==
X-Gm-Message-State: AOAM532qqa+ZSTlmJBLjuMAHBMaaerAQfNUiKbA/YS9r6rPrlDUNznll
        L2JSPePCemcnVJcbcGjMJp/4og==
X-Google-Smtp-Source: ABdhPJyOQ3o8UuDuyx8ebtY6AKxy3XVO4gK1Rk4FtsEXCQgNa35yHx0yCwmbMzNJX0ZIwP8kXHfe2Q==
X-Received: by 2002:a05:6a00:2286:b029:1ae:6c7f:31ce with SMTP id f6-20020a056a002286b02901ae6c7f31cemr5034315pfe.6.1611078263504;
        Tue, 19 Jan 2021 09:44:23 -0800 (PST)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id w20sm16789263pga.90.2021.01.19.09.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:44:22 -0800 (PST)
Subject: Re: [PATCH v1 1/1] arm64: dts: stingray: fix usb dma address
 translation
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Bharat Gooty <bharat.gooty@broadcom.com>
References: <20210119053444.23108-1-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <2ea086ec-9af4-aaab-9ebf-a8e5986c9063@broadcom.com>
Date:   Tue, 19 Jan 2021 09:44:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119053444.23108-1-rayagonda.kokatanur@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a15aa005b9446363"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a15aa005b9446363
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 1/18/2021 9:34 PM, Rayagonda Kokatanur wrote:
> From: Bharat Gooty <bharat.gooty@broadcom.com>
> 
> Add a non-empty dma-ranges so that dma address translation
> happens.
> 
> Fixes: 2013a4b684b6 ("arm64: dts: broadcom: clear the warnings caused by empty dma-ranges")
> 
> Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
> index aef8f2b00778..5401a646c840 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
> @@ -4,11 +4,16 @@
>   */
>  	usb {
>  		compatible = "simple-bus";
> -		dma-ranges;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges = <0x0 0x0 0x0 0x68500000 0x0 0x00400000>;
>  
> +		/*
> +		 * Internally, USB bus to the interconnect can only address up
> +		 * to 40-bit
> +		 */
> +		dma-ranges = <0 0 0 0 0x100 0x0>;
> +

Should have had my signed-off since during our internal review, I added
the above comment to explain why we set it to 40-bit here despite the
USB controller itself is capable of addressing 64-bit as Arnd pointed out.

Well, the following ack should do it too, thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>

>  		usbphy0: usb-phy@0 {
>  			compatible = "brcm,sr-usb-combo-phy";
>  			reg = <0x0 0x00000000 0x0 0x100>;
> 

--000000000000a15aa005b9446363
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Gp3tsmw0Vz7IMJs6DQIm7T8CfIzeId1IIHcH02MbpO7m1Btzyz625FoBWF8CAwEAAaOCAcswggHH
MA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUHMAKGQWh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNoYTJnM29jc3AuY3J0
MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24y
c2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1UdHwQ9MDswOaA3oDWG
M2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hhMmczLmNybDAfBgNV
HREEGDAWgRRyYXkuanVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUvUTLkCwFvnpejW/KGvdaDA31b+sw
DQYJKoZIhvcNAQELBQADggEBACMny/9Y1OPK7qwiBKBMt478eBgXnTlJ0J0HNebYcxN/l7fKIKMb
/eX/AQKIDsHeshmV2ekPU4yY/04veXx3QTgmE1bb4ksKEFEbU0LXlVPrnlgNn8M75cPymegn/2yU
r1+htd2eve3obmKc5Lrl0GP+4m72XxAOL687Aw5vRa4Lf294s+x4d+VRwUjoFTj9zyLhexWQuJv/
yX1HjSkrlIsRwi6DN0/ieL04O9aD1UNPlCC6akGnv4tgwlESh51M564qhonlfSW6La+L/aTIuQc0
88lq8s/VMBBGdc7176/v5TbNwEC/c5QYbp2n76rAmKKjhjwWmBk64yLT7CoIxk0xggJvMIICawIB
ATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypH
bG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDCUMagLNLily51ao1jAN
BglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQggBEFQAH9YLUFYNStBiFLHxTGsYuOUKK9
/FrHPWRvKMEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMTE5
MTc0NDIzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBAG4Q9HMeBjM9DwbsSzRm7gLHu2ddOpWi1nrUCHVFjarRjfJ9OG5v
TLylY7noZBoOlxKcyZwp4EVepfGWjt/R1X1qGb1LLe6nYv4Tn4QSBAgpXNSPeU1ndcdvRhWyOYv3
UznBeM7fpF31b2w3GPM2YLD5lWZtDjwZUL46sNsLwEpgUVrY1K++S4TEKx5FpgIWnqdFKcgvYWZ3
QstVzXyGr4mmJquQAzT+ZNsiCi/kXpfZ3tNQpM/6XrGIzHDtn0MFNxoSe374egXWzT9Wu/gmJ9EZ
HyTUpphI6BTEbXNpdBh8bdSKCw6k+vNWUMLFYBjPfeHQ1CaUFSGIhouKtYpuaoI=
--000000000000a15aa005b9446363--
