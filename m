Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035B92ADABE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgKJPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgKJPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:46:55 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F00C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:46:54 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d3so219711plo.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=H0X+D7jxivM/vho5ojSYSsQ9iRJ4qIo61hDUEtMkSNg=;
        b=YQvwkTj0GcqeHLx4TJxbvlPp6AYKBzlPseru5gxxAYu02qRbmAl6NSsNstNZBuzBH5
         DPqcE6bUZZfxXItseqGSYZaydCFYNEf8bHpu7iJcfpjq8nCEoxFJz9rV+KIoTtD5sG85
         Pif8jcMIS8HT/O4FuLBBqS4Je1hl/q7GcNmak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=H0X+D7jxivM/vho5ojSYSsQ9iRJ4qIo61hDUEtMkSNg=;
        b=FetJ7GrFKlTqvg1T4emQ+HNR8ow9SuuZ9M3HS8qmTI0biJjzihk1GqRyEEVXtR3ozD
         ivyTc//oJLH7HhSwAWsAgxr+/cYQvWS8zb1wuCH+vyhpmYVcT5uwn65xzaR0QRzmkhwf
         bSd1zoy2KmWSpLNEYzXD3XgLojVMvxeIeBwAwijPQPFSH8yv2tSUSmXXhD5nXd6pOfZS
         HAcLnDM53iOh+4SV072511AbykGMw+9FeHlfezMJsWCZXgXU3CiO3U/mc8aEq/Uzbjlt
         Y0I3qNsPe2qAK2PkxXgpcbn0iYc9+FID5qVNbq01pCBY5+vazAfixxg60vyIuAcRK18N
         bK0A==
X-Gm-Message-State: AOAM5308rhZZOAx+jPxLzY13DFRWEnN9vDmRP//0RL+q5NB6pyc5LKvT
        Uo+GJnJJZw/7okNtNTiKD8bTzA==
X-Google-Smtp-Source: ABdhPJyVv7mAVbHytcrX6jYpvPKjPhw3qyLGA6KDVRSaGvURCpg0bNRfsAGBnuiZByd/gfa/O1l65g==
X-Received: by 2002:a17:902:8649:b029:d7:c483:b1e7 with SMTP id y9-20020a1709028649b02900d7c483b1e7mr16861877plt.80.1605023214096;
        Tue, 10 Nov 2020 07:46:54 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id e14sm13229616pgv.64.2020.11.10.07.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 07:46:53 -0800 (PST)
Subject: Re: [PATCH 05/10] ARM: dts: BCM5301X: Provide defaults ports
 container node
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kurt Kanzenbach <kurt@kmk-computers.de>
References: <20201110033113.31090-1-f.fainelli@gmail.com>
 <20201110033113.31090-6-f.fainelli@gmail.com>
 <5c424006-90ea-aee3-db2e-96b3a627a4a6@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <e711ac85-5826-4a49-ee21-e80d27acb38c@broadcom.com>
Date:   Tue, 10 Nov 2020 07:46:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <5c424006-90ea-aee3-db2e-96b3a627a4a6@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000091021405b3c296c1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000091021405b3c296c1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 11/10/2020 1:31 AM, Rafał Miłecki wrote:
>  10.11.2020 04:31, Florian Fainelli wrote:
>> Provide an empty 'ports' container node with the correct #address-cells
>> and #size-cells properties. This silences the following warning:
>>
>> arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dt.yaml:
>> ethernet-switch@18007000: 'oneOf' conditional failed, one must be fixed:
>>          'ports' is a required property
>>          'ethernet-ports' is a required property
>>          From schema:
>> Documentation/devicetree/bindings/net/dsa/b53.yaml
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   arch/arm/boot/dts/bcm5301x.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi
>> b/arch/arm/boot/dts/bcm5301x.dtsi
>> index 807580dd89f5..89993a8a6765 100644
>> --- a/arch/arm/boot/dts/bcm5301x.dtsi
>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>> @@ -489,6 +489,10 @@ srab: ethernet-switch@18007000 {
>>           status = "disabled";
>>             /* ports are defined in board DTS */
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +        };
> 
> You can drop those two lines from board files now I believe.
> 
> grep "ports {" arch/arm/boot/dts/bcm470*
> + arch/arm/boot/dts/bcm953012er.dts

Yes, indeed, thanks!
-- 
Florian

--00000000000091021405b3c296c1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NBgcnL8bS1GD7jRZUdtUvDm/XhPjv+5arhlrB5NmaKDsRaobcoQ0vtEyAnImSb64+wEvXgPF3y7V
0LCIoQMCAwEAAaOCAdQwggHQMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNV
HQ4EFgQUjDSG6itHmsBGYhab0ncHg6PidD0wDQYJKoZIhvcNAQELBQADggEBAJD+OK9GMwW86kdo
oTOaDH8VAbGtc3cvxHH/zTSRaq+XQOUwzXeB35AgKQ7VnnW+AYsU0NILbJUrAUGctIt4fMgPi+fZ
1SJxTyzKxS0LCahS3l9aL3TEWyFOnDurmKeLcgVG5qMVXysLYDXiUGGg1I/zmOHefpv30RDNdUjD
9oUbBggB6IHlL4Y6x21gV6Cduse0xOgMrY+dXhntQimTLmuPz0b3uUVJNdtTqVG5pZwZZ/cjsGCm
QTlT5kx0VnHRHhYKS+1b2usAYk+pec77Wth9xL1gsEGVh4JmIdQpkhqGHA/m2nVkhW/WbbFsA7Im
9CNMvmz2hVgGGipcf47g+EsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0g
U0hBMjU2IC0gRzMCDE64Wkk+BtY98mx37TANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQx
IgQg5EjPiIWXHvMM5WVHgGQkZHzU46m1mwEpNq12vNSwaNgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMTEwMTU0NjU0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEB
CjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADN+ee+Qvgl5661V
HjiHoG03eXhwt2GsQ0GwWdXWk/ChbghzY63ZbjCb0eoc2QTxklmqak/ZLz1UQShMN/FAplIzdgD6
4k/SzIKA4KvZWLIo4MzoFTQURzIa9wKLP3aURXKY5gArTPAVV+20SlQS5P96ztbN0h3l4BqQZdSF
QS69VXrgNMg3vPed8yPDMpOlANOAfX9oqlow7jSVyukTJ+EeCcJo4Fz3fQHoA63Sq1ElmwvA3alq
QjOZ7UtBGLzXTi0SwKHyqAdSzZmf2jfnQDB1EhSm59hsZ8khfmLX8cxfr3Td2SHwfwoThm4bGUQd
dV9UTZuM3OAQjAMGtvk45NE=
--00000000000091021405b3c296c1--
